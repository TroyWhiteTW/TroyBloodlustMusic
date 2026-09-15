--[[-------------------------------------------------------------------
--  TroyBloodlustMusic
--  Authored by Troy / 作者：Troy
--  Inspired by OhnoBloodlust by Cladhaire (jnwhiteh)
--  原始概念啟發自 Cladhaire (jnwhiteh) 的 OhnoBloodlust
-------------------------------------------------------------------]]--

---@class TroyBloodlustMusic: AddonCore
---@field soundManifest string[] Set by sounds/sounds.lua, loaded before this file via TOC order / 由 sounds/sounds.lua 設定，TOC 載入順序保證在此檔之前
local addon = select(2, ...)

local L = addon.L

local RANDOM_KEY = "RANDOM"
local DEFAULT_CHANNEL = "Master"
local SOUNDS_PATH = "Interface\\AddOns\\TroyBloodlustMusic\\sounds\\"

-- Detects the 10min Sated/Exhaustion-family debuffs rather than the 40s haste buffs:
-- every Bloodlust source (class, pet, drums) applies one of these, so new sources are
-- covered without new IDs. The "faded" message therefore fires when the debuff ends.
-- 偵測 10 分鐘的 Sated/Exhaustion 系疲勞 debuff，而非 40 秒加速 buff：
-- 所有嗜血來源（職業、寵物、戰鼓）都會掛上其中之一，新來源不必補 ID。
-- 「消退」訊息因此在 debuff 結束時發出。
local BLOODLUST_DEBUFFS = {
    [57723]  = true, -- Exhaustion: Heroism (Shaman, Alliance); drums (tooltip says Exhausted)
    [57724]  = true, -- Sated: Bloodlust (Shaman, Horde); Harrier's Cry (Hunter, tooltip says Sated)
    [80354]  = true, -- Temporal Displacement: Time Warp (Mage)
    [264689] = true, -- Fatigued: Primal Rage (Hunter pet)
    [390435] = true, -- Exhaustion: Fury of the Aspects (Evoker)
    [95809]  = true, -- Insanity: Ancient Hysteria (Hunter pet, legacy)
    [160455] = true, -- Fatigued: Netherwinds (Hunter pet, legacy)
}

function addon:Initialize()
    self.soundRegistry = {
        [RANDOM_KEY] = {
            name = L["Random: A random sound each time"],
            sort_rank = 0,
        },
    }

    self.randomChoices = {}
    for _, filename in ipairs(self.soundManifest or {}) do
        self.soundRegistry[filename] = {
            -- Show the filename as-is; files differing only by extension stay distinguishable
            -- 直接顯示完整檔名，僅副檔名不同的檔案也能區分
            name = filename,
            file = SOUNDS_PATH .. filename,
        }
        table.insert(self.randomChoices, filename)
    end

    self.channelRegistry = {
        ["Master"] = L["Master"],
        ["Music"] = L["Music"],
        ["SFX"] = L["SFX"],
        ["Ambience"] = L["Ambience"],
        ["Dialog"] = L["Dialog"],
    }

    self.defaults = {
        profile = {
            enabled = true,
            sound = RANDOM_KEY,
            channel = DEFAULT_CHANNEL,

            chat = false,
        }
    }

    self.db = LibStub("AceDB-3.0"):New("TroyBloodlustMusicDB", self.defaults, true)

    -- A saved sound no longer in the manifest falls back to Random,
    -- so the dropdown shows a real value and playback never goes silent
    -- 儲存的音效已不在清單時退回隨機，避免下拉選單空白、播放靜默
    if not self.soundRegistry[self.db.profile.sound] then
        self.db.profile.sound = RANDOM_KEY
    end
end

function addon:Enable()
    self:SetupOptions()
    self:RegisterUnitEvent("UNIT_AURA", "UNIT_AURA", "player")
    self:RegisterEvent("PLAYER_REGEN_ENABLED", "PLAYER_REGEN_ENABLED")
    self:RegisterEvent("PLAYER_ENTERING_WORLD", "PLAYER_ENTERING_WORLD")
end

--[[-------------------------------------------------------------------
--  Settings data / 設定資料
--    Sorted {key, name} lists for the settings dropdowns.
--    供設定下拉選單使用的已排序 {key, name} 清單。
-------------------------------------------------------------------]]--

function addon:GetSoundOptions()
    local options = {}
    for key, entry in pairs(self.soundRegistry) do
        table.insert(options, { key = key, name = entry.name, rank = entry.sort_rank or 1 })
    end
    table.sort(options, function(a, b)
        if a.rank ~= b.rank then
            return a.rank < b.rank
        end
        return a.name:lower() < b.name:lower()
    end)
    return options
end

function addon:GetChannelOptions()
    local options = {}
    for key, name in pairs(self.channelRegistry) do
        table.insert(options, { key = key, name = name })
    end
    table.sort(options, function(a, b) return a.name < b.name end)
    return options
end

--[[-------------------------------------------------------------------
--  Detection / 偵測
-------------------------------------------------------------------]]--

function addon:PLAYER_ENTERING_WORLD()
    -- Suppress playback for one frame so a debuff already present at login/reload does not trigger
    -- 抑制一個 frame 的播音，避免登入／重載時已存在的 debuff 誤觸
    self.suppressSound = true
    C_Timer.After(0, function()
        self.active = self:HasBloodlustDebuff()
        self.suppressSound = false
    end)
end

function addon:HasBloodlustDebuff()
    for spellID in pairs(BLOODLUST_DEBUFFS) do
        if C_UnitAuras.GetPlayerAuraBySpellID(spellID) then
            return true
        end
    end
    return false
end

-- State always syncs, even while disabled, so re-enabling never sees stale state;
-- the enabled setting only gates the sound and chat messages
-- 狀態不論是否啟用都同步，重新啟用時不會殘留舊狀態；enabled 只擋播音與聊天訊息
function addon:UNIT_AURA()
    local hasDebuff = self:HasBloodlustDebuff()

    if hasDebuff and not self.active then
        self:StartBloodlust()
    elseif not hasDebuff and self.active then
        self:StopBloodlust()
    end
end

function addon:PLAYER_REGEN_ENABLED()
    -- Re-sync active state after combat ends; UNIT_AURA may be throttled or missed during combat
    -- 戰鬥結束後重新同步 active 旗標；戰鬥中 UNIT_AURA 可能因節流而漏失
    self.active = self:HasBloodlustDebuff()
end

-- "%s" guards against '%' in translations breaking string.format / "%s" 避免翻譯含 % 時 string.format 出錯
local function announce(self, message)
    if self.db.profile.chat then
        self:Printf("%s", message)
    end
end

function addon:StartBloodlust()
    self.active = true

    if self.suppressSound or not self.db.profile.enabled then return end

    announce(self, L["Bloodlust detected!"])
    self:PlayConfiguredSoundAndChannel()
end

function addon:StopBloodlust()
    self.active = false

    if not self.db.profile.enabled then return end

    announce(self, L["Bloodlust debuff has faded"])
end

--[[-------------------------------------------------------------------
--  Playback / 播放
-------------------------------------------------------------------]]--

function addon:GetRandomSoundFile()
    local choices = self.randomChoices
    local count = #choices
    if count == 0 then return nil end

    local index
    if count > 1 and self.lastRandomIndex then
        -- Draw from the other n-1 tracks to avoid immediate repeats, keeping uniform distribution
        -- 從其餘 n-1 首中均勻抽選以避免連續重複同曲
        index = math.random(count - 1)
        if index >= self.lastRandomIndex then
            index = index + 1
        end
    else
        index = math.random(count)
    end
    self.lastRandomIndex = index
    return self.soundRegistry[choices[index]].file
end

function addon:PlayConfiguredSoundAndChannel()
    ---@diagnostic disable: need-check-nil -- self.db.profile is guaranteed non-nil by AceDB initialization / self.db.profile 由 AceDB 初始化保證非 nil
    local options = self.db.profile
    local channel = options.channel
    -- The Random entry has no file, so it and any missing entry both fall through to a random pick
    -- 隨機項目沒有 file 欄位，與找不到的項目一樣都退回隨機抽選
    local entry = self.soundRegistry[options.sound]
    local soundFile = entry and entry.file or self:GetRandomSoundFile()
    ---@diagnostic enable: need-check-nil

    if self.soundHandle then
        StopSound(self.soundHandle, 500)
        -- Clear even if the next PlaySoundFile fails, so no stale handle is reused
        -- 即使下面播放失敗也先清空，避免重複使用已失效的 handle
        self.soundHandle = nil
    end

    if soundFile and channel then
        local willPlay, soundHandle = PlaySoundFile(soundFile, channel)
        if willPlay then
            self.soundHandle = soundHandle
        end
    end
end

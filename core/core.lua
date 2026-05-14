--[[-------------------------------------------------------------------
--  TroyBloodlustMusic
--  Authored by Troy / 作者：Troy
--  Inspired by OhnoBloodlust by Cladhaire (jnwhiteh)
--  原始概念啟發自 Cladhaire (jnwhiteh) 的 OhnoBloodlust
-------------------------------------------------------------------]]--

---@class TroyBloodlustMusic: AddonCore
local addon = select(2, ...)

local L = addon.L

local RANDOM_KEY = "RANDOM"

local BLOODLUST_DEBUFFS = {
    [57723]  = true, -- Exhaustion: Shaman Heroism (Alliance) — the Alliance counterpart to Bloodlust, same cooldown family; both 57723 and 57724 prevent reuse of the effect
    [57724]  = true, -- Sated: Shaman Bloodlust (Horde)
    [80354]  = true, -- Temporal Displacement: Mage Time Warp
    [95809]  = true, -- Insanity: Hunter pet Ancient Hysteria
    [160455] = true, -- Fatigued: Hunter pet Primal Rage
    [264689] = true, -- Fatigued: Hunter pet Primal Rage (variant)
    [390435] = true, -- Exhaustion: Evoker Fury of the Aspects
}

function addon:Initialize()
    self.soundRegistry = {
        [RANDOM_KEY] = {
            name = L["Random: A random sound each time"],
            sort_rank = 0,
        },
    }

    self.defaultSound = RANDOM_KEY

    local soundsPath = "Interface\\AddOns\\TroyBloodlustMusic\\sounds\\"
    self.randomChoices = {}
    ---@diagnostic disable-next-line: undefined-field -- soundManifest is set by sounds/sounds.lua, loaded before this file via TOC order / soundManifest 由 sounds/sounds.lua 設定，TOC 載入順序保證在此檔之前
    for _, filename in ipairs(self.soundManifest or {}) do
        local name = filename:match("(.+)%.[^.]+$") or filename
        self.soundRegistry[filename] = {
            name = name,
            file = soundsPath .. filename,
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
    self.defaultChannel = "Master"

    self.defaults = {
        profile = {
            enabled = true,
            sound = self.defaultSound,
            channel = self.defaultChannel,

            chat = false,
        }
    }

    self.db = LibStub("AceDB-3.0"):New("TroyBloodlustMusicDB", self.defaults, true)
end

function addon:Enable()
    self:SetupOptions()
    self:RegisterUnitEvent("UNIT_AURA", "UNIT_AURA", "player")
    self:RegisterEvent("PLAYER_REGEN_ENABLED", "PLAYER_REGEN_ENABLED")
    self:RegisterEvent("PLAYER_ENTERING_WORLD", "PLAYER_ENTERING_WORLD")
end

function addon:PLAYER_ENTERING_WORLD()
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

---@diagnostic disable-next-line: unused-local -- event and unit are passed by WoW event dispatch; signature must match / event 和 unit 由 WoW 事件分派傳入，函數簽名必須匹配
function addon:UNIT_AURA(event, unit)
    if not self.db.profile.enabled then return end

    local hasBuff = self:HasBloodlustDebuff()

    if hasBuff and not self.active then
        self:StartBloodlust()
    elseif not hasBuff and self.active then
        self:StopBloodlust()
    end
end

function addon:StartBloodlust()
    self.active = true

    if self.suppressSound then return end

    if self.db.profile.chat then
        self:Printf(L["Bloodlust detected!"])
    end

    self:PlayConfiguredSoundAndChannel()
end

function addon:StopBloodlust()
    self.active = false

    if self.db.profile.chat then
        self:Printf(L["Bloodlust has faded"])
    end
end

function addon:PLAYER_REGEN_ENABLED()
    -- Re-sync active state after combat ends; UNIT_AURA may be throttled or missed during combat
    -- 戰鬥結束後重新同步 active 旗標；戰鬥中 UNIT_AURA 可能因節流而漏失
    self.active = self:HasBloodlustDebuff()
end

function addon:GetRandomSoundFile()
    local choices = self.randomChoices
    if #choices == 0 then return nil end
    local value = choices[math.random(#choices)]
    return self.soundRegistry[value].file
end

function addon:PlayConfiguredSoundAndChannel()
    ---@diagnostic disable: need-check-nil -- self.db.profile is guaranteed non-nil by AceDB initialization / self.db.profile 由 AceDB 初始化保證非 nil
    local options = self.db.profile
    local soundFile

    if options.sound == RANDOM_KEY then
        soundFile = self:GetRandomSoundFile()
    else
        local entry = self.soundRegistry[options.sound]
        soundFile = entry and entry.file
    end
    local channel = options.channel
    ---@diagnostic enable: need-check-nil

    if self.soundHandle then
        StopSound(self.soundHandle, 500)
    end

    if soundFile and channel then
        local willPlay, soundHandle = PlaySoundFile(soundFile, channel)
        if willPlay then
            self.soundHandle = soundHandle
        end
    end
end

local addonName = ...

---@class TroyBloodlustMusic: AddonCore
local addon = select(2, ...)
local L = addon.L

-- Proxy settings read/write addon.db.profile[profileKey] directly; the default comes from addon.defaults
-- 代理設定直接讀寫 addon.db.profile[profileKey]，預設值取自 addon.defaults
local function registerProxySetting(category, proxyKey, profileKey, varType, name)
    return Settings.RegisterProxySetting(
        category,
        string.format("%s_PROXY_%s", string.upper(addonName), proxyKey),
        varType,
        name,
        addon.defaults.profile[profileKey],
        function() return addon.db.profile[profileKey] end,
        function(value) addon.db.profile[profileKey] = value end)
end

local function createCheckbox(category, proxyKey, profileKey, name, tooltip)
    local setting = registerProxySetting(category, proxyKey, profileKey, Settings.VarType.Boolean, name)
    Settings.CreateCheckbox(category, setting, tooltip)
end

-- options: sorted list of {key, name} / options：已排序的 {key, name} 清單
local function createDropdown(category, proxyKey, profileKey, options, name, tooltip)
    local setting = registerProxySetting(category, proxyKey, profileKey, Settings.VarType.String, name)

    local function GetOptions()
        local container = Settings.CreateControlTextContainer()
        for _, option in ipairs(options) do
            container:Add(option.key, option.name)
        end
        return container:GetData()
    end

    Settings.CreateDropdown(category, setting, GetOptions, tooltip)
end

--[[-------------------------------------------------------------------
--  Setup addon options / 設定插件選項
-------------------------------------------------------------------]]--

function addon:SetupOptions()
    local category = Settings.RegisterVerticalLayoutCategory(addonName)

    createCheckbox(
        category,
        "ENABLED",
        "enabled",
        L["Enable Bloodlust detection"],
        L["Turns on the detection of Bloodlust-like effects on your character and playing of custom sounds"]
    )

    createCheckbox(
        category,
        "CHAT",
        "chat",
        L["Show bloodlust detection messages in chat"],
        L["A message will be shown in chat when the addon detects a Bloodlust-like effect and when it fades"]
    )

    createDropdown(
        category,
        "SOUND_FILE",
        "sound",
        self:GetSoundOptions(),
        L["Sound to play"],
        L["The sound to play when a Bloodlust-like effect is detected.\n\nTo add your own sounds, place .ogg or .mp3 files in the sounds folder and add their filenames to sounds\\sounds.lua, then /reload."]
    )

    createDropdown(
        category,
        "SOUND_CHANNEL",
        "channel",
        self:GetChannelOptions(),
        L["Sound channel to use"],
        L["The sound channel to use when playing the sound. The volume of the sound will be affected by your sound options for that channel."]
    )

    local function OnButtonClick()
        self:PlayConfiguredSoundAndChannel()
    end

    local initializer = CreateSettingsButtonInitializer(L["Preview sound"], L["Preview sound"], OnButtonClick, L["Preview the selected sound file on the selected channel"], false)
    Settings.RegisterInitializer(category, initializer)

    Settings.RegisterAddOnCategory(category)
end

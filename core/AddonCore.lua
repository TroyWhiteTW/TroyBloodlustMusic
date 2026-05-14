--[[-------------------------------------------------------------------
--  TroyBloodlustMusic - AddonCore / 插件核心骨架
--  Minimal scaffolding for events, lifecycle, printf, and localization.
--  Addon-specific clean-room implementation; not a general-purpose lib.
--  事件、生命週期、輸出、本地化的最精簡骨架。
--  本插件專屬的乾淨室實作，非通用函式庫。
-------------------------------------------------------------------]]--

local addonName, addon = ...

---@class AddonCore
---@field L table<string,string>
---@field RegisterEvent fun(self: AddonCore, event: string, handler: string|fun(...:any)|nil)
---@field RegisterUnitEvent fun(self: AddonCore, event: string, handler: string|fun(...:any)|nil, ...: string)
---@field RegisterLocale fun(self: AddonCore, locale: string, entries: table<string, string|true>)
---@field Printf fun(self: AddonCore, fmt: string, ...: any)

_G[addonName] = addon

local errorHandler = geterrorhandler()

--[[-------------------------------------------------------------------
--  Localization / 本地化
--    Missing keys fall through to the key itself (cached on first read).
--    RegisterLocale only loads enUS or the client's current locale;
--    `v == true` is a shorthand for "value equals key".
--    缺漏的 key 會 fallback 為 key 本身（首次讀取時快取）。
--    RegisterLocale 僅載入 enUS 或客戶端當前語系；
--    `v == true` 為「value 等於 key」的捷徑。
-------------------------------------------------------------------]]--

addon.L = setmetatable({}, {
    __index = function(t, k)
        rawset(t, k, k)
        return k
    end,
})

function addon:RegisterLocale(locale, entries)
    if locale ~= "enUS" and locale ~= GetLocale() then return end
    for key, value in pairs(entries) do
        self.L[key] = (value == true) and key or value
    end
end

--[[-------------------------------------------------------------------
--  Printf / 輸出
-------------------------------------------------------------------]]--

local PRINT_HEADER = "|cFF33FF99%s|r: "

function addon:Printf(fmt, ...)
    print(string.format(PRINT_HEADER .. fmt, addonName, ...))
end

--[[-------------------------------------------------------------------
--  Event dispatch / 事件分派
--    One handler per event. String handlers resolve to addon[name] at
--    dispatch time, so methods defined after RegisterEvent still bind.
--    Dispatch routes through geterrorhandler() so error reporters
--    (BugSack etc.) can intercept thrown errors.
--    每個事件單一 handler。字串 handler 於分派時 resolve 為 addon[name]，
--    允許「先註冊事件、後定義方法」的順序。
--    分派透過 geterrorhandler() 包裝，讓 BugSack 等插件能接住錯誤。
-------------------------------------------------------------------]]--

local dispatch = {}
local eventFrame = CreateFrame("Frame", addonName .. "EventFrame")

eventFrame:SetScript("OnEvent", function(_, event, ...)
    local handler = dispatch[event]
    if not handler then return end
    if type(handler) == "function" then
        xpcall(handler, errorHandler, event, ...)
    else
        local fn = addon[handler]
        if type(fn) == "function" then
            xpcall(fn, errorHandler, addon, event, ...)
        end
    end
end)

local function bind(event, handler)
    assert(dispatch[event] == nil, "Event already registered: " .. event)
    dispatch[event] = handler or event
end

function addon:RegisterEvent(event, handler)
    bind(event, handler)
    eventFrame:RegisterEvent(event)
end

function addon:RegisterUnitEvent(event, handler, ...)
    bind(event, handler)
    eventFrame:RegisterUnitEvent(event, ...)
end

--[[-------------------------------------------------------------------
--  Initialize/Enable lifecycle / 初始化／啟用生命週期
--    Initialize fires on ADDON_LOADED (saved variables ready).
--    Enable fires on PLAYER_LOGIN (UI ready).
--    If PLAYER_LOGIN already fired before Initialize completes — i.e.
--    the addon was load-on-demand — Enable runs immediately after
--    Initialize, since PLAYER_LOGIN won't fire again.
--    Initialize 於 ADDON_LOADED 觸發（saved variables 就緒）。
--    Enable 於 PLAYER_LOGIN 觸發（UI 就緒）。
--    若 PLAYER_LOGIN 已先觸發（LOD 插件），Initialize 後立即執行 Enable，
--    因為 PLAYER_LOGIN 不會再觸發第二次。
-------------------------------------------------------------------]]--

local function call(name)
    local fn = addon[name]
    if type(fn) == "function" then
        xpcall(fn, errorHandler, addon)
    end
end

local lifecycleFrame = CreateFrame("Frame")
lifecycleFrame:RegisterEvent("ADDON_LOADED")
lifecycleFrame:RegisterEvent("PLAYER_LOGIN")
lifecycleFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1 ~= addonName then return end
        self:UnregisterEvent("ADDON_LOADED")
        call("Initialize")
        if IsLoggedIn() then
            self:UnregisterEvent("PLAYER_LOGIN")
            call("Enable")
        end
    elseif event == "PLAYER_LOGIN" then
        self:UnregisterEvent("PLAYER_LOGIN")
        call("Enable")
    end
end)
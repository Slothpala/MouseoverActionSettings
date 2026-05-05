local _, addonTable = ...
addonTable.events["PLAYER_NOT_MAX_LEVEL_UPDATE"] = false
local CR = addonTable.callbackRegistry

local function GetReachableMaxLevel()
    if GetMaxLevelForPlayerExpansion then
        return GetMaxLevelForPlayerExpansion()
    end
    if GetMaxPlayerLevel then
        return GetMaxPlayerLevel()
    end
end

local function IsPlayerNotMaxLevel(level)
    local playerLevel = level or UnitLevel("player")
    local maxLevel = GetReachableMaxLevel()
    return playerLevel ~= nil and maxLevel ~= nil and playerLevel > 0 and playerLevel < maxLevel
end

local function UpdateStatus(level)
    local isNotMaxLevel = IsPlayerNotMaxLevel(level)
    CR:Fire("PLAYER_NOT_MAX_LEVEL_UPDATE", isNotMaxLevel)
    addonTable.events["PLAYER_NOT_MAX_LEVEL_UPDATE"] = isNotMaxLevel
end

local function OnEvent(self, event, ...)
    local level
    if event == "PLAYER_LEVEL_UP" then
        level = ...
    end

    UpdateStatus(level)
end

local frame = nil

local player_not_max_level_status = {}
function player_not_max_level_status:Start()
    if not frame then
        frame = CreateFrame("Frame")
        frame:SetScript("OnEvent", OnEvent)
    end
    UpdateStatus()
    frame:RegisterEvent("PLAYER_LEVEL_UP")
    frame:RegisterEvent("PLAYER_LEVEL_CHANGED")
    frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    frame:RegisterEvent("UPDATE_EXPANSION_LEVEL")
    frame:RegisterEvent("PLAYER_MAX_LEVEL_UPDATE")
end

function player_not_max_level_status:Stop()
    if not frame then
        return
    end
    frame:UnregisterAllEvents()
end

CR:RegisterStatusEvent("PLAYER_NOT_MAX_LEVEL_UPDATE", player_not_max_level_status)

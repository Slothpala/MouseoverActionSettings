local _, addonTable = ...
local addon = addonTable.addon
addonTable.events["PLAYER_HEALTH_UPDATE"] = false
local CR = addonTable.callbackRegistry

local eventDelay = 0
local healthThreshold = 0.3
local thresholdCurve = nil


local last_isBelowThreshold = false
local function OnEvent()
    local currentHealth = UnitHealth("player")
    local maxHealth = UnitHealthMax("player")
    local healthPerc = currentHealth / maxHealth
    local isBelowThreshold = healthPerc < healthThreshold
    if isBelowThreshold ~= last_isBelowThreshold then
        CR:Fire("PLAYER_HEALTH_UPDATE", isBelowThreshold, eventDelay)
        addonTable.events["PLAYER_HEALTH_UPDATE"] = isBelowThreshold
        last_isBelowThreshold = isBelowThreshold
    end
end

local frame = nil

local health_status = {}
function health_status:Start()
    eventDelay = addon.db.profile.EventDelayTimers.PLAYER_HEALTH_UPDATE
    healthThreshold = addon.db.profile.GlobalSettings.healthThreshold
    if not thresholdCurve then
        thresholdCurve:C_CurveUtil.CreateCurve()
    end
    thresholdCurve:ClearPoints()
    thresholdCurve:SetType(Enum.LuaCurveType.Linear)
    thresholdCurve:AddPoint(0.0, 0)
    thresholdCurve:AddPoint(1.0, 100)
    end
    if not frame then
        frame = CreateFrame("Frame")
        frame:SetScript("OnEvent", OnEvent)
    end
    OnEvent()
    frame:RegisterUnitEvent("UNIT_HEALTH", "player")
    frame:RegisterUnitEvent("UNIT_MAXHEALTH", "player")
end

function health_status:Stop()
    if not frame then
        return
    end
    frame:UnregisterAllEvents()
end

CR:RegisterStatusEvent("PLAYER_HEALTH_UPDATE", health_status)

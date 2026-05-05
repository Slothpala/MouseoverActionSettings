local _, addonTable = ...
local addon = addonTable.addon
addonTable.events["PLAYER_CASTING_EMPOWERED_UPDATE"] = false
local CR = addonTable.callbackRegistry

local eventDelay = 0
local isCastingEmpowered = false

local function UpdateStatus(value)
    isCastingEmpowered = value
    CR:Fire("PLAYER_CASTING_EMPOWERED_UPDATE", isCastingEmpowered, eventDelay)
    addonTable.events["PLAYER_CASTING_EMPOWERED_UPDATE"] = isCastingEmpowered
end

local function OnEvent(_, event)
    if event == "UNIT_SPELLCAST_EMPOWER_START" then
        UpdateStatus(true)
    else
        UpdateStatus(false)
    end
end

local frame = nil

local casting_empowered_status = {}
function casting_empowered_status:Start()
    eventDelay = addon.db.profile.EventDelayTimers.PLAYER_CASTING_EMPOWERED_UPDATE
    if not frame then
        frame = CreateFrame("Frame")
        frame:SetScript("OnEvent", OnEvent)
    end
    frame:RegisterUnitEvent("UNIT_SPELLCAST_EMPOWER_START", "player")
    frame:RegisterUnitEvent("UNIT_SPELLCAST_EMPOWER_STOP", "player")
    frame:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED", "player")
    frame:RegisterUnitEvent("UNIT_SPELLCAST_FAILED", "player")
    frame:RegisterUnitEvent("UNIT_SPELLCAST_FAILED_QUIET", "player")
    OnEvent()
end

function casting_empowered_status:Stop()
    if not frame then
        return
    end
    frame:UnregisterAllEvents()
end

CR:RegisterStatusEvent("PLAYER_CASTING_EMPOWERED_UPDATE", casting_empowered_status)

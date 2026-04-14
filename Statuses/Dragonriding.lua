local _, addonTable = ...
local addon = addonTable.addon
addonTable.events["DRAGONRIDING_UPDATE"] = false
local CR = addonTable.callbackRegistry

local eventDelay = 0
local playerClass = select(2, UnitClass("player"))
local isDruid = playerClass == "DRUID"
local isEvoker = playerClass == "EVOKER"
local GetCollectedDragonridingMounts = C_MountJournal.GetCollectedDragonridingMounts
local GetMountInfoByID = C_MountJournal.GetMountInfoByID
local GetPlayerAuraBySpellID = C_UnitAuras.GetPlayerAuraBySpellID
local IsMounted = IsMounted
local next = next

local function updateDragonriding()
    local isDragonriding = false
    local isDragonridingArea = IsAdvancedFlyableArea() and IsFlyableArea() -- IsAdvancedFlyableArea always returns true indoors...

    if isDragonridingArea then
        if IsMounted() then
            local mountIDs = GetCollectedDragonridingMounts()
            for _, mountID in next, mountIDs do
                local spellID = select(2, GetMountInfoByID(mountID))
                if GetPlayerAuraBySpellID(spellID) then
                    isDragonriding = true
                end
            end
        end
        if isDruid then
            local isTravelForm = GetShapeshiftForm() == 3
            if isTravelForm then
                isDragonriding = true
            end
        end
        if isEvoker then
            local soarID = 430747
            if GetPlayerAuraBySpellID(soarID) then
                isDragonriding = true
            end
        end
    end

    addonTable.events["DRAGONRIDING_UPDATE"] = isDragonriding
    CR:Fire("DRAGONRIDING_UPDATE", isDragonriding, eventDelay)
end

local function OnEvent(self, event, arg1)
    updateDragonriding()
    if event == "PLAYER_ENTERING_WORLD" and arg1 == true then
        C_Timer.After(2, OnEvent)
    end
end

local frame = nil

local dragonriding_status = {}
function dragonriding_status:Start()
    eventDelay = addon.db.profile.EventDelayTimers.DRAGONRIDING_UPDATE
    if not frame then
        frame = CreateFrame("Frame")
        frame:SetScript("OnEvent", OnEvent)
    end
    frame:RegisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED")
    frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    if isDruid then
        frame:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
    end
    updateDragonriding()
end

function dragonriding_status:Stop()
    if not frame then
        return
    end
    frame:UnregisterAllEvents()
end

CR:RegisterStatusEvent("DRAGONRIDING_UPDATE", dragonriding_status)

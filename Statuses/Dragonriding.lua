local _, addonTable = ...
local addon = addonTable.addon
addonTable.events["DRAGONRIDING_UPDATE"] = false
local CR = addonTable.callbackRegistry

local eventDelay = 0

local GetCollectedDragonridingMounts = C_MountJournal.GetCollectedDragonridingMounts
local GetMountInfoByID = C_MountJournal.GetMountInfoByID
local GetPlayerAuraBySpellID = C_UnitAuras.GetPlayerAuraBySpellID
local IsMounted = IsMounted
local next = next 

local function updateDragonriding()
    local isDragonriding = false
    local mountIDs = GetCollectedDragonridingMounts()
    local canFly = IsFlyableArea()
    if IsMounted() and canFly then
        for _, mountID in next, mountIDs do
            local spellID = select(2, GetMountInfoByID(mountID))
            if GetPlayerAuraBySpellID(spellID) then
                isDragonriding = true
            end
        end
    end
    addonTable.events["DRAGONRIDING_UPDATE"] = isDragonriding
    CR:Fire("DRAGONRIDING_UPDATE", isDragonriding, eventDelay)
end

local function OnEvent(self, event)
    updateDragonriding()
    if event == "PLAYER_ENTERING_WORLD" then
        C_Timer.After(2, updateDragonriding)
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
    updateDragonriding()
end

function dragonriding_status:Stop()
    if not frame then
        return
    end
    frame:UnregisterAllEvents()
end

CR:RegisterStatusEvent("DRAGONRIDING_UPDATE", dragonriding_status)
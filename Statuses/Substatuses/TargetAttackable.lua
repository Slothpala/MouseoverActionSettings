local _, addonTable = ...
addonTable.events["TARGET_ATTACKABLE_UPDATE"] = false
local CR = addonTable.callbackRegistry

local function OnEvent()
    local targetAttackable = UnitCanAttack("player", "target")
    CR:Fire("TARGET_ATTACKABLE_UPDATE", targetAttackable)
    addonTable.events["TARGET_ATTACKABLE_UPDATE"] = targetAttackable
end

local frame = nil
local id
local targetAttackable = {}
function targetAttackable:Start()
    if not frame then
        frame = CreateFrame("Frame")
        frame:SetScript("OnEvent", OnEvent ) 
    end
    id = CR:RegisterCallback("TARGET_UPDATE", OnEvent)
    frame:RegisterUnitEvent("UNIT_FACTION", "target")
    OnEvent()
end

function targetAttackable:Stop()
    if not frame then
        return
    end
    frame:UnregisterAllEvents()
    CR:UnregisterCallback("TARGET_UPDATE", id)
end

CR:RegisterStatusEvent("TARGET_ATTACKABLE_UPDATE", targetAttackable)

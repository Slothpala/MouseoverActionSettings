local _, addonTable = ...
addonTable.events["READY_CHECK_UPDATE"] = false
local CR = addonTable.callbackRegistry

local function OnEvent(self, event)
    local isReadyCheck = event == "READY_CHECK"
    CR:Fire("READY_CHECK_UPDATE", isReadyCheck)
    addonTable.events["READY_CHECK_UPDATE"] = isReadyCheck
end

local frame = nil

local readycheck_status = {}
function readycheck_status:Start()
    if not frame then
        frame = CreateFrame("Frame")
        frame:SetScript("OnEvent", OnEvent)
    end
    CR:Fire("READY_CHECK_UPDATE", false)
    frame:RegisterEvent("READY_CHECK")
    frame:RegisterEvent("READY_CHECK_FINISHED")
end

function readycheck_status:Stop()
    if not frame then
        return
    end
    frame:UnregisterAllEvents()
end

CR:RegisterStatusEvent("READY_CHECK_UPDATE", readycheck_status)

local _, addonTable = ...
local CR = addonTable.callbackRegistry

--[[
    Health and mana are secret numbers: an addon cannot compare them, only hand them to the
    renderer. So unlike the other statuses these never report true/false. They fire on every
    change and MouseoverUnit:ApplyAlpha asks NotFullAlpha for an alpha that the client resolves
    itself through a step curve: below full -> notFullAlpha, full -> fullAlpha.
]]
addonTable.notFullAlpha = {}

local MANA = Enum.PowerType.Mana

local function StepCurve(notFullAlpha, fullAlpha)
    local curve = C_CurveUtil.CreateCurve()
    curve:SetType(Enum.LuaCurveType.Step)
    curve:AddPoint(0, notFullAlpha)
    curve:AddPoint(1, fullAlpha)
    return curve
end

-- Secret numbers cannot go through math.max either, but a status bar clamps its value to its
-- minimum, which gives the larger of the two.
local clampBar = CreateFrame("StatusBar")
local function Max(a, b)
    clampBar:SetMinMaxValues(a, 1)
    clampBar:SetValue(b)
    return clampBar:GetValue()
end

function addonTable.NotFullAlpha(sources, notFullAlpha, fullAlpha)
    local alpha = fullAlpha
    for _, sourceAlpha in pairs(sources) do
        alpha = Max(alpha, sourceAlpha(notFullAlpha, fullAlpha))
    end
    return alpha
end

local function NewStatus(event, unitEvents, sourceAlpha)
    addonTable.events[event] = false
    addonTable.notFullAlpha[event] = sourceAlpha

    local frame = nil
    local status = {}
    function status:Start()
        if not frame then
            frame = CreateFrame("Frame")
            frame:SetScript("OnEvent", function()
                CR:Fire(event)
            end)
        end
        for _, unitEvent in ipairs(unitEvents) do
            frame:RegisterUnitEvent(unitEvent, "player")
        end
        frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    end

    function status:Stop()
        if not frame then
            return
        end
        frame:UnregisterAllEvents()
    end

    CR:RegisterStatusEvent(event, status)
end

NewStatus("PLAYER_NOT_FULL_HEALTH_UPDATE", {"UNIT_HEALTH", "UNIT_MAXHEALTH"}, function(notFullAlpha, fullAlpha)
    return UnitHealthPercent("player", true, StepCurve(notFullAlpha, fullAlpha))
end)

-- Mana specifically, not the active power type: it keeps tracking in druid forms,
-- and rage/energy rarely sit at max so they would keep the unit shown forever.
NewStatus("PLAYER_NOT_FULL_MANA_UPDATE", {"UNIT_POWER_UPDATE", "UNIT_MAXPOWER"}, function(notFullAlpha, fullAlpha)
    local maxMana = UnitPowerMax("player", MANA)
    if not issecretvalue(maxMana) and maxMana == 0 then
        return fullAlpha
    end
    return UnitPowerPercent("player", MANA, false, StepCurve(notFullAlpha, fullAlpha))
end)

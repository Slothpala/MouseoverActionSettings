local _, addonTable = ...
local addon = addonTable.addon
addonTable.events["PLAYER_CASTING_HURTFUL_UPDATE"] = false
local CR = addonTable.callbackRegistry

local eventDelay = 0
local isCastingHurtful = false

local function IsHurtfulSpell(spellID)
    if not spellID then
        return false
    end

    if C_Spell and C_Spell.IsSpellHarmful then
        return C_Spell.IsSpellHarmful(spellID)
    end

    if IsHarmfulSpell then
        local spellName
        if C_Spell and C_Spell.GetSpellInfo then
            local spellInfo = C_Spell.GetSpellInfo(spellID)
            spellName = spellInfo and spellInfo.name
        elseif GetSpellInfo then
            spellName = GetSpellInfo(spellID)
        end

        if spellName then
            return IsHarmfulSpell(spellName)
        end
    end

    return false
end

local function UpdateStatus(value)
    isCastingHurtful = value
    CR:Fire("PLAYER_CASTING_HURTFUL_UPDATE", isCastingHurtful, eventDelay)
    addonTable.events["PLAYER_CASTING_HURTFUL_UPDATE"] = isCastingHurtful
end

local function OnEvent(_, event, _, _, spellID)
    if event == "UNIT_SPELLCAST_START" or event == "UNIT_SPELLCAST_CHANNEL_START" then
        UpdateStatus(IsHurtfulSpell(spellID))
    elseif event == "UNIT_SPELLCAST_STOP"
        or event == "UNIT_SPELLCAST_CHANNEL_STOP"
        or event == "UNIT_SPELLCAST_INTERRUPTED"
        or event == "UNIT_SPELLCAST_FAILED"
        or event == "UNIT_SPELLCAST_FAILED_QUIET" then
        UpdateStatus(false)
    else
        UpdateStatus(false)
    end
end

local frame = nil

local casting_hurtful_status = {}
function casting_hurtful_status:Start()
    eventDelay = addon.db.profile.EventDelayTimers.PLAYER_CASTING_HURTFUL_UPDATE
    if not frame then
        frame = CreateFrame("Frame")
        frame:SetScript("OnEvent", OnEvent)
    end
    frame:RegisterUnitEvent("UNIT_SPELLCAST_START", "player")
    frame:RegisterUnitEvent("UNIT_SPELLCAST_STOP", "player")
    frame:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED", "player")
    frame:RegisterUnitEvent("UNIT_SPELLCAST_FAILED", "player")
    frame:RegisterUnitEvent("UNIT_SPELLCAST_FAILED_QUIET", "player")
    frame:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_START", "player")
    frame:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_STOP", "player")
    OnEvent()
end

function casting_hurtful_status:Stop()
    if not frame then
        return
    end
    frame:UnregisterAllEvents()
end

CR:RegisterStatusEvent("PLAYER_CASTING_HURTFUL_UPDATE", casting_hurtful_status)

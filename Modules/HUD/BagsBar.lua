local _, addonTable = ...
local addon = addonTable.addon
local CR = addonTable.callbackRegistry

local mo_unit = {
    Parents = {BagsBar},
    visibilityEvent = "BAGS_BAR_UPDATE",   
    scriptRegions = {
        MainMenuBarBackpackButton,
        BagBarExpandToggle,
        CharacterBag0Slot,
        CharacterBag1Slot,
        CharacterBag2Slot,
        CharacterBag3Slot,
        CharacterReagentBag0Slot,
    },
}

mo_unit = addon:NewMouseoverUnit(mo_unit)

local module = addon:NewModule("BagsBar")

function module:OnEnable()
    local dbObj = addon.db.profile["BagsBar"]
    if dbObj.useCustomDelay then
        mo_unit.delay = dbObj.delay
    end
    mo_unit.minAlpha = dbObj.minAlpha
    mo_unit.maxAlpha = dbObj.maxAlpha
    if dbObj.useCustomAnimationSpeed then
        mo_unit.animationSpeed_In = dbObj.animationSpeed_In
        mo_unit.animationSpeed_Out = dbObj.animationSpeed_Out
    end
    mo_unit.statusEvents = {}
    for event, _ in pairs(addonTable.events) do
        if dbObj[event] then
            table.insert(mo_unit.statusEvents, event)
        end
    end
    for link, value in pairs(dbObj.links) do
        if value == true then
            addon:LinkMouseoverUnit(mo_unit, link)
        end
    end
    mo_unit:Enable()
end

function module:OnDisable()
    mo_unit:Disable()
end

function module:GetMouseoverUnit()
    return mo_unit
end
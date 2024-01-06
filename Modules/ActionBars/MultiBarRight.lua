--[[Action Bar 4]]--
local _, addonTable = ...
local addon = addonTable.addon
local CR = addonTable.callbackRegistry

local mo_unit = {
    Parent = MultiBarRight,
    visibilityEvent = "MULTI_BAR_RIGHT_UPDATE",   
    scriptRegions = {},
    statusEvents = {},
}
for i=1,12 do
    mo_unit.scriptRegions[i] = _G["MultiBarRightButton" .. i]
end

mo_unit = addon:NewMouseoverUnit(mo_unit)

local module = addon:NewModule("MultiBarRight")

function module:OnEnable()
    local dbObj = addon.db.profile["MultiBarRight"]
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
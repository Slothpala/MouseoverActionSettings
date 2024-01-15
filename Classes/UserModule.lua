local _, addonTable = ...
local addon = addonTable.addon

local _G = _G

local function validateInfo(info)           
    local parent = _G[info.Parent]
    if not parent then
        addon:Print("Could not create user module: (" .. info.name .. ") because (" .. info.Parent .. ") could not be found in the global environment")
        return false
    end
    if parent == UIParent then
        --just don't let anyone do this to prevent broken UIs
        addon:Print("Module: (" .. info.name .. ") tried to hide UIParent. The module was prevented from loading.")
        return false
    end
    local scriptRegions = {}
    for _, name in pairs(info.scriptRegions) do
        local scriptRegion
        --[[
            cut words between dots and try to find it in _G
            e.g.  "PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar"
            will be 
            _G["PlayerFrame"]["PlayerFrameContent"]["PlayerFrameContentMain"]["HealthBarArea"]["HealthBar"]
        ]]
        if string.match(name, "%.") then
            local tbl = {}
            for key in string.gmatch(name, "([^%.]+)") do 
                table.insert(tbl, key)
            end
            local frame = _G[tbl[1]]
            local i = 1
            while(frame and i < #tbl) do
                i = i + 1
                frame = frame[tbl[i]]
            end
            scriptRegion = frame
        else
            scriptRegion = _G[name]
        end
        if scriptRegion then
            table.insert(scriptRegions, scriptRegion)
        end
    end
    local valid_info = {
        name = info.name,
        Parent = parent,
        scriptRegions = scriptRegions,
    }
    return valid_info
end

--[[
    info must contain:
    info = {
        name = "", string with the modules name
        Parent = frame, --the parent frame that will be hidden/shown (https://warcraft.wiki.gg/wiki/UIOBJECT_Frame)
        scriptRegions = {}, --list of script regions that will be hooked to do mouseover detection and will show/hide info.Parent (https://warcraft.wiki.gg/wiki/UIOBJECT_ScriptRegion)
    }
]]

function addon:NewUserModule(info)
    local info = validateInfo(info)
    if not info then
        return
    end
    local moduleName = "UserModule_" .. info.name
    local eventName = "USER_MODULE_" .. string.upper(info.name) .. "_UPDATE"
    local mo_unit = {
        Parent = info.Parent,
        visibilityEvent = eventName,
        scriptRegions = info.scriptRegions,
    }
    mo_unit = addon:NewMouseoverUnit(mo_unit)
    
    --if a module with the same name got removed we have to reuse it.
    local module = addon:GetModule(moduleName, true)
    if not module then
        module = addon:NewModule(moduleName)
    end

    module.OnEnable = function()
        local dbObj = addon.db.profile[moduleName]
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

    module.OnDisable = function()
        mo_unit:Disable()
    end

    module.GetMouseoverUnit = function()
        return mo_unit
    end

    self:CreateUserModuleEntry(moduleName)
    
    return module
end
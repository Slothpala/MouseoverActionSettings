local addonName, addonTable = ...
local addon = addonTable.addon
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local ACD = LibStub("AceConfigDialog-3.0")

local user_modules = {}

--to fetch newly created/removed modules
local function reloadOptionsFrame()
    local frame = addon:GetOptionsFrame()
    frame.container:ReleaseChildren()
    ACD:Open("MouseOverActionSettings_Options_Tab_3", frame.container)
end

function addon:LoadUserModules()
    for _, userModule in pairs(self.db.global.UserModules) do
        local info = {
            name = userModule.name,
            Parent = userModule.parentName,
            scriptRegions = userModule.scriptRegionNames, 
        }
        local module = self:NewUserModule(info)
        user_modules[userModule.name] = module
    end
end

function addon:CreateUserModule(name)
    local userModule = self.db.global.UserModules[name]
    local info = {
        name = userModule.name,
        Parent = userModule.parentName,
        scriptRegions = userModule.scriptRegionNames, 
    }
    local module, moduleName = self:NewUserModule(info)
    module:Enable()
    user_modules[userModule.name] = module
    reloadOptionsFrame()
end

function addon:RemoveUserModule(name)
    local moduleName = "UserModule_" .. name
    if user_modules[name] then
        user_modules[name]:Disable()
    end
    self.db.profile[moduleName] = nil    
    self.db.global.UserModules[name] = nil
    self:RemoveUserModuleEntry(moduleName)
    reloadOptionsFrame()
end

function addon:IterateUserModules(callback)
    for name, module in pairs(user_modules) do 
        callback(module)
    end
end

function addon:GetUserModule(name)
    return user_modules[name]
end


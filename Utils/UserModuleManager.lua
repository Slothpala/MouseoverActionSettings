local addonName, addonTable = ...
local addon = addonTable.addon
local ACD = LibStub("AceConfigDialog-3.0")

local user_modules = {}
local pending_user_modules = {}
local load_attempt = 0
local MAX_LOAD_ATTEMPTS = 10
local RETRY_DELAY = 1

--to fetch newly created/removed modules
local function reloadOptionsFrame()
    local frame = addon:GetOptionsFrame()
    frame.container:ReleaseChildren()
    ACD:Open("MouseOverActionSettings_Options_Tab_3", frame.container)
end

local function getUserModuleInfo(userModule)
    return {
        name = userModule.name,
        Parents = userModule.parentNames,
        scriptRegions = userModule.scriptRegionNames,
    }
end

local function loadModuleDefinitions(modules, printErrors)
    local createdModules = {}
    local unresolvedModules = {}
    for _, userModule in pairs(modules) do
        local info = getUserModuleInfo(userModule)
        local module, moduleName = addon:NewUserModule(info, printErrors)
        if module then
            user_modules[userModule.name] = module
            createdModules[#createdModules + 1] = {
                module = module,
                moduleName = moduleName,
                userModule = userModule,
            }
        else
            unresolvedModules[userModule.name] = userModule
        end
    end
    return createdModules, unresolvedModules
end

local function enableCreatedModules(createdModules)
    for i = 1, #createdModules do
        local entry = createdModules[i]
        if addon.db.profile[entry.moduleName].enabled then
            entry.module:Enable()
        end
    end
end

local function refreshEnabledMouseoverModules()
    for name, module in addon:IterateModules() do
        if module.GetMouseoverUnit and addon.db.profile[name].enabled then
            addon:ReloadModule(name)
        end
    end
end

function addon:LoadUserModules()
    pending_user_modules = {}
    load_attempt = 0
    local modules = {}
    for name, userModule in pairs(self.db.global.UserModules) do
        modules[name] = userModule
    end
    self:LoadPendingUserModules(modules)
end

function addon:LoadPendingUserModules(modules)
    modules = modules or pending_user_modules
    if not next(modules) then
        pending_user_modules = {}
        return
    end

    load_attempt = load_attempt + 1
    local isLastAttempt = load_attempt >= MAX_LOAD_ATTEMPTS
    local shouldPrintErrors = isLastAttempt
    local createdModules, unresolvedModules = loadModuleDefinitions(modules, shouldPrintErrors)
    enableCreatedModules(createdModules)
    if load_attempt > 1 and #createdModules > 0 then
        refreshEnabledMouseoverModules()
    end

    if not next(unresolvedModules) then
        pending_user_modules = {}
        return
    end

    pending_user_modules = unresolvedModules
    if isLastAttempt then
        for _, userModule in pairs(unresolvedModules) do
            local info = getUserModuleInfo(userModule)
            self:NewUserModule(info, false)
        end
        return
    end

    C_Timer.After(RETRY_DELAY, function()
        addon:LoadPendingUserModules()
    end)
end

function addon:CreateUserModule(name)
    local userModule = self.db.global.UserModules[name]
    if not userModule then
        reloadOptionsFrame()
        return
    end
    local info = getUserModuleInfo(userModule)
    local module, moduleName = self:NewUserModule(info, false)
    if module then
        module:Enable()
        user_modules[userModule.name] = module
    end
    reloadOptionsFrame()
end

function addon:RemoveUserModule(name)
    local moduleName = "UserModule_" .. name
    if user_modules[name] then
        user_modules[name]:Disable()
    end
    user_modules[name] = nil
    pending_user_modules[name] = nil
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

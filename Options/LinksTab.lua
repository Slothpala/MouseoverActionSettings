local addonName, addonTable = ...
local addon = addonTable.addon
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local options = {
    name = "Links",
    handler = addon,
    type = "group",
    args = {

    },
}

function addon:GetLinksTabOptions()
    return options
end

function createLinkGroup(module_name, enabled_mouseover_modules)
    local linkGroup = {
        name = L["Show"] .. " " .. L[module_name] .. " " .. L["alongside"] .. "...",
        type = "group",
        inline = true,
        args = {},
    }
    for name, module in pairs(enabled_mouseover_modules) do
        if name ~= module_name then
            linkGroup.args[name] = {
                name = "..." .. L[name], --locale
                type = "toggle",
                get = "GetLinkStatus",
                set = "SetLinkStatus",
            }
        end
    end
    return linkGroup
end

function addon:CreateLinkGroupEntrys()
    options.args = {} --this will hide since disabled modules
    local enabled_mouseover_modules = {}
    for name, module in self:IterateModules() do
        if module.GetMouseoverUnit and self:IsModuleEnabled(name) then
            enabled_mouseover_modules[name] = module
        end
    end
    for name, module in pairs(enabled_mouseover_modules) do
        local linkGroup = createLinkGroup(name, enabled_mouseover_modules)
        options.args[name] = linkGroup
    end
end

function addon:GetLinkStatus(info)
    local module_name = info[#info-1]
    local link = info[#info]
    return self.db.profile[module_name].links[link]
end

function addon:SetLinkStatus(info, value)
    local module_name = info[#info-1]
    local link = info[#info]
    self.db.profile[module_name].links[link] = value
    self:ReloadModule(module_name)
end
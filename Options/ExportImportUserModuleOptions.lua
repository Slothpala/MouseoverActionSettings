local addonName, addonTable = ...
local addon = addonTable.addon
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local LibDeflate = LibStub:GetLibrary("LibDeflate")

local tmp = {
    import_input_txt = "",
    export_output_txt = "",
}

local function peekModuleName(input)
    if not input or input == "" then
        return nil
    end
    local decoded = LibDeflate:DecodeForPrint(input)
    if not decoded then return nil end
    local uncompressed = LibDeflate:DecompressZlib(decoded)
    if not uncompressed then return nil end
    local valid, moduleData = addon:Deserialize(uncompressed)
    if valid and moduleData and moduleData.name then
        return moduleData.name
    end
    return nil
end

function addon:ExportUserModule(name)
    local moduleData = self.db.global.UserModules[name]
    if not moduleData then
        return ""
    end
    local serialized = self:Serialize(moduleData)
    local compressed = LibDeflate:CompressZlib(serialized)
    local encoded = LibDeflate:EncodeForPrint(compressed)
    return encoded
end

function addon:ImportUserModule(input)
    if input == "" then
        self:Print(L["import_module_empty_string_error"])
        return
    end
    local decoded = LibDeflate:DecodeForPrint(input)
    if decoded == nil then
        self:Print(L["import_module_decoding_failed_error"])
        return
    end
    local uncompressed = LibDeflate:DecompressZlib(decoded)
    if uncompressed == nil then
        self:Print(L["import_module_uncompression_failed_error"])
        return
    end
    local valid, moduleData = self:Deserialize(uncompressed)
    if not valid or not moduleData or not moduleData.name or not moduleData.parentNames then
        self:Print(L["import_module_invalid_error"])
        return
    end
    self.db.global.UserModules[moduleData.name] = moduleData
    self:CreateUserModule(moduleData.name)
end

-- Export popup options
local export_module_options = {
    name = L["export_module_name"],
    handler = addon,
    type = "group",
    args = {
        export_output = {
            order = 1,
            width = "full",
            name = L["export_module_input_name"],
            desc = L["export_module_input_desc"],
            type = "input",
            multiline = 8,
            get = function()
                return tmp.export_output_txt
            end,
            set = function() end,
        },
    },
}

-- Import popup options
local import_module_options = {
    name = L["import_module_name"],
    handler = addon,
    type = "group",
    args = {
        import_input = {
            order = 1,
            width = "full",
            name = L["import_module_input_name"],
            desc = L["import_module_input_desc"],
            type = "input",
            multiline = 8,
            set = function(self, input)
                tmp.import_input_txt = input
            end,
            get = function()
                return tmp.import_input_txt
            end,
        },
        button = {
            order = 2,
            disabled = function()
                return string.len(tmp.import_input_txt) < 1
            end,
            name = L["import_module_button_txt"],
            type = "execute",
            width = 1,
            func = function()
                addon:ImportUserModule(tmp.import_input_txt)
                tmp.import_input_txt = ""
                local popUpFrame = addon:GetPopUpFrame()
                popUpFrame:Hide()
            end,
            confirm = function()
                local name = peekModuleName(tmp.import_input_txt)
                if name then
                    return L["import_module_confirm_msg"] .. "\n\n" .. L["name_input_name"] .. " " .. name
                end
                return L["import_module_confirm_msg"]
            end,
        },
    },
}

function addon:SetExportText(text)
    tmp.export_output_txt = text
end

function addon:GetExportModuleOptions()
    return export_module_options
end

function addon:GetImportModuleOptions()
    return import_module_options
end

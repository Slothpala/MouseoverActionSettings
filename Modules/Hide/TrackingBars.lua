--[[
    Created by Slothpala 
--]]
local HideTrackingBars = MouseoverActionBars:NewModule("HideTrackingBars")
local TrackingBars = {}

function HideTrackingBars:OnEnable()
    TrackingBars = MouseoverActionBars:NewHideUnit(TrackingBars)
    TrackingBars.Name = "HideTrackingBars"
    TrackingBars.Components = {
        StatusTrackingBarManager
    }
    MouseoverActionBars:Hide(TrackingBars)
end

function HideTrackingBars:OnDisable()
    MouseoverActionBars:Show(TrackingBars)
end
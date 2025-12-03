# **Changelog**
### Version [1.12.0-Midnight-Beta2] - 2025-11-16
#### Updated
* Changed the addons default settings.

### Version [1.12.0-Midnight-Beta] - 2025-11-14
#### Updated
* Interface version to 120000.

#### Updated
* Renamed the Module MainMenuBar to MainActionBar to adapt to UI changes.

#### Removed
* Health based trigger as it is no longer possible with the Midnight API changes.
### Version [1.11.1] - 2025-10-12
#### Updated
* Interface version to 110205.

### Version [1.11.0] - 2025-09-21
#### Added
* New Status: Casting.

### Version [1.10.2] - 2025-08-07
#### Updated
* Interface version to 110200.

### Version [1.10.1] - 2025-06-23
#### Updated
* Interface version to 110107.

### Version [1.10.0] - 2025-05-13
#### Added
* FrameColor skin.
* Action bar font customization.
* New HUD Module: PartyFrames. Contributed by @Selfron

### Version [1.9.5] - 2025-04-30
#### Updated
* Interface version to 110105.

### Version [1.9.4] - 2025-03-11
#### Fixed
* SpellFlyout.lua -> Fixed an nil indexing error.
#### Removed
* FrameColor skin got removed in preparation to an upcoming FrameColor rework.

### Version [1.9.3] - 2025-02-25
#### Updated
* Interface version to 110100.

### Version [1.9.2] - 2024-01-2
#### Updated
* Interface version to 110007.
#### Fixed 
* Fixed a problem where delayed event timers would be prematurely canceled by another event.

### Version [1.9.1] - 2024-10-17
#### Updated
* Health.lua - > Performance improvements by caching the last state.

### Version [1.9.0] - 2024-09-15
#### Added
* Health Status.

### Version [1.8.1] - 2024-09-02
#### Updated
* MainMenuBarVehicleLeaveButton parent is set to UIParent to detach it from the MainMenuBar (Action Bar 1) module.

#### Fixed 
* Fixed a problem where the TargetAttackable status did not work as it should.

### Version [1.8.0] - 2024-08-06
#### Updated
* Small UI improvements.
#### Added
* TargetAttackable Status.

### Version [1.7.8] - 2024-08-06
#### Fixed 
* Fixed some minor issues that prevented the newly added SearchBox from being displayed or loading the wrong content under certain circumstances after closing the Options frame.

### Version [1.7.7] - 2024-08-06
#### Added
* Small UI QOL improvements.
    * Added a handle to resize the options frame vertically.
    * Added a SearchBox that is shown for Action Bars, HUD, and Links tab.

### Version [1.7.6] - 2024-08-01
#### Fixed 
* MicroMenu.lua:
    * Changed SpellbookMicroButton & TalentMicroButton to ProfessionMicroButton & PlayerSpellsMicroButton.
* HideMicroMenu.lua:
    * Changed SpellbookMicroButton & TalentMicroButton to ProfessionMicroButton & PlayerSpellsMicroButton.

### Version [1.7.5] - 2024-07-28
#### Updated
* ChatFrame.lua -> TextToSpeechButton added to ScriptRegions.

### Version [1.7.4] - 2024-07-27
#### Updated
* Renamed Dragonridign to Skyriding inside the UI
* Reworked how the Dragonriding Status works, it now includes Soar and Travel Form.

### Version [1.7.3] - 2024-07-23
#### Updated
* Adapted to tww UI changes.

### Version [1.7.3-alpha] - 2024-07-06
#### Updated
* Adapted to tww UI changes.

### Version [1.7.2] - 2024-06-11
#### Removed
* Removed unused locals

### Version [1.7.1] - 2024-05-27
#### Updated
* Utils/HookRegistry.lua -> Fixed a flaw in the logic that should slightly improve performance when a region got unhooked.

### Version [1.7.0] - 2024-05-08
#### Added
* Utils/AddonColors.lua
* Statuses/Moving.lua -> New status that fires when a player starts/stops moving.

#### Updated
* CreteUserModuleOptions.lua -> The pop up frame will now hide after creating a module in Tinker Zone.
* LinksTab.lua -> Making use of the new AddonColors util.

### Version [1.6.4] - 2024-05-08
#### Updated
* interface version to 100207

### Version [1.6.3] - 2024-05-07
* enUS.lua -> Added color codes to the "create_module_info_field" headlines for a nicer look and better readability.
* UserModulesTab.lua -> added a missing local tag.

### Version [1.6.2] - 2024-03-23
#### Updated
* interface version to 100206

### Version [1.6.1] - 2024-02-28
#### Fixed 
* Dragonriding.lua 
    * DRAGONRIDING_UPDATE now checks if the area is flyable. 
    * DRAGONRIDING_UPDATE now fires on every PLAYER_ENTERING_WORLD event not just the initial login.

### Version [1.6.0] - 2024-02-22
#### Added
* FrameColorSkin.lua - The addon registers a skin in FrameColor if the addon is also loaded.

### Version [1.5.0] - 2024-01-31
#### Added
* PetFrame module

### Version [1.4.1] - 2024-01-29
#### Added
* /fstack button to the Tinker Zones Create Module popup.

### Version [1.4.0] - 2024-01-19
#### Added
* FocusFrame module

### Version [1.3.1] - 2024-01-16
#### Updated
* interface version to 100205

### Version [1.3.0] - 2024-01-16
#### Added
* New feature "Tinker Zone" added as an option for advanced users. This feature allows the user to create custom mouse-over modules.

### Version [1.2.0] - 2024-01-11
#### Added
* UnitExists.lua -> New status with one event for now "TARGET_UPDATE" can be extended to other units as needed.                                                                     

### Version [1.1.0] - 2024-01-08
#### Added 
* TargetFrame module added.

### Version [1.0.2] - 2024-01-08
#### Fixed 
* Unselecting pre-defined triggers now persists throughout a game session.
* The Objective Tracker GUI entry is now independent of the Buff Frame entry.

### Version [1.0.1] - 2024-01-07
#### Changed 
* Addon menu title and minimap button title now have spaces.
* Miscellaneous and Hide changed places in the Config tab.

### Version [1.0.0] - 2024-01-06
#### Added 
* Initial release of MouseoverActionSettings as a replacement for MouseoverActionBars. MouseoverActionSettings has been written from scratch and covers all the functionality of MouseoverActionBars and more.

# **Changelog**^
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

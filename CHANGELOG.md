# Changelog

Notes changes to both the apworld and client after v0.1.0

## v0.1.2 - 2025-12-xx

### Changed

* Added logic for upgrades needed for each boss, effectively setting logic for **ALL** locations.
* Added the following Progressive Item groups:
    * Progressive Boss Damage
    * Progressive Critical Damage
    * Progressive Damage Per Second
    * Progressive Additional Damage
    * Progressive Lifesteal
    * Progressive Blue Spawn
    * Progressive Yellow Spawn
    * Progressive Boss Armor
    * Progressive Red Milestone Reward
    * Progressive Blue Milestone Reward
    * Progressive Yellow Milestone Reward

* Set a whole bunch of item classification for upgrades from `useful` to `progressive`.
* Added Progressive Items to their respective item groups.
* Added `Life Steal` item group and grouped `Life Steal` items in Item List (client).

### Fixes

* Added regions for each boss to logically require upgrades in linear order.
* Fixed inifity goal logic for Progressive Infinity items.

## v0.1.1 - 2025-12-13

### Changed

* Added new death link messages.
* Added a tiny text popup when a deathlink is recieved.
* Censored password field on Connection Screen.
* Added location/region rules to upgrades that need a cores.
* Connecting to a slot will auto-unlock locations to he highest level that they were already checked at.

### Fixes

* Logic fix to properly set rules, regions, and connections.
* Disabling the options for `Crypto Mine`, `Milestones`, and `Boss Drops` will now place the vanilla items while keeping them in logic.
* Added `archipelago.json` manifest file.
* Added support for locally hosted servers (localhost:XXXXX).
* Reconnecting to your last slot now properly reapplies the resources from the save file.
* Deathlink will now check against sending player and last death recieved to prevent multiple sends.
* Added a seperate victory condition for the Infinity goal.

### Client Misc

* Added UUID library for AP client functions.

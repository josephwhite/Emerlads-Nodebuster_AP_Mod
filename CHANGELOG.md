# Changelog

Notes changes to both the apworld and client after v0.1.0

## v0.1.3 - 2026-xx-xx

### Changed

* Added save file functionality.
    * Connecting to a server will check for save files in `user://` with the same seed and player.
    * Saving will occur more frequently.
* Added additional rules for node connections
* Added additional rules to seperate easy milestones from milestones that logically need to be grinded.
* Set item classification of `Progressive SpawnRate` from `useful` to `progressive`.

### Fixes

* Save created UUID to file in `user://` and load UUID from said file, ensuring UUIDs are reused for future server locking feature.

## v0.1.2 - 2025-12-31

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
* Removed `Progressive Milestone Reward` in favor of Red/Blue/Yellow groups.
* Set a bunch of item classification for upgrades from `useful` to `progressive`.
* Added Progressive Items to their respective item groups.
* Added new item groups in Item List (client).

### Fixes

* Added regions for each boss to logically require upgrades in linear order.
* Fixed infinity goal logic for Progressive Infinity items.

## v0.1.1 - 2025-12-13

### Changed

* Added new death link messages.
* Added a tiny text popup when a deathlink is received.
* Censored password field on Connection Screen.
* Added location/region rules to upgrades that need a cores.
* Connecting to a slot will auto-unlock locations to the highest level that they were already checked at.

### Fixes

* Logic fix to properly set rules, regions, and connections.
* Disabling the options for `Crypto Mine`, `Milestones`, and `Boss Drops` will now place the vanilla items while keeping them in logic.
* Added `archipelago.json` manifest file.
* Added support for locally hosted servers (localhost:XXXXX).
* Reconnecting to your last slot now properly reapplies the resources from the save file.
* Deathlink will now check against sending player and last death received to prevent multiple sends.
* Added a separate victory condition for the Infinity goal.

### Client Misc

* Added UUID library for AP client functions.

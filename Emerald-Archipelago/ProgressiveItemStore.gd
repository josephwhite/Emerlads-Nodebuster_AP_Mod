class_name ProgressiveItemStore
extends Node

var modMain: Node


const data: Dictionary = {
	"Progressive Damage": {
		"Damage1":{"start":0,"count":15,"power": 1},
		"Damage2":{"start":15,"count":10,"power": 3},
		"Damage3":{"start":25,"count":10,"power": 6},
		"Damage4":{"start":35,"count":3,"power": 25},
		"Damage5":{"start":38,"count":5,"power": 100},
	},

	"Progressive Additional Damage": {
		"DamagePerEnemy1":{"start":0,"count":5,"power": 1},
		"Undamaged1":{"start":5,"count":6,"power": 1},
		"Execute1":{"start":11,"count":6,"power": 1},
		"Undamaged2":{"start":17,"count":4,"power": 1},
		"Execute2":{"start":21,"count":4,"power": 1},
		"MaxHealthToDamage1":{"start":25,"count":1,"power": 1},
	},

	"Progressive Damage Per Second": {
		"RampingDamage1":{"start":0,"count":3,"power": 1},
	},

	"Progressive Critical Damage": {
		"CritDamage1":{"start":0,"count":10,"power": 50},
		"CritDamage2":{"start":10,"count":8,"power": 200},
	},

	"Progressive Boss Damage": {
		"BossDamage1":{"start":0,"count":10,"power": 50},
		"BossDamage2":{"start":10,"count":10,"power": 100},
	},
	
	"Progressive Health": {
		"Health1":{"start":0,"count":10,"power": 4},
		"Health2":{"start":10,"count":8,"power": 12},
		"Health3":{"start":18,"count":10,"power": 80},
		"Health4":{"start":28,"count":10,"power": 300},
		"Health5":{"start":38,"count":3,"power": 4000},
		"Health6":{"start":41,"count":5,"power": 50000},
		"Health7":{"start":46,"count":5,"power": 100000},
	},
	
	"Progressive Regen": {
		"HealthRegen1":{"start":0,"count":5,"power": 1},
		"HealthRegen2":{"start":5,"count":1,"power": 1},
		"DropHeal1":{"start":6,"count":1,"power": 1},
		"MaxHealthHeal1":{"start":7,"count":10,"power": 1},
		"StealMaxHealth1":{"start":17,"count":1,"power": 1},
		"MaxHealthHeal2":{"start":18,"count":5,"power": 1},
		"StealMaxHealth2":{"start":23,"count":1,"power": 1},
		"StealMaxHealth3":{"start":24,"count":1,"power": 1},
	},

	"Progressive Lifesteal": {
		"Salvaging1":{"start":0,"count":5,"power": 1},
		"Lifesteal1":{"start":5,"count":5,"power": 50},
		"Salvaging2":{"start":10,"count":1,"power": 8},
		"Lifesteal2":{"start":11,"count":3,"power": 1000},
		"Lifesteal3":{"start":14,"count":2,"power": 5000},
	},
	
	"Progressive SpawnRate": {
		"SpawnRate1":{"start":0,"count":15,"power": 50},
		"SpawnRate2":{"start":15,"count":1,"power": 200},
		"SpawnRate3":{"start":16,"count":5,"power": 100},
		"SpawnRate4":{"start":21,"count":5,"power": 400},
	},

	"Progressive Blue Spawn": {
		"NodeFinder1":{"start":0,"count":5,"power": 1},
	},

	"Progressive Yellow Spawn": {
		"YellowSpawn1":{"start":0,"count":1,"power": 1},
		"YellowSpawn2":{"start":1,"count":1,"power": 1},
	},
	
	"Progressive Armor": {
		"Armor1":{"start":0,"count":10,"power": 1},
		"Armor2":{"start":10,"count":5,"power": 1},
		"ArmorPerEnemy1":{"start":15,"count":10,"power": 1},
		"Armor3":{"start":25,"count":10,"power": 1},
		"Armor4":{"start":35,"count":10,"power": 1},
		"Armor5":{"start":45,"count":20,"power": 1},
		"Armor6":{"start":65,"count":30,"power": 1},
		"MaxHealthToArmor1":{"start":95,"count":5,"power": 1},
		"Armor7":{"start":100,"count":5,"power": 1},
		"FocusArmor1":{"start":105,"count":5,"power": 1},
		"MaxHealthToArmor2":{"start":110,"count":1,"power": 1},
		"RampingArmor1":{"start":111,"count":5,"power": 1},
	},

	"Progressive Boss Armor": {
		"BossArmor1":{"start":0,"count":10,"power": 1},
		"BossArmor2":{"start":10,"count":8,"power": 25},
	},
	
	"Progressive Infinity": {
		"Infinity1":{"start":0,"count":1, "power": 1},
		"Infinity2":{"start":1,"count":1, "power": 1},
		"Infinity3":{"start":2,"count":1, "power": 1},
		"Infinity4":{"start":3,"count":1, "power": 1},
		"Infinity5":{"start":4,"count":1, "power": 1},
		"Infinity6":{"start":5,"count":1, "power": 1},
		"Infinity7":{"start":6,"count":1, "power": 1},
		"Infinity8":{"start":7,"count":1, "power": 1},
		"Infinity9":{"start":8,"count":1, "power": 1},
	},
	
	"Progressive Red Milestone Reward": {
		"Reds500":{"start":0,"count":1,"power": 1},
		"Reds2k":{"start" :1,"count":1,"power": 1},
		"Reds4k":{"start": 2,"count":1,"power": 1},
		"Reds6k":{"start": 3,"count":1,"power": 1},
		"Reds8k":{"start": 4,"count":1,"power": 1},
		"Reds10k":{"start": 5,"count":1,"power": 1},
		"Reds15k":{"start": 6,"count":1,"power": 1},
		"Reds20k":{"start": 7,"count":1,"power": 1},
		"Reds30k":{"start": 8,"count":1,"power": 1},
		"Reds50k":{"start": 9,"count":1,"power": 1},
		"Reds100k":{"start": 10,"count":1,"power": 1},
	},

	"Progressive Blue Milestone Reward": {
		"Blues10":{"start":0,"count":1,"power": 1},
		"Blues100":{"start" :1,"count":1,"power": 1},
		"Blues200":{"start": 2,"count":1,"power": 1},
		"Blues300":{"start": 3,"count":1,"power": 1},
		"Blues500":{"start": 4,"count":1,"power": 1},
		"Blues800":{"start": 5,"count":1,"power": 1},
		"Blues1.2k":{"start": 6,"count":1,"power": 1},
		"Blues1.6k":{"start": 7,"count":1,"power": 1},
		"Blues2k":{"start": 8,"count":1,"power": 1},
		"Blues4k":{"start": 9,"count":1,"power": 1},
		"Blues8k":{"start": 10,"count":1,"power": 1},
	},

	"Progressive Yellow Milestone Reward": {
		"Yellows5":{"start": 0,"count":1,"power": 1},
		"Yellows10":{"start": 1,"count":1,"power": 1},
		"Yellows15":{"start": 2,"count":1,"power": 1},
	}
}

var progressive_items: Dictionary = {
	"Progressive Damage": 0,
	"Progressive Additional Damage": 0,
	"Progressive Damage Per Second": 0,
	"Progressive Critical Damage": 0,
	"Progressive Boss Damage": 0,
	"Progressive Health": 0,
	"Progressive Regen": 0,
	"Progressive Lifesteal": 0,
	"Progressive SpawnRate": 0,
	"Progressive Blue Spawn": 0,
	"Progressive Yellow Spawn": 0,
	"Progressive Armor": 0,
	"Progressive Boss Armor": 0,
	"Progressive Infinity": 0,
	"Progressive Red Milestone Reward": 0,
	"Progressive Blue Milestone Reward": 0,
	"Progressive Yellow Milestone Reward": 0
}


func search(itemName) -> String:
	var group = data[itemName]
	for item_name in group.keys():
		var value = group[item_name]
		if progressive_items[itemName] >= value["start"] and progressive_items[itemName] < value["start"] + value["count"]:
			return item_name
	
	return ""


func reset() -> void:
	for group in progressive_items.keys():
		progressive_items[group] = 0

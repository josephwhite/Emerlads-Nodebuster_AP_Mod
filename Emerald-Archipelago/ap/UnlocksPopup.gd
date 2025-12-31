class_name UnlocksPopup
extends PanelContainer

signal back

@onready var back_btn = %BackBtn
@onready var body = %Body

var apClient

var mainMod

var items: Dictionary = {
	"Damage Increase": {},
	"Damage Modifiers": {},
	"Damage Per Second": {},
	"Critical Damage": {},
	"Boss Damage": {},
	"Attack Speed": {},
	"Max Health Increase": {},
	"Health Regen": {},
	"Life Steal": {},
	"SpawnRate Increase": {},
	"Blue Spawn": {},
	"Yellow Spawn": {},
	"Armor Increase": {},
	"Boss Armor": {},
	"Infinity": {},
	"Red Milestone Rewards": {},
	"Blue Milestone Rewards": {},
	"Yellow Milestone Rewards": {},
	"Others": {}
}

const item_groups: Dictionary = {
	"Damage Increase": ["Damage1","Damage2","Damage3","Damage4","Damage5"],
	"Damage Modifiers":["DamagePerEnemy1","Undamaged1","Execute1","Undamaged2","Execute2","MaxHealthToDamage1"],
	"Damage Per Second":["RampingDamage1"],
	"Critical Damage":["CritDamage1","CritDamage2"],
	"Boss Damage":["BossDamage1","BossDamage2"],
	"Attack Speed": ["AttackSpeed1","AttackSpeed2"],
	"Max Health Increase": ["Health1","Health2","Health3","Health4","Health5","Health6","Health7"],
	"Health Regen": ["HealthRegen1","HealthRegen2","DropHeal1","MaxHealthHeal1","StealMaxHealth1","MaxHealthHeal2","StealMaxHealth2","StealMaxHealth3"],
	"Life Steal": ["Salvaging1","Lifesteal1","Salvaging2","Lifesteal2","Lifesteal3"],
	"SpawnRate Increase": ["SpawnRate1","SpawnRate2","SpawnRate3","SpawnRate4"],
	"Blue Spawn": ["NodeFinder1"],
	"Yellow Spawn": ["YellowSpawn1","YellowSpawn2"],
	"Armor Increase": ["Armor1","Armor2","ArmorPerEnemy1","Armor3","Armor4","Armor5","Armor6","MaxHealthToArmor1","Armor7","FocusArmor1","MaxHealthToArmor2","RampingArmor1"],
	"Boss Armor":["BossArmor1","BossArmor2"],
	"Infinity": ["Infinity1","Infinity2","Infinity3","Infinity4","Infinity5","Infinity6","Infinity7","Infinity8","Infinity9"],
	"Red Milestone Rewards": ["Reds500","Reds2k","Reds4k","Reds6k","Reds8k","Reds10k","Reds15k","Reds20k","Reds30k","Reds50k","Reds100k"],
	"Blue Milestone Rewards": ["Blues10","Blues100","Blues200","Blues300","Blues500","Blues800","Blues1.2k","Blues1.6k","Blues2k","Blues4k","Blues8k"],
	"Yellow Milestone Rewards": ["Yellows5","Yellows10","Yellows15"],
	"Others": []
}

func _ready() -> void:
	if back_btn.pressed.is_connected(_back_pressed) == false: back_btn.pressed.connect(_back_pressed)
	var mod_node = get_node("/root/ModLoader/Emerald-Archipelago")
	mainMod = mod_node
	apClient = mod_node.get_child(0)
	_refresh_ui()

func _add_cell(id:String,curr:int,max:int) -> void:
	body.append_text("[cell]%s: %s/%s[/cell]" % [id,curr,max])



func _add_cell_to_table(id:String,curr:int,max:int) -> void:
	for group in item_groups.keys():
		var items_in_group = item_groups[group]
		if id in items_in_group:
			items[group][id] = {"curr":curr,"max":max}
			return
	items["Others"][id] = {"curr":curr,"max":max}


func _refresh_ui() -> void:
	body.clear()
	body.append_text("[center][table=1]")
	# Sorts through every item in the datapackage and figures out how many you have and how many there can be.
	for itemName in apClient._item_id_to_name.values():
		var curr = 0
		var max = 0
		if mainMod.collected_items.has(itemName):
			curr = mainMod.collected_items[itemName]["count"]
		if UpgradeStore.search(itemName) != null:
			var upgrade: Upgrade = UpgradeStore.search(itemName)
			max = upgrade.costs.size()
		# Check if Milestone Item
		elif MilestoneStore.search(itemName) != null:
			var milestone: Milestone = MilestoneStore.search(itemName)
			max = 1
		match itemName:
			"CryptoLevel":
				max = 36
			"Boss Drop":
				max = 26
			"Extra Bits":
				max = 1
			"Extra Nodes":
				max = 1
		if max == 0:
			continue
		_add_cell_to_table(itemName,curr,max)
	
	for group in items:
		if items[group].is_empty():
			continue
		var group_curr: int = 0
		var group_max: int = 0
		for item in items[group]:
			group_curr += items[group][item].curr
			group_max += items[group][item].max
		
		body.append_text("[cell padding=0,0,0,4][color=457af6][font_size=13]%s: %s/%s[/font_size][/color][/cell]" % [group,group_curr,group_max])
		for item in items[group]:
			var curr = items[group][item].curr
			var max = items[group][item].max
			_add_cell(item,curr,max)
	
	body.append_text("[/table][/center]")


func _back_pressed() -> void:
	back.emit()

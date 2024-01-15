extends CanvasLayer

#colours
var green : Color = Color("6bbfa3")
var red : Color = Color("b53321")

@onready var primary_label : Label = $AmmoCounter/HBoxContainer/PrimaryCounter/PrimaryLabel
@onready var secondary_label : Label = $AmmoCounter/HBoxContainer/SecondaryCounter/SecondaryLabel
@onready var laser_icon : TextureRect = $AmmoCounter/HBoxContainer/PrimaryCounter/PrimaryTextureRect
@onready var grenade_icon : TextureRect = $AmmoCounter/HBoxContainer/SecondaryCounter/SecondaryTextureRect

func _ready():
	update_laser_text()
	update_grenade_text()

func update_laser_text():
	primary_label.text = str(Global.laser_amount)
	update_colour(Global.laser_amount, laser_icon, primary_label)

func update_grenade_text():
	secondary_label.text = str(Global.grenade_amount)
	update_colour(Global.grenade_amount, grenade_icon, secondary_label)

func update_colour(ammo_amount : int, icon : TextureRect, label : Label) -> void:
	if (ammo_amount <= 0):
		icon.modulate = red
		label.modulate = red
		ammo_amount = 0
	else:
		icon.modulate = green
		label.modulate = green

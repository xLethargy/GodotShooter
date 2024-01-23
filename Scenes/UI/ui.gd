extends CanvasLayer

#colours
var green : Color = Color("6bbfa3")
var red : Color = Color("b53321")

@onready var primary_label : Label = $AmmoCounter/HBoxContainer/PrimaryCounter/PrimaryLabel
@onready var secondary_label : Label = $AmmoCounter/HBoxContainer/SecondaryCounter/SecondaryLabel
@onready var laser_icon : TextureRect = $AmmoCounter/HBoxContainer/PrimaryCounter/PrimaryTextureRect
@onready var grenade_icon : TextureRect = $AmmoCounter/HBoxContainer/SecondaryCounter/SecondaryTextureRect
@onready var health_bar : TextureProgressBar = $MarginContainer/TextureProgressBar

func _ready():
	Global.connect("health_change", update_health_bar)
	Global.connect("laser_amount_change", update_laser_text)
	Global.connect("grenade_amount_change", update_grenade_text)
	
	update_all()


func update_all():
	update_laser_text()
	update_grenade_text()
	update_health_bar()


func update_laser_text():
	primary_label.text = str(Global.laser_amount)
	update_colour(Global.laser_amount, laser_icon, primary_label)


func update_grenade_text():
	secondary_label.text = str(Global.grenade_amount)
	update_colour(Global.grenade_amount, grenade_icon, secondary_label)


func update_health_bar():
	health_bar.value = Global.health


func update_colour(ammo_amount : int, icon : TextureRect, label : Label) -> void:
	if (ammo_amount <= 0):
		icon.modulate = red
		label.modulate = red
		ammo_amount = 0
	else:
		icon.modulate = green
		label.modulate = green

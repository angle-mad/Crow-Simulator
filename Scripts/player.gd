extends CharacterBody2D

@onready var button: Button = $"../Control/Button"
@onready var player_sprite: Sprite2D = $Player_Sprite
@onready var basket: Area2D = $"../Basket"
var collectables_on_screen
var collectable_count = 0
var berry_held

func _ready() -> void:
	collectables_on_screen = %Collectables.get_child_count()

func _process(_delta: float) -> void:
	if collectable_count == (collectables_on_screen):
		end_screen()
		
	if Input.is_action_just_pressed("left"):
		player_sprite.flip_h = false
		
	if Input.is_action_just_pressed("right"):
		player_sprite.flip_h = true

func _physics_process(_delta: float) -> void:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * 400
	
	move_and_slide()

func _on_pickup_area_area_entered(area):
	if area.is_in_group("Collectable") && !$Held_Collectable.visible:
		berry_held = area
		$Held_Collectable.visible = true
		area.visible = false
		area.remove_from_group("Collectable")
		
	if area.is_in_group("basket") && $Held_Collectable.visible:
		$Held_Collectable.visible = false
		berry_held.visible = true
		collectable_count += 1
		berry_held.global_position = basket.global_position + Vector2(randf_range(-40,40), randf_range(-5,40))
		$CanvasLayer/Collectable_Counter.text = ("Berries: " + str(collectable_count))

func end_screen():
	$CanvasLayer/Collectable_Counter.text = ("You Collected All Berries!!!")
	button.visible = true


func _on_button_button_up() -> void:
		get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")

extends Node2D

var sequence = []  # Последовательность нажатий
var player_input = []  # Ввод игрока
var current_level = 1  # Текущий уровень
var next_to_click = 0  # Индекс следующего ожидаемого нажатия

@onready var game_start = false
@onready var timer = $Timer
@onready var level_label = $"level-label"
@onready var play_button = $"play-btn"
@onready var buttons = [
	$"btn-1", $"btn-2", $"btn-3",
	$"btn-4", $"btn-5", $"btn-6",
	$"btn-7", $"btn-8", $"btn-9"
]

func _on_playbtn_pressed() -> void:
	level_label.show()
	play_button.hide()
	timer.start()
	start_game()

func start_game() -> void:
	game_start = true
	sequence.clear()
	player_input.clear()
	current_level = 1
	next_to_click = 0
	
	add_new_step()
	update_ui()

func add_new_step() -> void:
	var new_step = randi_range(1, 9)
	sequence.append(new_step)
	show_sequence()
	print("Секретная последовательность: ", sequence)
	
func update_ui() -> void:
	level_label.text = str(current_level)

func check_input(button_number: int) -> void:
	if sequence[next_to_click] == button_number:
		next_to_click += 1
		player_input.append(button_number)
		
		if next_to_click == current_level:
			next_level()
	else:
		reset_game()

func next_level() -> void:
	current_level += 1
	next_to_click = 0
	player_input.clear()
	
	add_new_step()
	update_ui()
	
func reset_game() -> void:
	print("Ошибка! Начинаем заново.")
	start_game()

func show_sequence() -> void:
	var delay = 0.5
	
	await get_tree().create_timer(delay).timeout
	for button in buttons:
		button.release_focus()
	await get_tree().create_timer(delay).timeout
	
	for step in sequence:
		var button = buttons[step - 1]
		button.disabled = true
		await get_tree().create_timer(delay).timeout
		button.disabled = false
		await get_tree().create_timer(delay).timeout

func _on_btn_1_pressed() -> void: 
	if (game_start):
		check_input(1)

func _on_btn_2_pressed() -> void: 
	if (game_start):
		check_input(2)

func _on_btn_3_pressed() -> void: 
	if (game_start):
		check_input(3)

func _on_btn_4_pressed() -> void: 
	if (game_start):
		check_input(4)

func _on_btn_5_pressed() -> void: 
	if (game_start):
		check_input(5)

func _on_btn_6_pressed() -> void: 
	if (game_start):
		check_input(6)

func _on_btn_7_pressed() -> void: 
	if (game_start):
		check_input(2)

func _on_btn_8_pressed() -> void: 
	if (game_start):
		check_input(8)

func _on_btn_9_pressed() -> void: 
	if (game_start):
		check_input(9)

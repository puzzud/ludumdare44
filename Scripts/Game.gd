extends Node

func _ready():
	Global.game = self
	
	$Camera.setTarget(Global.player)

func updateHealthBar():
	Global.ui.updateHealthBar(Global.player.health)

func onPlayerDeath():
	Global.ui.onPlayerDeath()
	
	$Timers/PlayerDeathTimer.start()

func onPlayerDeathTimerTimeout():
	get_tree().reload_current_scene()

func _on_Player_generate_map(z_pos):
	var z_offset = -(15 + z_pos)
	
	#Create floor
	$Map/Floor.set_cell_item(-3,-1,z_offset,0)
	$Map/Floor.set_cell_item(-2,-1,z_offset,0)
	$Map/Floor.set_cell_item(-1,-1,z_offset,0)
	$Map/Floor.set_cell_item(0,-1,z_offset,0)
	$Map/Floor.set_cell_item(1,-1,z_offset,0)
	
	#Create Trees
	var rand = randi() % 2
	if rand > 0:
		$Map/Floor.set_cell_item(-3,0,z_offset,2)
	rand = randi() % 2
	if rand > 0:
		$Map/Floor.set_cell_item(1,0,z_offset,2)

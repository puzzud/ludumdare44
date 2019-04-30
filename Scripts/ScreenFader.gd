extends Control

signal fadeInFinished
signal fadeOutFinished

func _ready():
	pass

func onAnimationPlayerAnimationFinished(anim_name):
	if anim_name == "fadeIn":
		emit_signal("fadeInFinished")
	elif anim_name == "fadeOut":
		emit_signal("fadeOutFinished")

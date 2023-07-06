extends Area2D



func _on_body_entered(body):
	if body.name == "Player":
		Game.Gold += 5
		var tween1 = get_tree().create_tween()
		var tween2 = get_tree().create_tween()
		tween1.tween_property(self, "position", position - Vector2(0, 20), .5)
		tween2.tween_property(self, "modulate:a", 0, .25)
		tween1.tween_callback(queue_free)
		

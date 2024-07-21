extends Node

func rand_Vector2():
   var new_dir = Vector2()
   new_dir.x = randf_range(-1, 1)
   new_dir.y = randf_range(-1, 1)
   return new_dir.normalized()

func wait(seconds: float):
  await get_tree().create_timer(seconds).timeout

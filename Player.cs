using Godot;
using System;

public class Player : Area2D
{
	// Declare member variables here. Examples:
	// private int a = 2;
	// private string b = "text";
	[Export]
	public float speed = 400f;
	public float focusMultiplier = 0.5f;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(float delta)
	{
		var velocity = new Vector2();
		bool isFocused = false;
		
		if (Input.IsActionPressed("control_focus"))
			isFocused = true;
		
		if (Input.IsActionPressed("ui_right"))
			velocity.x += 1;
		
		if (Input.IsActionPressed("ui_left"))
			velocity.x -= 1;
		
		if (Input.IsActionPressed("ui_up"))
			velocity.y -= 1;
		
		if (Input.IsActionPressed("ui_down"))
			velocity.y += 1;
		
		if (velocity.Length() > 0 && isFocused)
			velocity = velocity.Normalized() * speed * focusMultiplier;
		
		else if (velocity.Length() > 0 && !isFocused)
			velocity = velocity.Normalized() * speed;
		
		Position += velocity * delta;
	}

}

using Godot;
using System;

public class Player : Area2D
{
	// Declare member variables here. Examples:
	// private int a = 2;
	// private string b = "text";
	[Export]
	public int unfocusedSpeed = 200;
	[Export]
	public int focusSpeed = 100;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(float delta)
	{
		var velocity = new Vector2();
		bool isFocused = false;
		int speed = unfocusedSpeed;
		
		if (Input.IsActionPressed("ui_right"))
			velocity.x += 1;
		if (Input.IsActionPressed("ui_left"))
			velocity.x -= 1;
		if (Input.IsActionPressed("ui_up"))
			velocity.y -= 1;
		if (Input.IsActionPressed("ui_down"))
			velocity.y += 1;
		if (Input.IsActionPressed("control_focus"))
			isFocused = true;
		if (Input.IsActionJustReleased("control_focus"))
			isFocused = false;
		
		if (isFocused)
			speed = focusSpeed;
		else if (isFocused == false)
			speed = unfocusedSpeed;
		
		if (velocity.Length() > 0)
			velocity = velocity.Normalized() * speed;
		
		Position += velocity * delta;
	}

}

using Godot;
using System;

public class Player : Area2D
{
	// Declare member variables here. Examples:
	// private int a = 2;
	// private string b = "text";
	[Export]
	public int standardSpeed = 150;	// Standard speed
	[Export]
	public int focusSpeed = 80;	// Speed while focused (slow mode)

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(float delta)
	{
		var velocity = new Vector2();	// Movement velocity represented as a 2 dimensional vector
		bool isFocused = false;	// Tracks whether or not player is focused
		int speed = standardSpeed;	// Speed variable, initialized to standardSpeed
		var playerAnimation = GetNode<AnimatedSprite>("PlayerAnimation");	// Method used to play and stop player animation
		var focusAnimation = GetNode<AnimatedSprite>("FocusAnimation");	// Method used to play and stop focusing animation
		
		// Controls: Arrow keys to move, Shift to focus (can change in Project Settings > Input Map)
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
		
		if (isFocused)
		{
			speed = focusSpeed;
			focusAnimation.Play("focused");	// Placeholder animation just containing 1 frame showing hitbox
		}
		else if (isFocused == false)
		{
			speed = standardSpeed;
			focusAnimation.Play("default");	// Placeholder blank animation
		}
		
		if (velocity.Length() > 0)
			velocity = velocity.Normalized() * speed;
		
		Position += velocity * delta;
		/*Position = new Vector2(
			x: Mathf.Clamp(Position.x, 0, 320),
			y: Mathf.Clamp(Position.y, 0, 240)
		);	// Bind the player's position to within the game area (center focus, need to adjust based on sprite size)*/
	}

	private void _on_Player_body_entered(object body)
	{
		GD.Print("Object in player body");	// Stub console output for hit detection
	}

}

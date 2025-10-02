// get inputs
getControls()

// X Movement
	// direction
	moveDir = rightKey - leftKey;
	
	// Get my face
	if moveDir != 0 {face = moveDir;};

	// Get xspd
	runType = runKey;
	xspd = moveDir * moveSpd[runType];
	
	

	//X collision
	var _subPixel = .5;
	if place_meeting(x + xspd, y, oWall)
	{
		// Slope check
		if !place_meeting(x + xspd, y - abs(xspd)-1, oWall)
		{
			while place_meeting( x + xspd, y, oWall ) {y -= _subPixel;};
		}
		else
		{
			// ceiling slope
			if !place_meeting( x + xspd, y + abs(xspd)+1, oWall)
			{
				while place_meeting( x + xspd, y, oWall) { y += _subPixel; };
			}
			else
			{
				// wall check, no slope
				var _pixelCheck = _subPixel * sign(xspd);
				while !place_meeting(x + _pixelCheck,y, oWall)
				{
					x += _pixelCheck;
				}
	
				//Set xspd to zero to collide with wall
				xspd = 0;
			}
		}
	}
	
	// Slope Decend
	if yspd >= 0 && !place_meeting( x + xspd, y + 1, oWall) && place_meeting( x + xspd, y + abs(xspd)+1, oWall )
	{
		while !place_meeting( x + xspd, y + _subPixel, oWall ) {y += _subPixel;};
	}

	// Move
	x += xspd;
	if xspd > maxMoveSpd {xspd = maxMoveSpd;};

// Y Movement
	// Gravity
	if coyoteHangTimer > 0
	{
		coyoteHangTimer--;
	}
	else
	{
		yspd += grav;
		setOnGround(false);
	}

	//Reset jump variables
	if onGround
	{
		jumpCount = 0;
		coyoteJumpTimer = coyoteJumpFrames;
	}
	else
	{ // no extra jumps
		coyoteJumpTimer--;
		if jumpCount == 0 && coyoteJumpTimer <= 0 {jumpCount = 1;};
	}
	
	
	// Initiate Jump
	if jumpKeyBuffered && jumpCount < jumpMax
	{
		// Reset the buffer
		jumpKeyBuffered = false;
		jumpKeyBufferTimer = 0;
		
		// Increase the numbers of performed jumps
		jumpCount++;
		
		//Set the jumphold timer
		jumpHoldTimer = jumpHoldFrames;
		//Rachel is no longer on the ground
		setOnGround(false);
		coyoteJumpTimer = 0;
	}
	// Cut off jump by releasing the button
	if !jumpKey
	{
		jumpHoldTimer = 0;
	}
	//Jump based on timer/holding the button
	if jumpHoldTimer > 0
	{
		// constantly set the yspd to be the jumping speed
		yspd = jspd;
		//Count down the timer
		jumpHoldTimer--;
	}
	
// Y collision

	// Cap falling speed
	if yspd > termVel {yspd = termVel;};
	
	// Collision
	var _subPixel = .5;
	
	// Upward Y Collision
	if yspd < 0 && place_meeting(x,y+yspd,oWall)
	{
		//Jump into sloped Ceilings
		var _slopeSlide = false;
		
		//Slide upleft
		if moveDir == 0 && !place_meeting(x - abs(yspd)-1, y + yspd, oWall)
		{
			while place_meeting( x,y+yspd,oWall) {x -=1;};
			_slopeSlide = true;
		}
		
		// Future: Sonic Style Slope collision for loop deloops
		
		
		//Slide Upright
		if moveDir == 0 && !place_meeting(x + abs(yspd)+1, y + yspd, oWall)
		{
			while place_meeting( x,y+yspd,oWall) {x +=1;};
			_slopeSlide = true;
		}
		
		//Normal Y Collision
		if !_slopeSlide
		{
			// wall check
			var _pixelCheck = _subPixel * sign(yspd);
			while !place_meeting(x,y + _pixelCheck, oWall)
			{
				y += _pixelCheck;
			}
		
			// Head bonk (Different for slopes and ceilings)
			if yspd < 0
			{
				jumpHoldTimer = 0;
			};
	
			//Set yspd to zero to collide with wall
			yspd = 0;
		}
	}
	
	// Downward Y Collision
	if yspd >= 0
	{
		if place_meeting(x , y + yspd, oWall)
		{
			// wall check
			var _pixelCheck = _subPixel * sign(yspd);
			while !place_meeting(x,y + _pixelCheck, oWall)
			{
				y += _pixelCheck;
			}
		
			// Head bonk (Different for slopes and ceilings)
			//if yspd < 0
			//{
			//	jumpHoldTimer = 0;
			//};
	
			//Set yspd to zero to collide with wall
			yspd = 0;
			}
	
			// Set if on the ground
			if place_meeting (x, y+1, oWall)
			{
				setOnGround(true);
			}
	}
		
	
	
		//Move
		y += yspd;
		
// Sprite Manager
	// Walking
	if abs(xspd) > 0 { sprite_index = walkSpr; };
	// Running
	if abs(xspd) >= moveSpd[1] { sprite_index = runSpr; }; 
	// Idle
	if xspd == 0 { sprite_index = idleSpr; };
	// Jump
	if !onGround { sprite_index = jumpSpr; };
		// set the collision mask
		mask_index = maskSpr;
	// Running
	
	// Duck
	

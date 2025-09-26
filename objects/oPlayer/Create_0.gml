//Custom functions for player
function setOnGround(_val = true)
{
	if _val == true
	{
	onGround = true;
	coyoteHangTimer = coyoteHangFrames;
	}
	else
	{
		onGround = false;
		coyoteHangTimer = 0;
	}
}

// Control Setup
controlSetup();

// Sprites
maskSpr = Rachel_Idle;
idleSpr = Rachel_Idle;
walkSpr = Rachel_Walk;
runSpr = Rachel_Run;
jumpSpr = Rachel_Jump;
duckSpr = Rachel_Duck;


// Movement
face = 1;
moveDir = 0;
runType = 0;
moveSpd[0]= 10;
moveSpd[1]= 20;
xspd = 0;
yspd = 0;
maxMoveSpd = 20;


// Jumping 
grav = 0.675;
termVel = 18;
jspd = -10.15;
jumpMax = 1;
jumpCount = 0;
jumpHoldTimer = 0;
jumpHoldFrames = 18;
onGround = true;

// Coyote Time
	// Hang time
	coyoteHangFrames = 5;
	coyoteHangTimer = 0;
	// Jump buffer timer
	coyoteJumpFrames = 5;
	coyoteJumpTimer = 0;

Strict

Import MaxB3D.Drivers

Graphics 800,600

Local camera:TCamera=CreateCamera()
SetEntityPosition camera,0,1,0

Local light:TLight=CreateLight()
SetEntityRotation light,90,0,0

Local plane:TPlane=CreatePlane()
Local texture:TTexture=LoadTexture("media/mossyground.bmp")
SetEntityTexture plane,texture

While Not KeyDown(KEY_ESCAPE) And Not AppTerminate()
	If KeyDown(KEY_LEFT) TurnEntity camera,0,-1,0
	If KeyDown(KEY_RIGHT) TurnEntity camera,0,1,0
	If KeyDown(KEY_UP) MoveEntity camera,0,0,1
	If KeyDown(KEY_DOWN) MoveEntity camera,0,0,-1
	
	RenderWorld
	
	BeginMax2D
	DrawText "Use the arrow keys to move about the infinite plane.",0,0
	EndMax2D
	Flip
Wend
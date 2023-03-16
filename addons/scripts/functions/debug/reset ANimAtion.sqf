

{
	// Current result is saved in variable _x
	//private _triangleObject = _x;

	private _pos2Diff = [0,0,0];
	_x animate ["Corner_3_LR",0, true];
	_x animate ["Corner_3_FB", 0, true];
	_x animate ["Corner_3_UD", 0, true];
		
	private _pos3Diff = [0,0,0];
	_x animate ["Corner_2_LR",0, true];
	_x animate ["Corner_2_FB", 0, true];
	_x animate ["Corner_2_UD", 0];
} forEach triangles;



vehicle player setpos getpos cp;
vehicle player setVectorDirAndUp [vectorDir cp, vectorUp cp];



car setpos getpos cp;
car setVectorDirAndUp [vectorDir cp, vectorUp cp];

th animate ["Move_1", 10, true];

 
{ 
 _x setposasl ((getposasl _x) vectoradd [0,0,2]) 
} forEach triangles;






arrow = "Sign_Arrow_F" createVehicle [0,0,0];
onEachFrame {
	_ins = lineIntersectsSurfaces [
		AGLToASL positionCameraToWorld [0,0,0],
		AGLToASL positionCameraToWorld [0,0,1000],
		player,
		objNull,
		true,
		1,
		"PHYSX",
		"NONE"
	];
	if (count _ins == 0) exitWith { arrow setPosASL [0,0,0] };
	arrow setPosASL (_ins select 0 select 0);
	arrow setVectorUp (_ins select 0 select 1);
	hintSilent str _ins;
};






man = "O_Survivor_F" createVehicle position player;
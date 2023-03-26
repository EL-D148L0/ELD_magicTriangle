



[] spawn {
	{
		ar setposasl [_x#0,_x#1, 5.5];
		sleep 1;
	} forEach ap#0;
};


"a3\map_data\gdt_strdrygrass_co.paa"
"a3\map_data\gdt_strconcrete_co.paa"

{
	_x setObjectTextureGlobal [0, "a3\map_data\gdt_strconcrete_co.paa"];
} foreach a;

{
	_x setObjectMaterial [0, "a3\structures_f_bootcamp\vr\coverobjects\data\vr_coverobject_basic.rvmat"];
} foreach a;



{
	deleteVehicle _x;
} foreach a;


a = [getposasl ar, getposasl ar2, getposasl ar3] call ELD_magicTriangle_scripts_fnc_createTriangle




_a = values ELD_magicTriangle_scripts_terrainTriangleMap;
_b = [];
{
	// Current result is saved in variable _x
	{
		_b append (_x getVariable "colliders");
	} forEach _x#2
} forEach _a;
_b



 
tris = nearestObjects [player, ["triangle"], 500];
{
	if (t in (_x getVariable "colliders")) then {
		tt = _x;
	}
} forEach tris;





[(tt modeltoworldworld (tt selectionPosition ["Corner_1_Pos", "Memory"])), (tt modeltoworldworld (tt selectionPosition ["Corner_2_Pos", "Memory"])), (tt modeltoworldworld (tt selectionPosition ["Corner_3_Pos", "Memory"]))]



new = [[1918.08,5537.92,6.35002],[1920,5536,6.59],[1916,5536,6.74]] call ELD_magicTriangle_scripts_fnc_createTriangle;


 
new = [[1918.08,5537.92,8.35002],[1920,5536,8.59],[1916,5536,8.74]] call ELD_magicTriangle_scripts_fnc_createTriangle;



[[1918.08,5537.92,8.35002],[1920,5536,8.59],[1916,5536,8.74]]
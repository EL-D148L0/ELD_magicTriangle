
// get all layers
all3DENEntities # 6

// layer transform allowed
myLayer get3DENAttribute "Transformation"






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
aba = [_b, [], { player distance _x }, "ASCEND"] call BIS_fnc_sortBy;




 
tris = nearestObjects [player, ["triangle"], 500];
{
	if (t in (_x getVariable "colliders")) then {
		tt = _x;
	}
} forEach tris;

tt setObjectTextureGlobal [0, "a3\map_data\gdt_strconcrete_co.paa"];



[(tt modeltoworldworld (tt selectionPosition ["Corner_1_Pos", "Memory"])), (tt modeltoworldworld (tt selectionPosition ["Corner_2_Pos", "Memory"])), (tt modeltoworldworld (tt selectionPosition ["Corner_3_Pos", "Memory"]))]




[[1919.25,5543.92,6.07121],[1919.25,5540.75,6.09506],[1919.25,5540.92,6.09376]]

new = [[1918.08,5537.92,6.35002],[1920,5536,6.59],[1916,5536,6.74]] call ELD_magicTriangle_scripts_fnc_createTriangle;


 [(tt modeltoworldworld (tt selectionPosition ["Corner_1_Pos", "Memory"])), (tt modeltoworldworld (tt selectionPosition ["Corner_2_Pos", "Memory"])), (tt modeltoworldworld (tt selectionPosition ["Corner_3_Pos", "Memory"]))]


_a = (tt selectionPosition ["Corner_1_Pos", "Memory"]) vectorDistance (tt selectionPosition ["Corner_2_Pos", "Memory"]);
_b = (tt selectionPosition ["Corner_1_Pos", "Memory"]) vectorDistance (tt selectionPosition ["Corner_3_Pos", "Memory"]);
_c = (tt selectionPosition ["Corner_2_Pos", "Memory"]) vectorDistance (tt selectionPosition ["Corner_3_Pos", "Memory"]);

_area = 0.25* (sqrt (( (_a + _b + _c) * (-_a + _b + _c) * (_a - _b + _c) * (_a + _b - _c) )));
_area



_ar = [[1919.25,5543.92,6.07121],[1919.25,5540.75,6.09506],[1919.25,5540.92,6.09376]];
_a = _ar#0 vectorDistance _ar#2;
_b = _ar#0 vectorDistance _ar#1;
_c = _ar#1 vectorDistance _ar#2;


_cos = ((_b^2) + (_c^2) - (_a^2))/(2*_b*_c);
acos _cos



_tris = nearestObjects [player, ["triangle"], 500];
_out = [];
{
	
_a = (_x selectionPosition ["Corner_1_Pos", "Memory"]) vectorDistance (_x selectionPosition ["Corner_2_Pos", "Memory"]);
_b = (_x selectionPosition ["Corner_1_Pos", "Memory"]) vectorDistance (_x selectionPosition ["Corner_3_Pos", "Memory"]);
_c = (_x selectionPosition ["Corner_2_Pos", "Memory"]) vectorDistance (_x selectionPosition ["Corner_3_Pos", "Memory"]);
_temp = _a;
_b = _a;
_a = _c;

_cos = ((_b^2) + (_c^2) - (_a^2))/(2*_b*_c);
_angle = acos _cos;
if ((_angle < 0.2) || (_angle > 179.8)|| !finite _angle) then {
	_out pushBack _x;
};
} forEach _tris;
_out





_tris = nearestObjects [player, ["triangle"], 500];

_tris = [_tris, [], {
	
_a = (_x selectionPosition ["Corner_1_Pos", "Memory"]) vectorDistance (_x selectionPosition ["Corner_2_Pos", "Memory"]);
_b = (_x selectionPosition ["Corner_1_Pos", "Memory"]) vectorDistance (_x selectionPosition ["Corner_3_Pos", "Memory"]);
_c = (_x selectionPosition ["Corner_2_Pos", "Memory"]) vectorDistance (_x selectionPosition ["Corner_3_Pos", "Memory"]);

0.25* (sqrt (( (_a + _b + _c) * (-_a + _b + _c) * (_a - _b + _c) * (_a + _b - _c) )))
}, "ASCEND"] call BIS_fnc_sortBy;
_tris




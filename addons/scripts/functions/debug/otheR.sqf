



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
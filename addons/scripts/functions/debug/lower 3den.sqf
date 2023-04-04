

private _tp = [];
{
	// Current result is saved in variable _x
	_tp append ([_x] call ELD_magicTriangle_scripts_fnc_TPAddTrench);
} forEach ELD_magicTriangle_scripts_trenchObjectList;

[_tp] call ELD_magicTriangle_scripts_fnc_TPUpdate;
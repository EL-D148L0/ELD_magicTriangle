_objs = nearestObjects [player, ["Tronch_center"], 3];
if(count _objs > 0) then {
	_trench = _objs#0;
	_positions = [_trench] call ELD_magicTriangle_scripts_fnc_getTrenchCornersFromConfig;
	_dir = player getRelDir ((_positions#0 vectorAdd _positions #1) vectorMultiply 0.5);
	_dir = -_dir; 
	ar setPos (_trench modelToWorld (_trench selectionPosition (getArray ((configOf _trench) >> "trench_corners_clockwise")) # ((round (_dir / 90)) % 4)));
	[_trench, (round (_dir / 90)) %4] call ELD_magicTriangle_scripts_fnc_expandTrenchGraph
};









[tr] call ELD_magicTriangle_scripts_fnc_initCoreTrench;
player addEventHandler ["Fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	_objs = nearestObjects [player, ["Tronch_center"], 3];
if(count _objs > 0) then {
	_trench = _objs#0;
	_positions = [_trench] call ELD_magicTriangle_scripts_fnc_getTrenchCornersFromConfig;
	_dir = player getRelDir ((_positions#0 vectorAdd _positions #1) vectorMultiply 0.5);
	_dir = -_dir; 
	ar setPos (_trench modelToWorld (_trench selectionPosition (getArray ((configOf _trench) >> "trench_corners_clockwise")) # ((round (_dir / 90)) % 4)));
	[_trench, (round (_dir / 90)) %4] call ELD_magicTriangle_scripts_fnc_expandTrenchGraph
};
}];
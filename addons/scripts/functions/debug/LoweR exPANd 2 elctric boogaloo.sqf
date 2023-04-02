




[tr_1] call ELD_magicTriangle_scripts_fnc_initCoreTrench;





player addEventHandler ["Fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	_objs = nearestObjects [player, ["Tronch_center"], 3];
	if(count _objs > 0) then {
		_trench = _objs#0;
		if (_trench in ELD_magicTriangle_scripts_trenchObjectList) then {
			_positions = [_trench] call ELD_magicTriangle_scripts_fnc_getTrenchCornersFromConfig;
			_dir = player getRelDir ((_positions#0 vectorAdd _positions #1) vectorMultiply 0.5);
			_dir = 360 -_dir; 
			//ar setPos (_trench modelToWorld (_trench selectionPosition (getArray ((configOf _trench) >> "trench_corners_clockwise")) # ((round (_dir / 90)) % 4)));
			private _trDir = (round (_dir / 90)) %4;
			[_trench, _trDir, [_trench, _trDir] call ELD_magicTriangle_scripts_fnc_makeNewTrenchForExpansion] call ELD_magicTriangle_scripts_fnc_expandTrenchGraph;
			
			

		} else {
			hint "uninitialized trench is closest to player"
		};
		
	};
}];


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
	if (_trench in ELD_magicTriangle_scripts_trenchObjectList) then {
		_positions = [_trench] call ELD_magicTriangle_scripts_fnc_getTrenchCornersFromConfig;
		_dir = player getRelDir ((_positions#0 vectorAdd _positions #1) vectorMultiply 0.5);
		_dir = 360 -_dir; 
		ar setPos (_trench modelToWorld (_trench selectionPosition (getArray ((configOf _trench) >> "trench_corners_clockwise")) # ((round (_dir / 90)) % 4)));
		[_trench, (round (_dir / 90)) %4] call ELD_magicTriangle_scripts_fnc_expandTrenchGraph
	} else {
		hint "uninitialized trench is closest to player"
	};
	
};
}];







[tr] call ELD_magicTriangle_scripts_fnc_initCoreTrench;

triangles = [];
player addEventHandler ["Fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	_objs = nearestObjects [player, ["Tronch_center"], 3];
if(count _objs > 0) then {
	_trench = _objs#0;
	if (_trench in ELD_magicTriangle_scripts_trenchObjectList) then {
		_positions = [_trench] call ELD_magicTriangle_scripts_fnc_getTrenchCornersFromConfig;
		_dir = player getRelDir ((_positions#0 vectorAdd _positions #1) vectorMultiply 0.5);
		_dir = 360 -_dir; 
		ar setPos (_trench modelToWorld (_trench selectionPosition (getArray ((configOf _trench) >> "trench_corners_clockwise")) # ((round (_dir / 90)) % 4)));
		[_trench, (round (_dir / 90)) %4] call ELD_magicTriangle_scripts_fnc_expandTrenchGraph;
		

{
	// Current result is saved in variable _x
	deleteVehicle _x;
} forEach triangles;

triangles = [];


private _positionsT = [];
{
	{
		_positionsT pushBackUnique _x;
	} foreach (_x getvariable "terrainPoints");
	
} foreach ELD_magicTriangle_scripts_trenchObjectList;

_allPos = [[_positionsT] call ELD_magicTriangle_scripts_fnc_getTerrainPolygon, ([ELD_magicTriangle_scripts_trenchObjectList # 0] call ELD_magicTriangle_scripts_fnc_getTrenchPolygon)];

_order = getTrianglesOrder _allPos;

for [{ _i = 0 }, { _i < count _order }, { _i = _i + 3 }] do {
	_triangleCorners = [];
	for [{ _j = 0 }, { _j <= 2 }, { _j = _j + 1 }] do { 
		_countCounter = 0;
		{
			private _index = (_order#(_i + _j) - _countCounter);
			if (_index < count _x) then {
				_position = _x # _index;
				if (_foreachindex == 0) then {
					_position set [2, getTerrainHeight _position];
				};
				_triangleCorners pushBack _position;
				break;
			} else {
				_countCounter = _countCounter + count _x;
			};
			
		} forEach _allPos;
		
		
	};
	triangles pushBack (_triangleCorners call ELD_magicTriangle_scripts_fnc_createTriangle);
};


	} else {
		hint "uninitialized trench is closest to player"
	};
	
};
}];






{
	// Current result is saved in variable _x
	deleteVehicle _x;
} forEach triangles;

triangles = [];


private _positionsT = [];
{
	{
		_positionsT pushBackUnique _x;
	} foreach (_x getvariable "terrainPoints");
	
} foreach ELD_magicTriangle_scripts_trenchObjectList;

_allPos = [[_positionsT] call ELD_magicTriangle_scripts_fnc_getTerrainPolygon, ([ELD_magicTriangle_scripts_trenchObjectList # 0] call ELD_magicTriangle_scripts_fnc_getTrenchPolygon)];

_order = getTrianglesOrder _allPos;

for [{ _i = 0 }, { _i < count _order }, { _i = _i + 3 }] do {
	_triangleCorners = [];
	for [{ _j = 0 }, { _j <= 2 }, { _j = _j + 1 }] do { 
		_countCounter = 0;
		{
			private _index = (_order#(_i + _j) - _countCounter);
			if (_index < count _x) then {
				_position = _x # _index;
				if (_foreachindex == 0) then {
					_position set [2, getTerrainHeight _position];
				};
				_triangleCorners pushBack _position;
				break;
			} else {
				_countCounter = _countCounter + count _x;
			};
			
		} forEach _allPos;
		
		
	};
	triangles pushBack (_triangleCorners call ELD_magicTriangle_scripts_fnc_createTriangle);
};






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

private _gtpwi = ([_positionsT] call ELD_magicTriangle_scripts_fnc_getTerrainPolygonsWithIslands);
_allPos = [(_gtpwi # 0 # 0)] + (_gtpwi # 0 # 1) + [([ELD_magicTriangle_scripts_trenchObjectList # 0] call ELD_magicTriangle_scripts_fnc_getTrenchPolygon)];
_allPos;
_order = getTrianglesOrder _allPos;

for [{ _i = 0 }, { _i < count _order }, { _i = _i + 3 }] do {
	_triangleCorners = [];
	for [{ _j = 0 }, { _j <= 2 }, { _j = _j + 1 }] do { 
		_countCounter = 0;
		{
			private _index = (_order#(_i + _j) - _countCounter);
			if (_index < count _x) then {
				_position = _x # _index;
				if (count _position == 2) then {
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


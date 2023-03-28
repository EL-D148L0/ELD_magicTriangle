
{
	// Current result is saved in variable _x
	deleteVehicle _x;
} forEach triangles;

triangles = [];


_allPos = [[[1,1], [1,9],[9,9], [9,1]], [[3,3], [7,3],[7,7], [3,7]], [[0,0], [0,10],[10,10], [10,0]]];

_order = getTrianglesOrder _allPos;

for [{ _i = 0 }, { _i < count _order }, { _i = _i + 3 }] do {
	_triangleCorners = [];
	for [{ _j = 0 }, { _j <= 2 }, { _j = _j + 1 }] do { 
		_countCounter = 0;
		{
			private _index = (_order#(_i + _j) - _countCounter);
			if (_index < count _x) then {
				_position = _x # _index;
				_position set [2, 2];
				_triangleCorners pushBack _position;
				break;
			} else {
				_countCounter = _countCounter + count _x;
			};
			
		} forEach _allPos;
		
		
	};
	_obj = (_triangleCorners call ELD_magicTriangle_scripts_fnc_createTriangle);
	triangles append _obj;
};
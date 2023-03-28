#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * calculates and spawns the triangles needed to fill the results of getTTRIntersectedPolygons.
 *
 * Arguments:
 *	0: array of arrays in format positionsASL <ARRAY>
 * 
 *
 * Return Value:
 * array of triangle objects <ARRAY>
 *		
 *
 * Example:
 * [_trench] call ELD_magicTriangle_scripts_fnc_fillPolygons;
 *
 * Public: No
 */



params ["_positionLists"];

private _positionListsForTriangulation = [];
private _positionListsHoles = [];
private _positionListsOutlines = [];

{
	if (_x#1) then {
		_positionListsOutlines pushBack (_x#0);
	} else {
		_positionListsHoles pushBack (_x#0);
	};
} forEach _positionLists;



private _triangles = [];
{
	// Current result is saved in variable _x
	private _allPos = _x;
	private _order = getTrianglesOrder _allPos;

	for [{ _i = 0 }, { _i < count _order }, { _i = _i + 3 }] do {
		private _triangleCorners = [];
		for [{ _j = 0 }, { _j <= 2 }, { _j = _j + 1 }] do { 
			private _countCounter = 0;
			{
				private _index = (_order#(_i + _j) - _countCounter);
				if (_index < count _x) then {
					private _position = _x # _index;
					_triangleCorners pushBack _position;
					break;
				} else {
					_countCounter = _countCounter + count _x;
				};
				
			} forEach _allPos;
			
			
		};
		private _obj = (_triangleCorners call FUNC(createTriangle));
		_triangles append _obj;
	};
} forEach (_positionListsOutlines apply {[_x] + _positionListsHoles});


_triangles;


#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * calculates the polygons inside passed TTR that need to be filled to not intersect trenches
 *
 * Arguments:
 *	0: array in format TTRKey <ARRAY>
 * 
 *
 * Return Value:
 * array of arrays in format positionsASL
 *		
 *
 * Example:
 * [_key] call ELD_magicTriangle_scripts_fnc_getTTRIntersectedPolygons;
 *
 * Public: No
 */



params ["_key"];


private _ttr = GVAR(terrainTriangleMap) get _key;

/* TODO fix this function, it currently only works for a singular connected trench and is incredibly inefficient
 it only exists in its current state to visualize the new concept in game*/

 private _trenchoutline = ([_ttr # 3 # 0] call FUNC(getTrenchPolygon)) apply {[_x # 0, _x # 1]};

 private _ttrOutline = (_key # 0) apply {[_x # 0, _x # 1]};

 private _out = clipPolygon [[_trenchoutline], [_ttrOutline]];

private _n = _ttr # 1;
private _p = _ttr # 0 # 0;


_newout = [];
{
	// Current result is saved in variable _x
	private _list = [];
	{
		// Current result is saved in variable _x
		private _x2 = ((_n#0 * (_x#0 - _p#0) + _n#1 * (_x#1 - _p#1))/(-_n#2)) + _p#2;
		_list pushback [_x#0, _x#1, _x2];
	} forEach _x;
	reverse _list;
	_newout pushBack _list;

} forEach _out;

_newout;


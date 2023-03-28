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



private _trenchlist = _ttr # 3;
{
	private _vc = [];
	{
		_vc pushBack false;
	} forEach (_x getVariable ["corners",[]]);
	_x setVariable ["visitedCorners", _vc];
} forEach _trenchlist;


private _outlines = [];
while {true} do {
	private _trench = objNull;
	private _index = -1;
	{
		
		_index =  ((_x getVariable ["visitedCorners",[]]) find false);
		if (_index == -1) then {
			continue;
		};
		_trench = _x;
		break;

	} forEach _trenchlist;
	if (_index == -1) then {
		break;
	};
	// get outline of trench network starting _trench at corner _index
	_outlines pushback (([_trench, _index, _trenchlist] call FUNC(getTrenchPolygon)) apply {[_x # 0, _x # 1]});
};



 private _ttrOutline = (_ttr # 0) apply {[_x # 0, _x # 1]};

 private _out = clippolygonWindOrder [[_ttrOutline], _outlines];

private _n = _ttr # 1;
private _p = _ttr # 0 # 0;


_newout = [];
{
	// Current result is saved in variable _x
	private _list = [];
	private _order = _x#1;
	{
		// Current result is saved in variable _x
		private _x2 = ((_n#0 * (_x#0 - _p#0) + _n#1 * (_x#1 - _p#1))/(-(_n#2))) + _p#2;
		_list pushback [_x#0, _x#1, _x2];
	} forEach (_x#0);
	_newout pushBack [_list, _order];

} forEach _out;

_newout;


#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * updates both filler and terrainheight of the TTR around the passed TP
 * Arguments:
 *	0: array of terrainpoints <ARRAY>
 * 
 *
 * Return Value:
 * TP that should get the TTR around them updated.
 *		
 *
 * Example:
 * [[1624,5328], [1628,5328]] call ELD_magicTriangle_scripts_fnc_TPUpdate;
 *
 * Public: No
 */



params ["_tpList"];


private _ttrList = [_tpList] call ELD_magicTriangle_scripts_fnc_getTerrainTrianglesFromLoweredPoints;


{
	// Current result is saved in variable _x
	private _ttrKey = _x;
	private _pointA = [];
	private _pointB = [];
	private _pointC = [];
	private _trenches = [];
	if ((_ttrKey # 2) == 0) then {
		private _temp = [_ttrKey#0, _ttrKey#1];
		_temp = GVAR(terrainPointMap) getOrDefault [_temp, [_temp + [getTerrainHeight _temp], []]];
		_trenches append (_temp # 1);
		_pointA = _temp # 0;
		_temp = [_ttrKey#0, _ttrKey#1 + GVAR(cellSize)];
		_temp = GVAR(terrainPointMap) getOrDefault [_temp, [_temp + [getTerrainHeight _temp], []]];
		_trenches append (_temp # 1);
		_pointB = _temp # 0;
		_temp = [_ttrKey#0 + GVAR(cellSize), _ttrKey#1];
		_temp = GVAR(terrainPointMap) getOrDefault [_temp, [_temp + [getTerrainHeight _temp], []]];
		_trenches append (_temp # 1);
		_pointC = _temp # 0;
	} else {
		private _temp = [_ttrKey#0 + GVAR(cellSize), _ttrKey#1];
		_temp = GVAR(terrainPointMap) getOrDefault [_temp, [_temp + [getTerrainHeight _temp], []]];
		_trenches append (_temp # 1);
		_pointA = _temp # 0;
		_temp = [_ttrKey#0, _ttrKey#1 + GVAR(cellSize)];
		_temp = GVAR(terrainPointMap) getOrDefault [_temp, [_temp + [getTerrainHeight _temp], []]];
		_trenches append (_temp # 1);
		_pointB = _temp # 0;
		_temp = [_ttrKey#0 + GVAR(cellSize), _ttrKey#1 + GVAR(cellSize)];
		_temp = GVAR(terrainPointMap) getOrDefault [_temp, [_temp + [getTerrainHeight _temp], []]];
		_trenches append (_temp # 1);
		_pointC = _temp # 0;
	};
	
	private _triangles = [[[_pointA, _pointB, _pointC], _trenches] call FUNC(getTTRIntersectedPolygons)] call FUNC(fillPolygons);
	{
		deletevehicle _x;
	} forEach ((GVAR(terrainPointMap) get [_ttrKey#0, _ttrKey#1]) # 2 # (_ttrKey#2));
	((GVAR(terrainPointMap) get [_ttrKey#0, _ttrKey#1]) # 2) set [(_ttrKey#2), _triangles];
	
} forEach _ttrList;

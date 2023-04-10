#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * updates both filler and terrainheight of the TTR around the passed TP
 * Arguments:
 *	0: array of terrainpoints <ARRAY>
 * 
 *
 * Return Value:
 * TP that should get the TTR around them updated.  //TODO CHECK IF THIS IS OUTDATED
 *		
 *
 * Example:
 * [[1624,5328], [1628,5328]] call ELD_magicTriangle_scripts_fnc_TPUpdate;
 *
 * Public: No
 */


//TODO this function hangs for 2-4 seconds if supplied with invalid data
params ["_tpList"];
diag_log "tpUpdate start";
_tpList = _tpList arrayIntersect _tpList;

{
	// Current result is saved in variable _x 
	private _thisTP = (GVAR(terrainPointMap) get _x);
	private _originalTerrainPosition = _thisTP # 0;
	private _hasTrenches = (count (_thisTP # 1)) != 0;
	if ((abs ((_originalTerrainPosition # 2) - (getTerrainHeight _x))) < 0.005) then {
		if (_hasTrenches) then {
			if (!GVAR(hideTerrainMods)) then {
				[_originalTerrainPosition vectorAdd [0,0,- GVAR(cellSize) * 1.5]] call FUNC(setTerrainPointHeight);
			};
		};
	} else {
		if (!_hasTrenches) then {
			[_originalTerrainPosition] call FUNC(setTerrainPointHeight);
		};
	};
} forEach _tpList;

private _ttrList = [_tpList] call FUNC(getTerrainTrianglesFromLoweredPoints);


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

	private _triangles = [];
	if ((count _trenches) != 0) then {
		_triangles = [[[_pointA, _pointB, _pointC], _trenches] call FUNC(getTTRIntersectedPolygons)] call FUNC(fillPolygons);
	};
	
	{
		_x hideObject GVAR(hideTerrainMods);
		{
			_x hideObject GVAR(hideTerrainMods);
		} forEach (_x getVariable "colliders");
	} forEach (_triangles);
	
	
	private _key =  [_ttrKey#0, _ttrKey#1];
	private _entry = GVAR(terrainPointMap) getordefault [_key, []];
	_entry params [
			["_originalTerrainPosition", _key + [getTerrainHeight _key]], 
			["_associatedTrenches", []], 
			["_fillerObjects", [[],[]]]
			];
	{
		deletevehicle _x;
	} forEach (_fillerObjects# (_ttrKey#2));
	_fillerObjects set [(_ttrKey#2), _triangles];

	GVAR(terrainPointMap) set [_key, [_originalTerrainPosition, _associatedTrenches, _fillerObjects]];
	
} forEach _ttrList;

diag_log "tpUpdate finished";
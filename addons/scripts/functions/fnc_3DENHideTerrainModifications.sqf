#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * function that un-lowers the passed TP and hides all fillers saved at that key.
 *
 * Arguments:
 * 0: position2d: the key of a TP that shall be hidden <ARRAY>
 * 1: true to hide, false to show <BOOLEAN> 
 *
 * Return Value:
 * none
 *
 * Example:
 * [_key, true] call ELD_magicTriangle_scripts_fnc_3DENHideTerrainModifications;
 *
 * Public: No
 */


params ["_key", "_hide"];


private _thisTP = (GVAR(terrainPointMap) get _key);
private _originalTerrainPosition = _thisTP # 0;
private _hasTrenches = (count (_thisTP # 1)) != 0;

if (_hide) then {
	if ((abs ((_originalTerrainPosition # 2) - (getTerrainHeight _key))) > 0.005) then {
		[_originalTerrainPosition] call FUNC(setTerrainPointHeight);
	};
	
} else {
	if ((abs ((_originalTerrainPosition # 2) - (getTerrainHeight _key))) < 0.005) then {
		if (_hasTrenches) then {
			[_originalTerrainPosition vectorAdd [0,0,- GVAR(cellSize) * 1.5]] call FUNC(setTerrainPointHeight);
		};
	} else {
		if (!_hasTrenches) then {
			[_originalTerrainPosition] call FUNC(setTerrainPointHeight);
		};
	};
};

{
	_x hideObject _hide;
	{
		_x hideObject _hide;
	} forEach (_x getVariable "colliders");
} forEach ((_thisTP#2#0)+ (_thisTP#2#1));
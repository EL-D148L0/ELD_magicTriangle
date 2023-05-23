#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * updates both filler and terrainheight of the TTR around the passed TP
 * Arguments:
 *	0: array of terrainpoints <ARRAY>
 * 
 *
 * Return Value:
 * nothing
 *		
 *
 * Example:
 * [[[1624,5328], [1628,5328]]] call ELD_magicTriangle_scripts_fnc_TPUpdate;
 *
 * Public: No
 */


//TODO this function hangs for 2-4 seconds if supplied with invalid data
params ["_tpList"];
diag_log ((str (systemTime # 6)) + " " + "tpUpdate start");
_tpList = _tpList arrayIntersect _tpList;

{
	// Current result is saved in variable _x 
	private _thisTP = (GVAR(terrainPointMap) get _x);
	private _originalTerrainPosition = _thisTP # 0;
	private _hasTrenches = false;
	{
		if (!isNil {_x getVariable "rank"}) then {
			_hasTrenches = true;
			break;
		}
	} forEach (_thisTP # 1);
	if ((abs ((_originalTerrainPosition # 2) - (getTerrainHeight _x))) < 0.005) then {
		if (_hasTrenches) then {
			if (!GVAR(hideTerrainMods)) then {
				[_originalTerrainPosition vectorAdd [0,0,- GVAR(cellSize) * 1.5]] call FUNC(queueTerrainPointHeight);
			};
		};
	} else {
		if (!_hasTrenches) then {
			[_originalTerrainPosition] call FUNC(queueTerrainPointHeight);
		};
	};
} forEach _tpList;

[_tpList] call FUNC(TPGenerateFiller);

call FUNC(applyTerrainPointHeight);

diag_log ((str (systemTime # 6)) + " " + "tpUpdate finished");
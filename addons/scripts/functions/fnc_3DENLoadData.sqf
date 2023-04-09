#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * loads data from uiNamespace Variable and applies it to object variables 
 * Arguments:
 * none
 *
 * Return Value:
 * none
 *
 * Example:
 * call ELD_magicTriangle_scripts_fnc_3DENLoadData;
 *
 * Public: No
 */


if (!is3DEN) throw "called 3DENLoadData outside of 3den";
diag_log "3DENLoadData";
private _data = uiNamespace getVariable QGVAR(trenchData);

diag_log _data;
/*
 *
 * trenchData is saved in this format:
 * array of arrays in format:
 *		0: 3den ID of trench
 *		1: rank of trench
 *		2: neighborranks array of trench (like old attributes)
 *
 */

{
	// Current result is saved in variable _x
	private _trench = get3DENEntity (_x#0);
	if (_trench isEqualType -1) then {
		diag_log "nonexisting entity id in data";
		continue;
	};
	_trench setVariable ["rank", _x#1];
} forEach _data;


{
	// Current result is saved in variable _x
	private _trench = get3DENEntity (_x#0);
	if (_trench isEqualType -1) then {
		continue;
	};
	private _attributeArray = (_x#2);
	diag_log _attributeArray;
	private _sides = _attributeArray apply {
		private _rank = _x # 0;
		if (_rank == -1) then {
			[objNull, -1];
		} else {
			private _index = GVAR(trenchObjectList) findIf {_x getVariable "rank" == _rank};
			if (_index == -1) then {
				_index = GVAR(uninitializedTrenches) findIf {_x getVariable "rank" == _rank};
				if (_index == -1) throw "unregistered ID found in neighbor data";
				[GVAR(uninitializedTrenches) # _index, _x # 1];
			} else {
				[GVAR(trenchObjectList) # _index, _x # 1];
			};
		};
	};
	//diag_log _sides;
	_trench setVariable ["sides", _sides];
} forEach _data;


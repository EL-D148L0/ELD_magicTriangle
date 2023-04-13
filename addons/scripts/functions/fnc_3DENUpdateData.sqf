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
 * call ELD_magicTriangle_scripts_fnc_3DENUpdateData;
 *
 * Public: No
 */


if (!is3DEN) throw "called fnc_3DENUpdateData outside of 3den";
private _data = uiNamespace getVariable QGVAR(trenchData);
if (isNil {_data}) throw "tried initialising data by updating";
diag_log "3DENUpdateData called";
private _newData = [];
{
	// Current result is saved in variable _x
	_newData pushBack [get3DENEntityID _x, _x getVariable "rank", (_x getVariable ["sides", []]) apply {[(_x#0) getVariable ["rank", -1], _x#1]}, getPosASL _x, typeOf _x];
	
} forEach GVAR(trenchObjectList);
diag_log _newData;

uiNamespace setVariable [QGVAR(trenchData), _newData];
diag_log "update data finished";
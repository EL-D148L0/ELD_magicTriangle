#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * synchronizes object variables to match the attributes. the exact opposite of ELD_magicTriangle_scripts_fnc_3DENUpdateAttributes.
 * Arguments:
 * 0: trench to update
 *
 * Return Value:
 * none
 *
 * Example:
 * [_trench] call ELD_magicTriangle_scripts_fnc_3DENSyncVarsFromAttributes;
 *
 * Public: No
 */


params ["_trench"];

_trench setVariable ["rank", _trench get3DENAttribute "trenchRank"];


private _sides = _trench get3DENAttribute "neighborRanks" apply {
	private _rank = _x;
	if (_rank = -1) exitWith {
		objNull;
	};
	GVAR(trenchObjectList) findIf {_x getVariable "rank" == _rank};
};
_trench setVariable ["sides", _sides];
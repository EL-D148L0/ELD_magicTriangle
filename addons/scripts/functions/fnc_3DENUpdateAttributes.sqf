#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * updates the attributes to match the object variables
 * Arguments:
 * 0: trench to update
 *
 * Return Value:
 * none
 *
 * Example:
 * [_trench] call ELD_magicTriangle_scripts_fnc_3DENUpdateAttributes;
 *
 * Public: No
 */


params ["_trench"];

_trench set3DENAttribute ["trenchRank", _trench getVariable ["rank", -1]];
_trench set3DENAttribute ["neighborRanks", str ((_trench getVariable ["sides", []]) apply {_x getVariable ["rank", -1]})];
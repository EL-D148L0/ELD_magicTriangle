#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * finds the closest triangle collider to the specified angle
 *
 * Arguments:
 * 0: angle in degrees, not NaN <NUMBER>
 * 1: round up? <BOOLEAN>
 *
 * Return Value:
 * triangle collider model path <STRING>
 *
 * Example:
 * [3, true] call ELD_magicTriangle_scripts_fnc_getTriangleColliderModel;
 *
 * Public: No
 */






params ["_angle"];



private _searchNumber = (round (_angle * 10))/10;


if (_searchNumber < 0.1) then {
	_searchNumber = 0.1;
};
if (_searchNumber > 89) then {
	_searchNumber = 89;
};


if (_searchNumber in GVAR(colliderModelMap)) exitWith {(GVAR(colliderModelMap) get _searchNumber)};


throw ("couldn't find any triangleColliderModel" + str(_angle));
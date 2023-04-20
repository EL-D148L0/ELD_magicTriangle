#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * finds the closest triangle cover to the specified triangle
 *
 * Arguments:
 * 0: angle in degrees, not NaN <NUMBER>
 * 1: round up? <BOOLEAN>
 *
 * Return Value:
 * triangle collider model path <STRING>
 *
 * Example:
 * [3, true] call ELD_magicTriangle_scripts_fnc_getTriangleCoverClass;
 *
 * Public: No
 */


params ["_a", "_b", "_c"]; //AC is longest, B is the variable point

if (([_a, [_b vectorAdd [GVAR(cellSize), 0]]] call FUNC(pointInList2d))&& [_c, [_b vectorAdd [0,GVAR(cellSize)]]] call FUNC(pointInList2d)) exitWith {
	"UnmodifiedCover0"
};

if (([_a, [_b vectorDiff [GVAR(cellSize), 0]]] call FUNC(pointInList2d))&& [_c, [_b vectorDiff [0,GVAR(cellSize)]]] call FUNC(pointInList2d)) exitWith {
	"UnmodifiedCover1"
};


private _points = keys GVAR(CoverClassMap);


private _cos = (_b vectordiff _a) vectorCos (_c vectordiff _a);
private _sin = sin (acos _cos);
private _factor = (_b vectorDistance _a)/(_c vectorDistance _a);
_target = [_cos*_factor, _sin*_factor];
_min = 1000;
_key = nil;
{
	private _dist = _target vectorDistanceSqr _x;
	if (_min > _dist) then {
		_min = _dist;
		_key = _x;
	};
} forEach _points;
if (isNil {_key}) throw "no valid key found in getTriangleCoverClass";
GVAR(CoverClassMap) get _key;

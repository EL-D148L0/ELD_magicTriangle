#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * returns all triangles and OC counterpoints associated with the passed trenches. TODO this documentation
 *
 * Arguments:
 * 0: list of trench objects <ARRAY>
 *
 * Return Value:
 * either "done" or "open corner" if a trench network that is not setup correctly was passed <STRING>
 *
 * Example:
 * [[_tronch1]] call ELD_magicTriangle_scripts_fnc_initTrench;
 *
 * Public: No
 */



if (!canSuspend) exitWith {};
params ["_trenchesToRemove"];

private _out = [];//triangle list, OC counterpoints
{
	// Current result is saved in variable _x
	private _openCorners = ([[_x]] call FUNC(getConfigInfo))#2;
	private _thisTTD = _x;
	{
		// Current result is saved in variable _x
		if (count _x > 0) then {
			if (_thisTTD in _x#0) then { // if the trench is in this network
				private _otherTrenchesOC = ([(_x # 0) - [_thisTTD]] call FUNC(getConfigInfo)) # 2;
				
			};
		};
	} forEach GVAR(coveredTrenchList);
} forEach _trenchesToRemove;

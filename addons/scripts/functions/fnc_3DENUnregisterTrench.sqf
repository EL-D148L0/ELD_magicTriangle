#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * function that is called in UnregisteredFromWorld3DEN EH
 * Arguments:
 * 0: trench to update
 *
 * Return Value:
 * none
 *
 * Example:
 * [_trench] call ELD_magicTriangle_scripts_fnc_3DENUnregisterTrench;
 *
 * Public: No
 */


params ["_trench"];



_arrows = _trench getVariable ["arrows", []];

_neighbors = _arrows apply {[objNull, -1]};

GVAR(trenchObjectList) = GVAR(trenchObjectList) - [_trench];
{
	deleteVehicle _x;
} forEach _arrows;
_trench setVariable ["arrows", []];

{
	if (!isNull (_x#0)) then {
		((_x#0) getVariable "sides") set [_x#1, [objNull, -1]];
		(((_x#0) getVariable "arrows") # (_x#1)) setObjectTexture [0, "#(argb,8,8,3)color(1,0,0,0.75,ca)"];
		[(_x#0)] call FUNC(3DENUpdateAttributes);
	};
} forEach (_trench getVariable "sides");


_trench setVariable ["sides", _neighbors];

private _tp = [];
if (!isNil { _trench getVariable "terrainPoints" }) then {
	_tp append ( [_trench] call FUNC(TPRemoveTrench));
};

[_tp] call FUNC(TPUpdate);
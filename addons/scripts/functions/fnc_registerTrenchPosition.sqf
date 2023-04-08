#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * updates TP info and returns modified tp
 * Arguments:
 * 0: trench to update
 *
 * Return Value:
 * list of tp
 *
 * Example:
 * [_trench] call ELD_magicTriangle_scripts_fnc_registerTrenchPosition;
 *
 * Public: No
 */


params ["_trench"];


private _tp = [];
if (!isNil { _trench getVariable "terrainPoints" }) then {
	_tp append ( [_trench] call FUNC(TPRemoveTrench));
};

private _cornerPositions = [_trench] call FUNC(getTrenchCornersFromConfig);
private _terrainPoints = [_trench] call FUNC(makeSingleHole);
_trench setVariable ["corners", _cornerPositions];
_trench setVariable ["terrainPoints", _terrainPoints];
_tp append ([_trench] call FUNC(TPAddTrench));
_tp;
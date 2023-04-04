#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * initialize a core trench (trench with no connections to other trenches) into the graph.
 *
 * Arguments:
 *	0: trench <OBJECT>
 * 		core trench to be initialized
 *
 * Return Value:
 * success <BOOLEAN>
 *		if the initialization succeeded
 *
 * Example:
 * [tr] call ELD_magicTriangle_scripts_fnc_initCoreTrench;
 *
 * Public: No
 */



params ["_trench"];

if (1 in (getArray ((configOf _trench) >> "trench_sides_open"))) exitWith {false};//if the trench is not a core trench return false

private _rank = call FUNC(getNewRank);


private _cornerPositions = [_trench] call FUNC(getTrenchCornersFromConfig);


private _sides = [];
{
	_sides append [[objNull, -1]];
} forEach _cornerPositions;

private _terrainPoints = [_trench] call FUNC(makeSingleHole);


_trench setVariable ["rank", _rank];
_trench setVariable ["corners", _cornerPositions];
_trench setVariable ["sides", _sides];
_trench setVariable ["terrainPoints", _terrainPoints];

private _tp = [_trench] call FUNC(TPAddTrench);
[_tp] call FUNC(TPUpdate);


GVAR(trenchObjectList) pushBack _trench;

true;

#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * analyse open corners and merge close ones.
 *
 * Arguments:
 *	0: borderLines <ARRAY>
 * 			each element of this array is an array of the following structure: [<ARRAY>, <ARRAY>] 
 *	1: trenchFillingTriangles <ARRAY>
 * 			each element of this array is an array of the following structure: [<ARRAY>, <ARRAY>, <ARRAY>] 
 *	2: openCorners <ARRAY>
 * 			each element of this array is an array in format PositionASL
 *
 * Return Value:
 * success <BOOLEAN>
 *		if the initialization succeeded
 *
 * Example:
 * [_tronch1] call ELD_magicTriangle_scripts_fnc_initCoreTrench;
 *
 * Public: No
 */



params ["_trench"];

if (1 in (getArray ((configOf _trench) >> trench_sides_open))) exitWith {false};//if the trench is not a core trench return false

private _rank = GVAR(trenchRankCounter);
GVAR(trenchRankCounter) = GVAR(trenchRankCounter) + 1;


private _cornerPositions = [];
{
	_cornerPositions append [(_trench modelToWorldWorld (_trench selectionPosition [_x, "Memory"]))];
} foreach (getArray ((configOf _trench) >> "trench_corners_clockwise"));


private _sides = [];
{
	_sides append [objNull];
} forEach _cornerPositions;

private _terrainPoints = [_trench] call FUNC(makeSingleHole);


_trench setVariable ["rank", _rank];
_trench setVariable ["corners", _cornerPositions];
_trench setVariable ["sides", _sides];
_trench setVariable ["terrainPoints", _terrainPoints];

true;

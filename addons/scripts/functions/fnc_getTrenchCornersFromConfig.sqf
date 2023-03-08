#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * returns corners of a trench 
 *
 * Arguments:
 *	0: trench <OBJECT>
 * 		trench to analyze
 *
 * Return Value:
 * array of corner positions in format positionASL <ARRAY>
 *		
 *
 * Example:
 * [_tronch1] call ELD_magicTriangle_scripts_fnc_getTrenchCornersFromConfig;
 *
 * Public: No
 */



params ["_trench"];




private _cornerPositions = [];
{
	_cornerPositions append [(_trench modelToWorldWorld (_trench selectionPosition [_x, "Memory"]))];
} foreach (getArray ((configOf _trench) >> "trench_corners_clockwise"));


_cornerPositions;

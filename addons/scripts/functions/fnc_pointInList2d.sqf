#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * checks if a position is in a list of positions. (used for terrain polygon calculation)
 * third coordinate is not checked
 *
 * Arguments:
 *	0: array in format position2d or position3d <ARRAY>
 * 		point to look for
 *	1: array of positions in format position2d  or position3d<ARRAY>
 * 		positions to look in
 *
 * Return Value:
 * true if position in list <BOOLEAN>
 *		
 *
 * Example:
 * [_pos1, [_pos1, _pos2]] call ELD_magicTriangle_scripts_fnc_pointInList2d;
 *
 * Public: No
 */



params ["_pos", "_positions"];



private _inList = false;
{
	if (((((_x # 0) - (_pos # 0)) ^ 2) + (((_x # 1) - (_pos # 1)) ^ 2)) < 0.001) then {
		_inList = true;
		break; // this can probably be done better
	};
} forEach _positions;

_inList;

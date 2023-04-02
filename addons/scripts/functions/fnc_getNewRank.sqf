#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * returns a new rank and increments global rank counter
 *
 * Arguments:
 *	none
 *
 * Return Value:
 * new rank <NUMBER>
 *		
 *
 * Example:
 * call ELD_magicTriangle_scripts_fnc_getNewRank;
 *
 * Public: No
 */



private _rank = GVAR(trenchRankCounter);
GVAR(trenchRankCounter) = GVAR(trenchRankCounter) + 1;
_rank;
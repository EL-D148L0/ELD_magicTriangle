#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * makes sure rank counter is higher than this rank.
 * called from attribute initialization
 *
 * Arguments:
 * rank <NUMBER>
 *
 * Return Value:
 * nothing
 *		
 *
 * Example:
 * 3 call ELD_magicTriangle_scripts_fnc_discoverRank;
 *
 * Public: No
 */

DEFINE_VAR(trenchRankCounter, 0)

GVAR(trenchRankCounter) = GVAR(trenchRankCounter) max (_this + 1);
#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * adds the terrain point closest to the passed position at the passed positions altitude to the terrain mod queue
 * 
 *
 * Arguments:
 *	0: position in format positionASL <ARRAY>
 * 
 *
 * Return Value:
 * nothing
 *		
 *
 * Example:
 * [_trench] call ELD_magicTriangle_scripts_fnc_queueTerrainPointHeight;
 *
 * Public: No
 */



params ["_position"];


GVAR(pendingTerrainModifications) pushback _position;
//setTerrainHeight [[_position], false];
#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * sets the terrain point closest to the passed position to the passed positions altitude
 * TODO fix JIP queue stuff (look at wiki) (maybe edit in 10*10 sections)
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
 * [_trench] call ELD_magicTriangle_scripts_fnc_setTerrainPointHeight;
 *
 * Public: No
 */



params ["_position"];


setTerrainHeight [[_position], false];
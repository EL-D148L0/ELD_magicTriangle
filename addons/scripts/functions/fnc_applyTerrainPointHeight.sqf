#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * applies the terrain modification queue and empties it. 
 * does not change the reference to the terrain modification queue.
 *
 * Arguments:
 * none
 * 
 *
 * Return Value:
 * nothing
 *		
 *
 * Example:
 * call ELD_magicTriangle_scripts_fnc_applyTerrainPointHeight;
 *
 * Public: No
 */



[GVAR(pendingTerrainModifications), false] call TerrainLib_fnc_setTerrainHeight;

GVAR(pendingTerrainModifications) resize 0;
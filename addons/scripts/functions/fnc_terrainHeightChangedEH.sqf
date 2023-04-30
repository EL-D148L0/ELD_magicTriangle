#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * function to handle terrain changes from other mods using TerrainLibs terrainHeightChanged EH
 *
 * Arguments:
 * _positionsAndHeights - array of [[x1,y1,z1], [x2,y2,z2]...]  [ARRAY]
 * _adjustObjects - if true then objects on modified points are moved up/down to keep the same ATL height  [BOOL]
 * 
 *
 * Return Value:
 * nothing
 *		
 *
 * Example:
 * call ELD_magicTriangle_scripts_fnc_terrainHeightChangedEH;
 *
 * Public: No
 */


params ["_positionsAndHeights", "_adjustObjects"];

// quit immediately if the EH was fired because of my own modifications
if (GVAR(changingTerrain)) exitWith {};

_positionsAndHeightsNew = [];





//if adjustObects is off only borders will be changed
if (!_adjustObjects) exitWith {
	//TODO adjust borders (no changes to terrain)
};


//TODO adjust lowered points
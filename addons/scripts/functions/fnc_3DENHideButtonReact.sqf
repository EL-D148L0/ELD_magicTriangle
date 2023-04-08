#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * hides all /unhides all terrain modifications based on button state
 *
 * Arguments:
 * none
 *
 * Return Value:
 * none
 *
 * Example:
 * call ELD_magicTriangle_scripts_fnc_3DENHideButtonReact;
 *
 * Public: No
 */


private _doLower = cbChecked ((findDisplay 313) displayCtrl HIDE_TOGGLE_IDC);
GVAR(hideTerrainMods) = !_doLower;
{
	[_x, !_doLower] call FUNC(3DENHideTerrainModifications);
} forEach keys GVAR(terrainPointMap);
diag_log "line 1 cba preInit";
#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

ADDON = true;


GVAR(hideTerrainMods) = true;
((findDisplay 313) displayCtrl HIDE_TOGGLE_IDC) cbSetChecked !GVAR(hideTerrainMods);
GVAR(cellSize) = getTerrainInfo#2;
GVAR(defaultTriangleColor) = 0;//0 for ground, 1 for debug

GVAR(colliderModelMap) = call FUNC(getTriangleColliderModelMap);

if (!isNil QGVAR(trenchObjectList)) then {
	systemChat "trenchObjectList was initialized before cba preInit";
};
GVAR(trenchObjectList) = [];


systemchat "preinit";

GVAR(terrainPointMap) = createHashMap; //contains all terrain points that have been modified

/* format of the keys: <ARRAY>
 * 		keys are the position of the lower left corner of the square the triangle is contained in.
 *			0: position X <NUMBER>
 *			1: position Y <NUMBER>
 * format of values: array in format TTR
 *
 *
 * TTR (TerrainTRiangle) is an array that contains information about a triangle of the terrain that has been modified and filled
 * array format TTR:
 * 		0: original corner position of this terrain point <ARRAY>
 *		1: associated trench objects. <ARRAY>
 * 			a trench object is associated when the triangle is affected by terrain modifications of that trench.
 *		2: array of 2 arrays <ARRAY>
 * 			0: filler objects that occupy the triangle northeast of the key point<ARRAY>
 * 			1: filler objects that occupy the triangle northeast of the northeastern triangle point<ARRAY>
 */ 




if (is3DEN) then {
	private _data = loadfile "trenchData.txt";
	if (_data == "") then {_data = "[]"};
	uiNamespace setVariable [QGVAR(trenchData), parseSimpleArray _data];
	call FUNC(3DENLoadData);
};


if (is3DEN) then {
	DEFINE_VAR(uninitializedTrenches, [])
	GVAR(initState) = INITIALISING_3DEN; 
	{
		[_x] call FUNC(3DENInitTrench);
	} forEach GVAR(uninitializedTrenches);
	
	private _tp = [];
	{
		_tp append ([_x] call FUNC(registerTrenchPosition));
	} forEach GVAR(trenchObjectList);
	[_tp] call FUNC(TPUpdate);
	
	GVAR(initState) = INITIALISED_3DEN; 
	
} else {
	
	GVAR(initState) = INITIALISING_GAME; 
	
	GVAR(initState) = INITIALISED_GAME; 
};


/*  in 3den, CBA preinit runs after object init and after attribute setting
3den init order AFAIK:

1. per object:
	init EH
	attribute script
2. CBA preInit


normal preinit and postinit don't run.
*/
diag_log "line 1 cba preInit";
diag_log ("is3den " + str is3DEN);
diag_log ("is3DENPreview " + str is3DENPreview);
#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

ADDON = true;


GVAR(hideTerrainMods) = true; //TODO save/load this value from missionProfileNamespace
if (!is3DEN) then {
	GVAR(hideTerrainMods) = false;
};
((findDisplay 313) displayCtrl HIDE_TOGGLE_IDC) cbSetChecked !GVAR(hideTerrainMods);
GVAR(cellSize) = getTerrainInfo#2;
GVAR(defaultTriangleColor) = 0;//0 for ground, 1 for debug

GVAR(colliderModelMap) = call FUNC(getTriangleColliderModelMap);

if (!isNil QGVAR(trenchObjectList)) then {
	systemChat "trenchObjectList was initialized before cba preInit";
};

DEFINE_VAR(trenchObjectList, [])


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
	diag_log (missionNamespace getVariable [QGVAR(missionPreviewEnd), false]);
	if (missionNamespace getVariable [QGVAR(missionPreviewEnd), false]) then {
		if (isnil {uiNamespace getVariable QGVAR(trenchData)}) then {
			uiNamespace setVariable [QGVAR(trenchData), []];
		};
	} else {
		private _data = "[]";
		if (fileExists "trenchData.txt") then {_data = loadfile "trenchData.txt";};
		uiNamespace setVariable [QGVAR(trenchData), parseSimpleArray _data];
		diag_log "Loaded trenchData from File";
	};
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
	// these identifiers are wrong since initorder outside of 3den actually makes sense
	GVAR(initState) = INITIALISING_GAME; 
	/*
	if (!is3DENPreview) then {
		private _data = "[]";
		if (fileExists "trenchData.txt") then {_data = loadfile "trenchData.txt";};
		uiNamespace setVariable [QGVAR(trenchData), parseSimpleArray _data];
		diag_log "Loaded trenchData from File";

		diag_log "initializing trenches in preinit";
		call FUNC(missionPlay);
	};*/
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
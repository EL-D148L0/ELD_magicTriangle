#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * function that is called in OnMissionSave and OnMissionAutosave EHs
 * Arguments:
 * save attempt number <NUMBER> (optional, default 0)
 *
 * Return Value:
 * none
 *
 * Example:
 * call ELD_magicTriangle_scripts_fnc_3DENMissionSave;
 *
 * Public: No
 */


params [["_attemptNumber", 0]];

call FUNC(3DENUpdateData);
private _saveWorked = ("trenchData" saveFile (str (uiNamespace getVariable QGVAR(trenchData))));
if (_saveWorked) then {
	diag_log "save successful";
} else {
	// if (isNil {_attemptNumber}) then {		
	// 	diag_log "attempt number broken";
	// };
	if (_attemptNumber < 3) then {
		diag_log "save unsuccessful, trying again";
		[_attemptNumber + 1] call FUNC(3DENMissionSave);
	} else {
		diag_log "save unsuccessful, max attempts reached";
		[ 
			"Failed to save trench data. try saving again.", 
			"Warning", 
			true, 
			false, 
			"\A3\ui_f\data\map\markers\handdrawn\warning_CA.paa"] call BIS_fnc_3DENShowMessage;
	};
};
diag_log "trenchData";
diag_log (str (uiNamespace getVariable QGVAR(trenchData)));
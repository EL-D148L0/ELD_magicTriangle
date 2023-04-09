#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * function that is called in OnMissionSave and OnMissionAutosave EHs
 * Arguments:
 * none
 *
 * Return Value:
 * none
 *
 * Example:
 * call ELD_magicTriangle_scripts_fnc_3DENMissionSave;
 *
 * Public: No
 */


diag_log("trenchData" saveFile (str (uiNamespace getVariable QGVAR(trenchData))));
diag_log "trenchData";
diag_log (str (uiNamespace getVariable QGVAR(trenchData)));
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

//TODO save sometimes fails, as indicated by saveFiles return value. if it fails, try again, if it fails again notify user.

call FUNC(3DENUpdateData);
diag_log("trenchData" saveFile (str (uiNamespace getVariable QGVAR(trenchData))));
diag_log "trenchData";
diag_log (str (uiNamespace getVariable QGVAR(trenchData)));
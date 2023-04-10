#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * function that is called in OnMissionPreviewEnd EH
 * Arguments:
 * none
 *
 * Return Value:
 * none
 *
 * Example:
 * call ELD_magicTriangle_scripts_fnc_3DENMissionPreviewEnd;
 *
 * Public: No
 */

diag_log "missionPreviewEnd EH function";
GVAR(missionPreviewEnd) = true;
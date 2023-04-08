#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * function that calls the appropriate init function for the situation
 * Arguments:
 * 0: trench to update
 *
 * Return Value:
 * none
 *
 * Example:
 * [_trench] call ELD_magicTriangle_scripts_fnc_initTrench;
 *
 * Public: No
 */


params ["_trench"];

diag_log "initTrench was called";
if ((isnil QGVAR(initState)) && is3DEN) exitWith {
	diag_log "put trench on the uninitialized list through initTrench";
	DEFINE_VAR(uninitializedTrenches, [])
	GVAR(uninitializedTrenches) pushBack _trench;
};
if (GVAR(initState) == INITIALISED_3DEN) exitWith {
	
	diag_log "3DENInitTrench called through initTrench";
	[_trench] call FUNC(3DENInitTrench);
};

diag_log "initTrench nothing happened";
#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * function that is called to initialise trenches in 3den
 * Arguments:
 * 0: trench to update
 *
 * Return Value:
 * none
 *
 * Example:
 * [_trench] call ELD_magicTriangle_scripts_fnc_3DENInitTrench;
 *
 * Public: No
 */


params ["_trench"];

if (!is3DEN) throw "3den init called outside of 3den";
_trench setVariable ["initialized3DEN", true];

_openSides = (getArray ((configOf _trench) >> "trench_sides_open"));

GVAR(trenchObjectList) pushBack _trench;

_arrows = [];
{
	// Current result is saved in variable _x
	private _item = objNull;
	if (_x == 1) then {
		private _posInfo = [_trench, _forEachIndex] call FUNC(getBorderPosDirUp);
		_item = "Sign_Arrow_Direction_F" createVehicle [0,0,0];
		_item setPosASL (_posInfo#0);
		_item setVectorDirAndUp [_posInfo#1, _posInfo#2];
		_item setVariable ["trench", _trench];
		_item setVariable ["sideNumber", _forEachIndex];
		//_item setVariable ["mate", objNull];
		//attachto doesnt work in 3den
	};
	_arrows pushBack _item;
} forEach _openSides;

_trench setVariable ["arrows", _arrows];
if (GVAR(initState) == INITIALISED_3DEN) then { // condition is true if 3den attributes are not yet initialised
	private _rank = call FUNC(getNewRank);
	_trench setVariable ["rank", _rank];
	_neighbors = _arrows apply {[objNull, -1]};
	_trench setVariable ["sides", _neighbors];
	
	// [_trench] call FUNC(3DENUpdateTrench);
	// private _tp = [_trench] call FUNC(registerTrenchPosition);
	// [_tp] call FUNC(TPUpdate);
	// call FUNC(3DENUpdateData);
} else {
	if ((isnil {_trench getVariable "rank"}) || (isnil {_trench getVariable "sides"})) then {
		diag_log "trench without data during 3den load cycle";
	};
};



//all variables should be fixed at this point
{
	if (!isNull (_x#0)) then {
		((_trench getVariable "arrows") # _foreachindex) setObjectTexture [0, "#(argb,8,8,3)color(0,1,0,0.75,ca)"];
	};
} forEach (_trench getVariable "sides");
#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * BROKEN :(
 * function that is called in RegisteredToWorld3DEN EH 
 * TODO fix this
 * Arguments:
 * 0: trench to update
 *
 * Return Value:
 * none
 *
 * Example:
 * [_trench] call ELD_magicTriangle_scripts_fnc_3DENReregisterTrench;
 *
 * Public: No
 */


params ["_trench"];


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
[_trench] call FUNC(3DENUpdateTrench);
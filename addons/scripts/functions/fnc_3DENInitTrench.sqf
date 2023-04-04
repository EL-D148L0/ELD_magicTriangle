#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * function that is called inside the dragged3den EH by trenches
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
if (!is3DEN) exitWith {};
_trench setVariable ["initialized3DEN", true];
_openSides = (getArray ((configOf _trench) >> "trench_sides_open"));

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
		_item setVariable ["mate", objNull];
		//attachto doesnt work in 3den
		_trench addEventHandler ["Dragged3DEN", {
			params ["_trench"];
			{
				if (!isNull _x) then {
					private _posInfo = [_trench, _forEachIndex] call FUNC(getBorderPosDirUp);
					_x setPosASL (_posInfo#0);
					_x setVectorDirAndUp [_posInfo#1, _posInfo#2];
				};
			} forEach (_trench getVariable ["arrows", []]);
		}];
	};
	_arrows pushBack _item;
} forEach _openSides;

_trench setVariable ["arrows", _arrows];

if ((_trench getVariable ["rank", -1]) == -1) then {
	private _rank = call FUNC(getNewRank);
	_trench setVariable ["rank", _rank];
	_neighbors = _arrows apply {objNull};
	_trench setVariable ["sides", _neighbors];
	[_trench] call FUNC(3DENUpdateAttributes);
} else {
	[_trench] call FUNC(3DENSyncVarsFromAttributes);
};

//TODO fix arrow mates

//all variables should be fixed at this point
{
	if (!isNull _x) then {
		
	};
} forEach (_trench getVariable "sides");
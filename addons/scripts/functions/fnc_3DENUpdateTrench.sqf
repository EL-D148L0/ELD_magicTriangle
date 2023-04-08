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
 * [_trench] call ELD_magicTriangle_scripts_fnc_3DENUpdateTrench;
 *
 * Public: No
 */


params ["_trench"];
{
	if (!isNull _x) then {
		private _posInfo = [_trench, _forEachIndex] call ELD_magicTriangle_scripts_fnc_getBorderPosDirUp;
		_x setPosASL (_posInfo#0);
		_x setVectorDirAndUp [_posInfo#1, _posInfo#2];
		
		private _oldMatingInfo = (_trench getVariable "sides") # _foreachindex;
		private _nearArrows = nearestObjects [_x, ["Sign_Arrow_Direction_F"], 0.4];
		private _originArrow = _x;
		private _mate = objNull;
		{
			// Current result is saved in variable _x
			if ((_x getVariable ["trench", _trench]) != _trench) then {
				private _maxAngleDiff = 30;
				_angleDir = acos ((vectordir _originArrow) vectorCos ((vectordir _x) vectorMultiply -1));
				_angleUp = acos ((vectorUp _originArrow) vectorCos (vectorUp _x));
				if (_angleDir < _maxAngleDiff && _angleUp < _maxAngleDiff) then {
					if ((isNull (((_x getVariable "trench") getVariable "sides") # (_x getVariable "sideNumber") # 0)) || [(_x getVariable "trench"), (_x getVariable "sideNumber")] isEqualTo _oldMatingInfo) then {
						_mate = _x;
						break;
					};
				};
			}; 
		} forEach _nearArrows;
		//private _oldMate = _originArrow getVariable "mate";
		private _nochange = false;
		if (!isNull _mate) then {
			_nochange = _nochange || ([(_mate getVariable "trench"), (_mate getVariable "sideNumber")] isEqualTo _oldMatingInfo);
		} else {
			_nochange = _nochange || isNull (_oldMatingInfo#0);
		};






		if (!_nochange) then {
			if (!isNull (_oldMatingInfo#0)) then {
				((_oldMatingInfo#0) getVariable "sides") set [_oldMatingInfo#1, [objNull, -1]];
				(((_oldMatingInfo#0) getVariable "arrows") # (_oldMatingInfo#1)) setObjectTexture [0, "#(argb,8,8,3)color(1,0,0,0.75,ca)"];
				[(_oldMatingInfo#0)] call FUNC(3DENUpdateAttributes);
			};
			if (isNull _mate) then {
				_originArrow setObjectTexture [0, "#(argb,8,8,3)color(1,0,0,0.75,ca)"];
				(_trench getVariable "sides") set [_originArrow getVariable "sideNumber", [objNull, -1]];

			} else {
				_originArrow setObjectTexture [0, "#(argb,8,8,3)color(0,1,0,0.75,ca)"];
				_mate setObjectTexture [0, "#(argb,8,8,3)color(0,1,0,0.75,ca)"];

				(_trench getVariable "sides") set [_originArrow getVariable "sideNumber", [_mate getVariable "trench", _mate getVariable "sideNumber"]];
				((_mate getVariable "trench") getVariable "sides") set [(_mate getVariable "sideNumber"), [_trench, _originArrow getVariable "sideNumber"]];
				[(_mate getVariable "trench")] call FUNC(3DENUpdateAttributes);
			};
			[_trench] call FUNC(3DENUpdateAttributes);
		};
	};
} forEach (_trench getVariable ["arrows", []]);


if (current3DENOperation isEqualTo "") then {
	private _tp = [_trench] call FUNC(registerTrenchPosition);
	[_tp] call FUNC(TPUpdate);
};
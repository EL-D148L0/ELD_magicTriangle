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
					if ((isNull (_x getVariable "mate")) || (_x getVariable "mate") == _originArrow) then {
						_mate = _x;
						break;
					};
				};
			}; 
		} forEach _nearArrows;
		private _oldMate = _originArrow getVariable "mate";
		
		if ((!isNull _oldMate) && _oldMate != _mate) then {
			_oldMate setVariable ["mate", objNull];
			_oldMate setObjectTexture [0, "#(argb,8,8,3)color(1,0,0,0.75,ca)"];
			((_oldMate getVariable "trench") getVariable "sides") set [(_oldMate getVariable "sideNumber"), objNull];
			[(_oldMate getVariable "trench")] call FUNC(3DENUpdateAttributes);
		};
		if (isNull _mate) then {
			if (!isNull _oldMate) then {
				//no mate, yes oldmate:
				_originArrow setObjectTexture [0, "#(argb,8,8,3)color(1,0,0,0.75,ca)"];
				_originArrow setVariable ["mate", objNull];
				(_trench getVariable "sides") set [_originArrow getVariable "sideNumber", objNull];
				[_trench] call FUNC(3DENUpdateAttributes);
			};
				//no mate, no oldmate: do nothing
		} else {
			if (_oldMate != _mate) then {
				//yes mate, maybe different oldmate:
				_originArrow setObjectTexture [0, "#(argb,8,8,3)color(0,1,0,0.75,ca)"];
				_mate setObjectTexture [0, "#(argb,8,8,3)color(0,1,0,0.75,ca)"];
				_originArrow setVariable ["mate", _mate];
				_mate setVariable ["mate", _originArrow];

				(_trench getVariable "sides") set [_originArrow getVariable "sideNumber", (_mate getVariable "trench")];
				[_trench] call FUNC(3DENUpdateAttributes);
				((_mate getVariable "trench") getVariable "sides") set [(_mate getVariable "sideNumber"), _trench];
				[(_mate getVariable "trench")] call FUNC(3DENUpdateAttributes);
			};
			//yes mate, same oldmate: do nothing
		};
	};
} forEach (_trench getVariable ["arrows", []]);
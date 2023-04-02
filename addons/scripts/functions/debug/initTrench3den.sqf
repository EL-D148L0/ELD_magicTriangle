

(get3DENSelected "object") params ["_trench"];
if (!is3DEN) exitWith {};
_trench setVariable ["initialized3DEN", true];
_openSides = (getArray ((configOf _trench) >> "trench_sides_open"));

_arrows = [];
{
	// Current result is saved in variable _x
	private _item = objNull;
	if (_x == 1) then {
		private _posInfo = [_trench, _forEachIndex] call ELD_magicTriangle_scripts_fnc_getBorderPosDirUp;
		_item = "Sign_Arrow_Direction_F" createVehicle [0,0,0];
		_item setPosASL (_posInfo#0);
		_item setVectorDirAndUp [_posInfo#1, _posInfo#2];
		_item setVariable ["trench", _trench];
		_item setVariable ["sideNumber", _forEachIndex];
		//attachto doesnt work in 3den
		_trench addEventHandler ["Dragged3DEN", {
			params ["_trench"];
			{
				if (!isNull _x) then {
					private _posInfo = [_trench, _forEachIndex] call ELD_magicTriangle_scripts_fnc_getBorderPosDirUp;
					_x setPosASL (_posInfo#0);
					_x setVectorDirAndUp [_posInfo#1, _posInfo#2];
				};
			} forEach (_trench getVariable ["arrows", []]);
		}];
	};
	_arrows pushBack _item;
} forEach _openSides;

_trench setVariable ["arrows", _arrows];
private _rank = call ELD_magicTriangle_scripts_fnc_getNewRank;
_trench set3DENAttribute ["trenchRank", _rank];
_neighbors = _arrows apply {-1};
_trench set3DENAttribute ["neighborRanks", str _neighbors];

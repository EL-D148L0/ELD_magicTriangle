#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * returns the polygon that marks the outline of the trench.
 * behaviour currently undefined for trenches that form circles.
 *
 * Arguments:
 *	0: trench <OBJECT>
 * 		trench to analyze
 *	0: startCornerIndex (optional, default 0)<NUMBER>
 * 		starting corner index
 *
 * Return Value:
 * array of corner positions in format positionASL <ARRAY>
 *		
 *
 * Example:
 * [_tronch1] call ELD_magicTriangle_scripts_fnc_getTrenchPolygon;
 *
 * Public: No
 */



params ["_startTrench", ["_startCornerIndex", 0]];




private _polygon = [];

private _currentTrench = _startTrench;
private _currentCornerIndex = _startCornerIndex;
private _currentCornerRank = _currentTrench getVariable "rank";


private _reachedStart = false;
while {true} do {
	if (isnull ((_currentTrench getVariable "sides") # _currentCornerIndex)) then {
		if (_reachedStart) then {
			break;
		};
		_currentCornerIndex = (_currentCornerIndex + 1) % (count (_currentTrench getVariable "sides"));
		_polygon pushBack ((_currentTrench getVariable "corners") # _currentCornerIndex);
		_currentCornerRank = _currentTrench getVariable "rank";
		if (_currentTrench == _startTrench && _currentCornerIndex == _startCornerIndex) then {
			_reachedStart = true;
		};
	} else {
		private _nextTrench = ((_currentTrench getVariable "sides") # _currentCornerIndex);
		private _nextIndex = (((_nextTrench getVariable "sides") find _currentTrench) + 1) % (count (_nextTrench getVariable "sides"));
		if (_currentCornerRank > (_nextTrench getVariable "rank")) then {
			_polygon set [-1, (_nextTrench getVariable "corners") # _nextIndex];
			_currentCornerRank = (_nextTrench getVariable "rank");
		};
		_currentTrench = _nextTrench;
		_currentCornerIndex = _nextIndex;
		if (_currentTrench == _startTrench && _currentCornerIndex == _startCornerIndex) then {
			_reachedStart = true;
		};
	};
};


_polygon;

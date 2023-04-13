#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * returns the polygon that marks the outline of the trench.
 * behaviour currently undefined for trenches that form circles.
 *
 * Arguments:
 *	0: trench <OBJECT>
 * 		trench to analyze
 *	1: startCornerIndex (optional, default 0) <NUMBER>
 * 		starting corner index
 *	1: trenchList (optional, default []) <ARRAY>
 * 		if passed, trenches that are not in the list will be ignored.
 * 		if passed, visited flags will be set to visited. (not resetting)
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



params ["_startTrench", ["_startCornerIndex", 0], ["_trenchList", []]];


private _usingList = (count _trenchList) != 0;

private _polygon = [];

private _currentTrench = _startTrench;
private _currentCornerIndex = _startCornerIndex;
private _currentCornerRank = _currentTrench getVariable "rank";
if (isNil {_currentCornerRank}) throw "rankless trench passed to getTrenchPolygon";


private _reachedStart = false;
while {true} do {
	if (_usingList) then {
		(_currentTrench getVariable "visitedCorners") set [_currentCornerIndex, true];
	};
	//temp debug thing start
	try {
		//_trench getVariable "sides"
		if ((_currentTrench getVariable "sides") isEqualTo []) throw "adasd";
	} catch {
		// this stays to prevent hang
		diag_log (_currentTrench getVariable 'sides');
		diag_log (_currentTrench);
		diag_log ("uninitialized sides in trench in getTrenchPolygon");
		break;
	};
	//temp debug thing end
	private _nextTrench = ((_currentTrench getVariable "sides") # _currentCornerIndex # 0);
	private _continueSameTrench = (isnull _nextTrench) || {_usingList && {!(_nextTrench in _trenchList)}}; 
	if (_continueSameTrench) then {
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
		private _nextIndex = (((_currentTrench getVariable "sides") # _currentCornerIndex # 1) + 1) % (count (_nextTrench getVariable "sides"));
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

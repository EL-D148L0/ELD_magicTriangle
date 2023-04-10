diag_log "OnMissionPreview line 1";
#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * function that is called in OnMissionPreview EH
 * Arguments:
 * OnMissionPreview EH _this
 *
 * Return Value:
 * none
 *
 * Example:
 * _this call ELD_magicTriangle_scripts_fnc_3DENMissionPreview;
 *
 * Public: No
 */


params ["_objects", "_groups", "_waypoints", "_markers"];

DEFINE_VAR(uninitializedTrenches, [])
DEFINE_VAR(trenchObjectList, [])
private _data = (uiNamespace getVariable QGVAR(trenchData));
diag_log "OnMissionPreview EH fired";
diag_log _data;
{
	private _objectIndex = ((_objects find _x#0) - 1);
	if (_objectIndex < 0) then {
		diag_log "nonexisting entity id in data";
		continue;
	};
	private _trench = _objects # _objectIndex;
	(_x#1) call FUNC(discoverRank);
	_trench setVariable ["rank", _x#1];
	
	GVAR(trenchObjectList) pushback _trench;
} foreach _data;


{
	// Current result is saved in variable _x
	private _objectIndex = ((_objects find _x#0) - 1);
	if (_objectIndex < 0) then {
		continue;
	};
	private _trench = _objects # _objectIndex;
	private _attributeArray = (_x#2);
	diag_log _attributeArray;
	private _sides = _attributeArray apply {
		private _rank = _x # 0;
		if (_rank == -1) then {
			[objNull, -1];
		} else {
			private _index = GVAR(trenchObjectList) findIf {_x getVariable "rank" == _rank};
			if (_index == -1) then {
				_index = GVAR(uninitializedTrenches) findIf {_x getVariable "rank" == _rank};
				if (_index == -1) throw "unregistered ID found in neighbor data";
				[GVAR(uninitializedTrenches) # _index, _x # 1];
			} else {
				[GVAR(trenchObjectList) # _index, _x # 1];
			};
		};
	};
	//diag_log _sides;
	_trench setVariable ["sides", _sides];
} forEach _data;



{
	GVAR(trenchObjectList) pushBack _trench;
} forEach GVAR(uninitializedTrenches);

private _tp = [];
{
	_tp append ([_x] call FUNC(registerTrenchPosition));
} forEach GVAR(trenchObjectList);
[_tp] call FUNC(TPUpdate);

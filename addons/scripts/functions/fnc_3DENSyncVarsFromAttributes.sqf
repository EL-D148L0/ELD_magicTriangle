#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * synchronizes object variables to match the attributes. the exact opposite of ELD_magicTriangle_scripts_fnc_3DENUpdateAttributes.
 * Arguments:
 * 0: trench to update
 *
 * Return Value:
 * none
 *
 * Example:
 * [_trench] call ELD_magicTriangle_scripts_fnc_3DENSyncVarsFromAttributes;
 *
 * Public: No
 */


params ["_trench"];

_thisTrenchRank = (_trench get3DENAttribute "trenchRank") # 0;
_trench setVariable ["rank", _thisTrenchRank];
_thisTrenchRank call FUNC(discoverRank);

private _attributeArray = (parseSimpleArray ((_trench get3DENAttribute "neighborRanks")#0));
diag_log _attributeArray;
private _sides = _attributeArray apply {
	private _rank = _x # 0;
	if (_rank == -1) then {
		[objNull, -1];
	} else {
		private _index = GVAR(trenchObjectList) findIf {_x getVariable "rank" == _rank};
		if (_index == -1) then {
			_index = GVAR(uninitializedTrenches) findIf {_x getVariable "rank" == _rank};
			if (_index == -1) throw "unregistered ID found in neighbor attributes";
			[GVAR(uninitializedTrenches) # _index, _x # 1];
		} else {
			[GVAR(trenchObjectList) # _index, _x # 1];
		};
	};
};
diag_log _sides;
_trench setVariable ["sides", _sides];
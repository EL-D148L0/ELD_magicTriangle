#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * expand a trench. TODO this documentation
 *
 * Arguments:
 * 0: list of trench objects <ARRAY>
 *
 * Return Value:
 * either "done" or "open corner" if a trench network that is not setup correctly was passed <STRING>
 *
 * Example:
 * [[_tronch1]] call ELD_magicTriangle_scripts_fnc_initTrench;
 *
 * Public: No
 */



params ["_oldNetworkTrenches", "_trenchesToRemove", "_newTrenches"];
// dunno yet if more than one oldTrench makes sense

(([_newTrenches] call FUNC(getConfigInfo)) call FUNC(analyseOC)) params ["_blFromConfig", "_tftFromConfig", "_leftOverOC"];

private _trenchPoints = [];
{
	_trenchPoints pushBackUnique (_x # 0);
	_trenchPoints pushBackUnique (_x # 1);
} foreach _blFromConfig;
//find open side by doing TL from removed triangles and finding opening in those

// find points to connect to by having a modified ananlyseOC that finds the original and merged points
// (this may be inefficient but the only other option i can think of is to save all changed positions and whatnot into variables stored in the trench objects)

// /* data i need: 
//  * OC from _oldNetworkTrenches to connect to
//  * OC from _newTrenches to connect to
//  * points where OC from _oldNetworkTrenches merged with _trenchesToRemove
//  * all borderPoints that are associated with the trenches to remove
//  */

 
(([_oldNetworkTrenches - _trenchesToRemove] call FUNC(getConfigInfo)) call FUNC(analyseOC)) params ["", "", "_oldTrenchesOC"];
(([_trenchesToRemove] call FUNC(getConfigInfo)) call FUNC(analyseOC)) params ["_blTrenchesToRemove", "", "_trenchesToRemoveOC"];
private _oldOC = _oldTrenchesOC + _trenchesToRemoveOC;
private _oldOCMergePoints = [];


//oc stands for open corner
private _analysingOC = ((count _oldOC) > 0);

while {_analysingOC} do {
	private _thisOC = _oldOC # 0;
	private _ocListCompare = + _oldOC;
	_ocListCompare deleteAt 0;
	private _found = false;
	private _matchingOC = [];
	for "_i" from 0 to ((count _ocListCompare) - 1) do {
		private _compOC = _ocListCompare # _i;
		if ((_thisOC vectorDistance _compOC) < MAX_OC_DISTANCE) then {
			_found = true;
			_matchingOC = _compOC;
			_ocListCompare deleteAt _i;
			break;
		};
	};
	
	if (!_found) then {
		throw "how the fuck";
	} else {
		private _newPos = ((_thisOC vectorAdd _matchingOC) vectormultiply 0.5);
		
		_oldOCMergePoints append [_newPos];
		
		_oldOC = + _ocListCompare;
	};
	_analysingOC = ((count _oldOC) > 0); 
};

private _newOC = _oldTrenchesOC + _leftOverOC;
private _newOCMergePointsPairs = [];// pairs in format [oldTrenchOCpos, mergedPos]
private _analysingOC = ((count _newOC) > 0);

while {_analysingOC} do {
	private _thisOC = _newOC # 0;
	private _ocListCompare = + _newOC;
	_ocListCompare deleteAt 0;
	private _found = false;
	private _matchingOC = [];
	for "_i" from 0 to ((count _ocListCompare) - 1) do {
		private _compOC = _ocListCompare # _i;
		if ((_thisOC vectorDistance _compOC) < MAX_OC_DISTANCE) then {
			_found = true;
			_matchingOC = _compOC;
			_ocListCompare deleteAt _i;
			break;
		};
	};
	
	if (!_found) then {
		throw "how the fuck";
	} else {
		private _newPos = ((_thisOC vectorAdd _matchingOC) vectormultiply 0.5);
		for "_i" from 0 to ((count _oldTrenchesOC) - 1) do {
			if (((_oldTrenchesOC # _i) isEqualTo _thisOC) || ((_oldTrenchesOC # _i) isEqualTo _matchingOC)) then {
				_newOCMergePointsPairs append [[(_oldTrenchesOC # _i), _newPos]];
			};
		};
		
		
		
		_newOC = + _ocListCompare;
	};
	_analysingOC = ((count _newOC) > 0); 
};


//_oldOC = _oldTrenchesOC + _trenchesToRemoveOC;

[_oldOCMergePoints + (_trenchPoints - _leftOverOC), _oldTrenchesOC, _newOCMergePointsPairs];


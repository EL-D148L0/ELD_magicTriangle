#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * replaces the references to the old trench with references to the new trench
 *
 * Arguments:
 *	0: old trench
 *	1: new trench
 * 
 *
 * Return Value:
 * none
 *		
 *
 * Example:
 * [_trench] call ELD_magicTriangle_scripts_fnc_replaceTrenchTTR;
 *
 * Public: No
 */



params ["_oldTrench", "_newTrench"];


private _ttrList = [_oldTrench getvariable "terrainPoints"] call ELD_magicTriangle_scripts_fnc_getTerrainTrianglesFromLoweredPoints;

{
	private _key = _x;
	private _isNew = !(_key in GVAR(terrainTriangleMap));
	if (_isNew) throw "original trench was not correctly registered";
	private _entry = GVAR(terrainTriangleMap) getordefault [_key, []];
	_entry params [
			["_originalCornerPositions", [_key] call FUNC(TTRKeyToTriangle)], 
			["_normal", []], 
			["_fillerObjects", []], 
			["_associatedTrenches", []]];
	if ((count _normal) == 0) then {
		_normal = vectornormalized (((_originalCornerPositions#0) vectordiff (_originalCornerPositions#2)) vectorCrossProduct ((_originalCornerPositions#0) vectordiff (_originalCornerPositions#1)));
	};
	_associatedTrenches = (_associatedTrenches - [_oldTrench]) + [_newTrench];

	
	 GVAR(terrainTriangleMap) set [_key, [_originalCornerPositions, _normal, _fillerObjects, _associatedTrenches]];
	
} forEach _ttrList;
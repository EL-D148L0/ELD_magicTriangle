#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * fixes TTR info and filler
 *
 * Arguments:
 *	0: trench to fix TTR for
 * 
 *
 * Return Value:
 * none
 *		
 *
 * Example:
 * [_trench] call ELD_magicTriangle_scripts_fnc_fixTTR;
 *
 * Public: No
 */



params ["_trench"];


private _ttrList = [_trench getvariable "terrainPoints"] call ELD_magicTriangle_scripts_fnc_getTerrainTrianglesFromLoweredPoints;

{
	private _key = _x;
	//private _isNew = !(_key in GVAR(terrainTriangleMap));
	private _entry = GVAR(terrainTriangleMap) getordefault [_key, []];
	_entry params [
			["_originalCornerPositions", [_key] call FUNC(TTRKeyToTriangle)], 
			["_normal", vectornormalized (((_originalCornerPositions#0) vectordiff (_originalCornerPositions#2)) vectorCrossProduct ((_originalCornerPositions#0) vectordiff (_originalCornerPositions#1)))], 
			["_fillerObjects", []], 
			["_associatedTrenches", []]];
	_associatedTrenches pushBack _trench;

	
	 GVAR(terrainTriangleMap) set [_key, [_originalCornerPositions, _normal, _fillerObjects, _associatedTrenches]];
	// do fix ground
	private _triangles = [[_key] call FUNC(getTTRIntersectedPolygons)] call FUNC(fillPolygons);
	
	{
		// Current result is saved in variable _x
		deletevehicle _x;
	} forEach _fillerObjects;
	_fillerObjects = _triangles;
	 GVAR(terrainTriangleMap) set [_key, [_originalCornerPositions, _normal, _fillerObjects, _associatedTrenches]];
	
} forEach _ttrList;
#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * adds the trench to the trenchlists of its Terrainpoints.
 *
 * Arguments:
 *	0: trench to fix TTR for
 * 
 *
 * Return Value:
 * TP that should get the TTR around them updated.
 *		
 *
 * Example:
 * [_trench] call ELD_magicTriangle_scripts_fnc_TPAddTrench;
 *
 * Public: No
 */



params ["_trench"];


private _tpList = (_trench getvariable "terrainPoints") apply {[_x#0, _x#1]};

{
	private _key = _x;
	private _entry = GVAR(terrainPointMap) getordefault [_key, []];
	_entry params [
			["_originalTerrainPosition", _key + [getTerrainHeight _key]], 
			["_associatedTrenches", []], 
			["_fillerObjects", [[],[]]]
			];
	_associatedTrenches pushBack _trench;

	
	GVAR(terrainPointMap) set [_key, [_originalTerrainPosition, _associatedTrenches, _fillerObjects]];
	
} forEach _tpList;
_tpList;
#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * returns the polygons that marks the outline of the hole in the terrain specified 
 *		by the points of terrain locations, as well as the outlines of islands within it.
 * for unconnected terrain holes, it will notice that they are unconnected and return their outlines seperately.
 *
 * Arguments:
 *	0: array of positions in format position2d or 3d <ARRAY>
 * 		lowered terrain points
 * 
 *
 * Return Value:
 * array of arrays <ARRAY>
 *		the individual Polygons (should be just one, but could be more) in the format:
 *			0: array of corner positions in format position2d <ARRAY>
 *				the positions of the outer polygon of the hole in question
 *			1: array of arrays <ARRAY>
 *				the polygon outlines of any potential islands in the hole, in format:
 *					array of corner positions in format position2d <ARRAY>
 *		
 *
 * Example:
 * [[_pos1, _pos2]] call ELD_magicTriangle_scripts_fnc_getTerrainPolygonsWithIslands;
 *
 * Public: No
 */


params ["_positions"];


private _outline1 = [_positions] call FUNC(getTerrainPolygon);
private _islandsAndHoles = [_positions, _outline1] call FUNC(getTerrainHoleIslands);
private _otherHolePositions = _islandsAndHoles # 1;
private _islandPositions = _islandsAndHoles # 0;// i need a function to get the polygon outline of an island
private _islandOutlines = [];
while {(count _islandPositions) > 0} do {
	private _thisIslandOutline = ([_islandPositions] call FUNC(getIslandPolygon)) apply {[_x # 0, _x # 1, 0]};
	private _islandPositionsNew = [];
	{
		if (!(([_x#0,_x#1, 0] inPolygon _thisIslandOutline) || {[_x, _thisIslandOutline] call FUNC(pointInList2d)})) then {
			_islandPositionsNew pushBack _x;
		};
	} forEach _islandPositions;
	_islandOutlines pushBack (_thisIslandOutline apply {[_x # 0, _x # 1]});
	_islandPositions = _islandPositionsNew;
};


private _return = [[_outline1, _islandOutlines]];
if ((count _otherHolePositions) > 0) then {
	_return append ([_otherHolePositions] call FUNC(getTerrainPolygonsWithIslands));
};

_return;

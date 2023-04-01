#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * returns information on which TTR are affected by changing a set of terrain points 
 *
 * Arguments:
 *	0: array of positions in format position2d or 3d <ARRAY>
 * 		lowered terrain points
 * 
 *
 * Return Value:
 * array of affected TTR <ARRAY>
 * 		elements in format:
 *			0: position X <NUMBER>
 *			1: position Y <NUMBER>
 *			2: 0 if bottom triangle, 1 if top triangle <NUMBER>
 *		
 *
 * Example:
 * [[_pos1, _pos2]] call ELD_magicTriangle_scripts_fnc_getTerrainTrianglesFromLoweredPoints;
 *
 * Public: No
 */



params ["_positions"];



// N, E, SE, S, W, NW
private _directions = [[0,GVAR(cellSize)], [GVAR(cellSize), 0], [GVAR(cellSize),-GVAR(cellSize)], [0,-GVAR(cellSize)],[-GVAR(cellSize),0],[-GVAR(cellSize),GVAR(cellSize)]];


private _out = [];

{
	
	_out pushbackunique [_x # 0, _x#1, 0];
	private _west = _x vectorAdd (_directions # 4);
	_out pushbackunique [_west # 0, _west#1, 0];
	_out pushbackunique [_west # 0, _west#1, 1];
	private _south = _x vectorAdd (_directions # 3);
	_out pushbackunique [_south # 0, _south#1, 0];
	_out pushbackunique [_south # 0, _south#1, 1];
	private _southWest = _south vectorAdd (_directions # 4);
	_out pushbackunique [_southWest # 0, _southWest#1, 1];

} forEach _positions;


_out;
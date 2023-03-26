#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * returns current corner positions of terrain triangle matching the passed key. 
 * does not check if they have been modified. this function should only be used for getting info when registering new TTR
 *
 * Arguments:
 *	0: array in format TTRKey <ARRAY>:
 *			0: position X <NUMBER>
 *			1: position Y <NUMBER>
 *			2: 0 if bottom triangle, 1 if top triangle <NUMBER>
 * 
 *
 * Return Value:
 * array of 3 positionASL <ARRAY>
 *		
 *
 * Example:
 * [[_pos1, _pos2]] call ELD_magicTriangle_scripts_fnc_TTRKeyToTriangle;
 *
 * Public: No
 */



params ["_key"];



private _cellsize = getTerrainInfo#2;
// N, E, SE, S, W, NW
private _directions = [[0,_cellsize], [_cellsize, 0], [_cellsize,-_cellsize], [0,-_cellsize],[-_cellsize,0],[-_cellsize,_cellsize]];




if (_key#2 == 0) exitwith {
	private _north = _key vectorAdd (_directions # 0);
	private _east = _key vectorAdd (_directions # 1);
	private _positions = [_key, _north, _east];
	_positions apply {
		[_x#0, _x#1, getterrainheight [_x#0, _x#1]];
	};
};
if (_key#2 == 1) exitwith {
	private _north = _key vectorAdd (_directions # 0);
	private _east = _key vectorAdd (_directions # 1);
	private _northEast = _north vectorAdd (_directions # 1);
	private _positions = [_northEast, _east, _north];
	_positions apply {
		[_x#0, _x#1, getterrainheight [_x#0, _x#1]];
	};
};
throw "invalid key in TTRKeyToTriangle";
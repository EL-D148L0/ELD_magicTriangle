#include "script_component.hpp"

/*
 * Author: EL_D148L0
 * updates  filler of the TTR around the passed TP. only adjust the altitude of the filler, does not chnage the shape. 
 * visual filler objects are kept and animated, colliders are newly spawned.
 * adds neutral positions to unregistered TP around passed TP
 *
 * Arguments:
 *	0: array of terrainpoints <ARRAY>
 * 
 *
 * Return Value:
 * TP that should get the TTR around them updated.
 *		
 *
 * Example:
 * [[1624,5328], [1628,5328]] call ELD_magicTriangle_scripts_fnc_TPUpdateFillerHeight;
 *
 * Public: No
 */


//TODO this function hangs for 2-4 seconds if supplied with invalid data
params ["_tpList"];

diag_log _tpList;
private _ttrList = [_tpList] call FUNC(getTerrainTrianglesFromLoweredPoints);


diag_log _ttrList;
{
	// Current result is saved in variable _x
	private _ttrKey = _x;
	private _pointA = [];
	private _pointB = [];
	private _pointC = [];
	private _trenches = [];
	if ((_ttrKey # 2) == 0) then {
		private _temp = [_ttrKey#0, _ttrKey#1];
		_temp = GVAR(terrainPointMap) getOrDefault [_temp, [_temp + [getTerrainHeight _temp], [], [[],[]]], true];
		_trenches append (_temp # 1);
		_pointA = _temp # 0;
		_temp = [_ttrKey#0, _ttrKey#1 + GVAR(cellSize)];
		_temp = GVAR(terrainPointMap) getOrDefault [_temp, [_temp + [getTerrainHeight _temp], [], [[],[]]], true];
		_trenches append (_temp # 1);
		_pointB = _temp # 0;
		_temp = [_ttrKey#0 + GVAR(cellSize), _ttrKey#1];
		_temp = GVAR(terrainPointMap) getOrDefault [_temp, [_temp + [getTerrainHeight _temp], [], [[],[]]], true];
		_trenches append (_temp # 1);
		_pointC = _temp # 0;
	} else {
		private _temp = [_ttrKey#0 + GVAR(cellSize), _ttrKey#1];
		_temp = GVAR(terrainPointMap) getOrDefault [_temp, [_temp + [getTerrainHeight _temp], [], [[],[]]], true];
		_trenches append (_temp # 1);
		_pointA = _temp # 0;
		_temp = [_ttrKey#0, _ttrKey#1 + GVAR(cellSize)];
		_temp = GVAR(terrainPointMap) getOrDefault [_temp, [_temp + [getTerrainHeight _temp], [], [[],[]]], true];
		_trenches append (_temp # 1);
		_pointB = _temp # 0;
		_temp = [_ttrKey#0 + GVAR(cellSize), _ttrKey#1 + GVAR(cellSize)];
		_temp = GVAR(terrainPointMap) getOrDefault [_temp, [_temp + [getTerrainHeight _temp], [], [[],[]]], true];
		_trenches append (_temp # 1);
		_pointC = _temp # 0;
	};

	
	
	
	private _key =  [_ttrKey#0, _ttrKey#1];
	private _entry = GVAR(terrainPointMap) getordefault [_key, []];
	_entry params [
			["_originalTerrainPosition", _key + [getTerrainHeight _key]], 
			["_associatedTrenches", []], 
			["_fillerObjects", [[],[]]]
			];

		
	private _normal = vectornormalized ((_pointA vectordiff _pointC) vectorCrossProduct (_pointA vectordiff _pointB));;
	private _p = _pointA;
	{
		private _triangleObject = _x;
		private _pos1 = _triangleObject modelToWorldWorld (_triangleObject selectionPosition ["Corner_1_Pos", "Memory"]);
		private _pos2 = _triangleObject modelToWorldWorld (_triangleObject selectionPosition ["Corner_2_Pos", "Memory"]);
		private _pos3 = _triangleObject modelToWorldWorld (_triangleObject selectionPosition ["Corner_3_Pos", "Memory"]);

		
		private _height1 = ((_normal#0 * (_pos1#0 - _p#0) + _normal#1 * (_pos1#1 - _p#1))/(-(_normal#2))) + _p#2;
		private _height2 = ((_normal#0 * (_pos2#0 - _p#0) + _normal#1 * (_pos2#1 - _p#1))/(-(_normal#2))) + _p#2;
		private _height3 = ((_normal#0 * (_pos3#0 - _p#0) + _normal#1 * (_pos3#1 - _p#1))/(-(_normal#2))) + _p#2;

		private _pos1New = [_pos1#0, _pos1#1, _height1];
		private _pos2New = [_pos2#0, _pos2#1, _height2];
		private _pos3New = [_pos3#0, _pos3#1, _height3];

		private _minX = (_pos1New#0) min (_pos2New#0) min (_pos3New#0);
		private _minY = (_pos1New#1) min (_pos2New#1) min (_pos3New#1);
		private _minZ = (_pos1New#2) min (_pos2New#2) min (_pos3New#2);
		
		private _maxX = (_pos1New#0) max (_pos2New#0) max (_pos3New#0);
		private _maxY = (_pos1New#1) max (_pos2New#1) max (_pos3New#1);
		private _maxZ = (_pos1New#2) max (_pos2New#2) max (_pos3New#2);
		
		private _scale = (_maxX - _minX) max (_maxY - _minY) max (_maxZ - _minZ);
		//TODO if scale is larger than current model, switch out the model. take care that this doesn't fuck up the loop.

		_triangleObject setPosASL [_minX, _minY, _minZ];

		
		/*TODO change triangle models so that the resting positions of the corners are at [0,0,0]. this will allow me to set absolute values witout figuring out the resting pos first. 
		 *  	while doing that, also fix the missing material file in the model
		 * 		this will also fix the need to look up the positions again here
		*/
		_pos1 = _triangleObject modelToWorldWorld (_triangleObject selectionPosition ["Corner_1_Pos", "Memory"]);
		_pos2 = _triangleObject modelToWorldWorld (_triangleObject selectionPosition ["Corner_2_Pos", "Memory"]);
		_pos3 = _triangleObject modelToWorldWorld (_triangleObject selectionPosition ["Corner_3_Pos", "Memory"]);
		//TODO switch to animateSource instead of animate, wiki says it's more efficient.
		_triangleObject animate ["Corner_1_UD", _height1 - _pos1#2 + (_triangleObject animationPhase "Corner_1_UD"), true];
		_triangleObject animate ["Corner_2_UD", _height2 - _pos2#2 + (_triangleObject animationPhase "Corner_2_UD"), true];
		_triangleObject animate ["Corner_3_UD", _height3 - _pos3#2 + (_triangleObject animationPhase "Corner_3_UD"), true];

		
		private _colliders = [_pos1, _pos2, _pos3] call FUNC(createTriangleCollider);
		{
			deleteVehicle _x;
		} foreach (_triangleObject getVariable "colliders");
		_triangleObject setVariable ["colliders", _colliders];

	} forEach (_fillerObjects# (_ttrKey#2));

	
} forEach _ttrList;


#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * create a triangle filler object from an array of 3 points.
 *
 * Arguments:
 * 0: Position of corner in format PositionASL <ARRAY>
 * 1: Position of corner in format PositionASL <ARRAY>
 * 2: Position of corner in format PositionASL <ARRAY>
 * 3: which texture and material to use <NUMBER> (optional, default 1) //TODO change the default
 * 		0: ground texture at the center point and zemlia.rvmat
 * 		1: random debug color
 * 		2: default triangle object
 *
 * Return Value:
 * array of triangle filler objects <ARRAY>
 *
 * Example:
 * [[1991.94,5567.88,6.89202],[1994.63,5571.75,6.89802],[1995.49,5567,6.89769]] call ELD_magicTriangle_scripts_fnc_createTriangle;
 *
 * Public: No
 */


params ["_pos1", "_pos2", "_pos3", ["_texture", GVAR(defaultTriangleColor)]];

([_pos1, _pos2, _pos3] call FUNC(sortTriangleCorners)) params ["_pos1", "_pos2", "_pos3"];




// private _triangleClass = "TriangleNoCollision10";
private _triangleClass ="TriangleNoCollision24OM";
_maxsize = 24;


private _maxX = _pos1#0;
private _maxY = _pos1#1;
private _maxZ = _pos1#2;
private _minX = _pos1#0;
private _minY = _pos1#1;
private _minZ = _pos1#2;
{
	_maxX = _maxX max _x#0;
	_maxY = _maxY max _x#1;
	_maxZ = _maxZ max _x#2;
	_minX = _minX min _x#0;
	_minY = _minY min _x#1;
	_minZ = _minZ min _x#2;
} forEach [_pos1, _pos2, _pos3];

private _scale = (_maxX - _minX) max (_maxY - _minY) max (_maxZ - _minZ);
if (_scale > _maxsize) exitWith {
	private _return = [];
	{
		_return append ((_x + [_texture]) call FUNC(createTriangle));
	} forEach ([_pos1, _pos2, _pos3] call FUNC(splitTriangle));
	_return;
};


//private _triangleObject = createSimpleObject [_triangleClass, [_minX, _minY, _minZ]];
private _triangleObject = createVehicle [_triangleClass, [_minX, _minY, _minZ], [], 0, "CAN_COLLIDE"];
_triangleObject setPosASL [_minX, _minY, _minZ];

_triangleObject setvectordirandup [[0,1,0], [0,0,1]];

private _pos1Diff = (_triangleObject worldToModel ASLToAGL _pos1) vectorDiff (_triangleObject selectionPosition ["Corner_1_Pos", "Memory"]);
private _pos2Diff = (_triangleObject worldToModel ASLToAGL _pos2) vectorDiff (_triangleObject selectionPosition ["Corner_2_Pos", "Memory"]);
private _pos3Diff = (_triangleObject worldToModel ASLToAGL _pos3) vectorDiff (_triangleObject selectionPosition ["Corner_3_Pos", "Memory"]);


_triangleObject animate ["Corner_1_LR", _pos1Diff # 0, true];
_triangleObject animate ["Corner_1_FB", _pos1Diff # 1, true];
_triangleObject animate ["Corner_1_UD", _pos1Diff # 2, true];


_triangleObject animate ["Corner_2_LR", _pos2Diff # 0, true];
_triangleObject animate ["Corner_2_FB", _pos2Diff # 1, true];
_triangleObject animate ["Corner_2_UD", _pos2Diff # 2, true];


_triangleObject animate ["Corner_3_LR", _pos3Diff # 0, true];
_triangleObject animate ["Corner_3_FB", _pos3Diff # 1, true];
_triangleObject animate ["Corner_3_UD", _pos3Diff # 2, true];


if (_texture == 0) then {
	private _posAVG = ((_pos1) vectorAdd ((_pos2) vectorAdd (_pos3))) vectorMultiply (1/3);
	_triangleObject setObjectTextureGlobal [0, surfaceTexture _posAVG];
} else {
	if (_texture == 1) then {
		_triangleObject setObjectTexture [0, call FUNC(randomColor)];
		_triangleObject setObjectMaterial [0, ""];
	};
};


private _colliders = [_pos1, _pos2, _pos3] call FUNC(createTriangleCollider);
_triangleObject setVariable ["colliders", _colliders];

_triangleObject addEventHandler ["Deleted", {
	params ["_entity"];
	{
		deleteVehicle _x;
	} forEach (_entity getVariable "colliders");
}];

[_triangleObject];

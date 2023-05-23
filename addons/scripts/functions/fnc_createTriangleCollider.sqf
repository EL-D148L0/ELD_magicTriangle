#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * create simple objects that act as a collider for vehicles for a triangle
 *
 * Arguments:
 * 0: Position of corner in format PositionASL <ARRAY>
 * 1: Position of corner in format PositionASL <ARRAY>
 * 2: Position of corner in format PositionASL <ARRAY>
 *
 * Return Value:
 * triangle collider simple objects <ARRAY>
 *
 * Example:
 * [[1991.94,5567.88,6.89202],[1994.63,5571.75,6.89802],[1995.49,5567,6.89769]] call ELD_magicTriangle_scripts_fnc_createTriangleCollider;
 *
 * Public: No
 */






//this procedure sorts the points so the object doesn't get turned inside out


(_this call FUNC(sortTriangleCorners)) params ["_pos1", "_pos2", "_pos3"];



/* sides are as follows :
	0: 1-2
	1: 2-3
	2: 3-1
*/
private _longestSide = 0;
private _length0 = _pos1 vectorDistance _pos2;
private _length1 = _pos2 vectorDistance _pos3;
private _length2 = _pos3 vectorDistance _pos1;

_area = 0.25* (sqrt (( (_length1 + _length0 + _length2) * (-_length0 + _length1 + _length2) * (_length0 - _length1 + _length2) * (_length0 + _length1 - _length2) )));
if (!finite _area) exitWith {
	// this is here to fix a bug where extremely thin triangles behaved unpredictably
	[];
};

/*
			A
			|\
			|°\
			|  \
			| 1 \
			|    \
			P|----->B
			|   °/
			| 2 /
			|  /
			| /
			|/
			C
*/

private _pointA = [];
private _pointB = [];
private _pointC = [];
private _pointP = [];

if (_length0 >= _length1 && _length0 >= _length2) then {
	//_longestSide = 0;
	_pointA = _pos2;
	_pointC = _pos1;
	_pointB = _pos3;
} else {
	if (_length1 >= _length0 && _length1 >= _length2) then {
		_longestSide = 1;
		_pointA = _pos3;
		_pointC = _pos2;
		_pointB = _pos1;
	} else {
		_longestSide = 2;
		_pointA = _pos1;
		_pointC = _pos3;
		_pointB = _pos2;
	};
};

private _vectorAC = _pointC vectorDiff _pointA;


_pointP = _pointA vectordiff (_vectorAC vectorMultiply (((_pointA vectorDiff _pointB) vectorDotProduct _vectorAC)/(_vectorAC vectorDotProduct _vectorAC))); 

if ((_pointP vectorDistance _pointB) < 0.015) exitWith {
	// this is here to fix a bug where extremely thin triangles behaved unpredictably.
	// if this condition is too generous, nake the number smaller. last observed problematic triangle had a distance of 0.000488281
	[];
};

private _vectorAP = _pointP vectorDiff _pointA;
private _vectorAB = _pointB vectorDiff _pointA;
private _triangle1Angle = acos (_vectorAB vectorCos _vectorAP);// round down

//private _triangle1Scale = vectorMagnitude _vectorAP;

private _vectorBP = _pointP vectorDiff _pointB;
private _vectorBC = _pointC vectorDiff _pointB;
private _vectorBA = _pointA vectorDiff _pointB;
private _triangle2Angle = acos (_vectorBP vectorCos _vectorBC);// round up


private _files = addonFiles ["magicTriangle\colliderGen0\", ".p3d"];

private _doTriangle1 = finite _triangle1Angle;
private _doTriangle2 = finite _triangle2Angle;
private _vectorUp = vectorNormalized ((_vectorBC vectorCrossProduct _vectorBA) vectormultiply -1);
private _triangle1 = objNull;
private _triangle2 = objNull;
if (_doTriangle1) then {
	private _triangle1Model = [_triangle1Angle] call FUNC(getTriangleColliderModel);
	private _vectorDir1 = vectorNormalized (_pointA vectorDiff _pointP);
	_triangle1 = createSimpleObject  [_triangle1Model, _pointP];
	_triangle1 setvectordirandup [_vectorDir1, _vectorUp];
	private _triangle1Scale = (vectorMagnitude _vectorAP) max ((vectorMagnitude _vectorBP)/((_triangle1 selectionPosition ["corner_3", "Memory"]) # 0));
	_triangle1 setobjectscale _triangle1Scale;

} else {
	diag_log "non finite collider angle requested on collider 1. offending triangle: ";
	diag_log [_pointA, _pointB, _pointC];
};
if (_doTriangle2) then {
	private _triangle2Model = [_triangle2Angle] call FUNC(getTriangleColliderModel);
	private _vectorDir2 = vectorNormalized (_pointB vectorDiff _pointP);
	_triangle2 = createSimpleObject  [_triangle2Model, _pointP];
	_triangle2 setvectordirandup [_vectorDir2, _vectorUp];
	private _triangle2Scale = (vectorMagnitude _vectorBP) max ((vectorMagnitude (_pointC vectorDiff _pointP))/((_triangle2 selectionPosition ["corner_3", "Memory"]) # 0));
	_triangle2 setobjectscale _triangle2Scale;
} else {
	diag_log "non finite collider angle requested on collider 2. offending triangle: ";
	diag_log [_pointA, _pointB, _pointC];
};


[_triangle1, _triangle2];



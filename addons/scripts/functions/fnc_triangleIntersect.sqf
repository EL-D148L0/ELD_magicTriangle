#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * calculates whether the sides of two triangles cross each other in 2d space.
 * this is no longer an accurate check of trinagle intersection. triangle in triangle is not checked.
 * coincident sides should return false iirc.
 *
 * Arguments:
 * 0: array of positions of the corners of the first triangle in format Position2d or Position3d <ARRAY>
 * 1: array of positions of the corners of the second triangle in format Position2d or Position3d <ARRAY>
 *
 * Return Value:
 * whether the sides of the two triangles cross each other in 2d space <BOOLEAN>
 *
 * Example:
 * [[[1,1], [1,7], [7,1]], [[2,2], [8,8], [9, 20]]] call ELD_magicTriangle_scripts_fnc_triangleIntersect;
 *
 * Public: No
 */



// _deb1 = false;

params ["_t1", "_t2"];

((((((((([((_t1 # 0) # 0), ((_t1 # 0) # 1), ((_t1 # 1) # 0), ((_t1 # 1) # 1), ((_t2 # 0) # 0), ((_t2 # 0) # 1), ((_t2 # 1) # 0), ((_t2 # 1) # 1)] call FUNC(linesIntersect)) || 
{([((_t1 # 0) # 0), ((_t1 # 0) # 1), ((_t1 # 1) # 0), ((_t1 # 1) # 1), ((_t2 # 1) # 0), ((_t2 # 1) # 1), ((_t2 # 2) # 0), ((_t2 # 2) # 1)] call FUNC(linesIntersect))}) || 
{([((_t1 # 0) # 0), ((_t1 # 0) # 1), ((_t1 # 1) # 0), ((_t1 # 1) # 1), ((_t2 # 2) # 0), ((_t2 # 2) # 1), ((_t2 # 0) # 0), ((_t2 # 0) # 1)] call FUNC(linesIntersect))}) || 
{([((_t1 # 1) # 0), ((_t1 # 1) # 1), ((_t1 # 2) # 0), ((_t1 # 2) # 1), ((_t2 # 0) # 0), ((_t2 # 0) # 1), ((_t2 # 1) # 0), ((_t2 # 1) # 1)] call FUNC(linesIntersect))}) || 
{([((_t1 # 1) # 0), ((_t1 # 1) # 1), ((_t1 # 2) # 0), ((_t1 # 2) # 1), ((_t2 # 1) # 0), ((_t2 # 1) # 1), ((_t2 # 2) # 0), ((_t2 # 2) # 1)] call FUNC(linesIntersect))}) || 
{([((_t1 # 1) # 0), ((_t1 # 1) # 1), ((_t1 # 2) # 0), ((_t1 # 2) # 1), ((_t2 # 2) # 0), ((_t2 # 2) # 1), ((_t2 # 0) # 0), ((_t2 # 0) # 1)] call FUNC(linesIntersect))}) || 
{([((_t1 # 2) # 0), ((_t1 # 2) # 1), ((_t1 # 0) # 0), ((_t1 # 0) # 1), ((_t2 # 0) # 0), ((_t2 # 0) # 1), ((_t2 # 1) # 0), ((_t2 # 1) # 1)] call FUNC(linesIntersect))}) || 
{([((_t1 # 2) # 0), ((_t1 # 2) # 1), ((_t1 # 0) # 0), ((_t1 # 0) # 1), ((_t2 # 1) # 0), ((_t2 # 1) # 1), ((_t2 # 2) # 0), ((_t2 # 2) # 1)] call FUNC(linesIntersect))}) || 
{([((_t1 # 2) # 0), ((_t1 # 2) # 1), ((_t1 # 0) # 0), ((_t1 # 0) # 1), ((_t2 # 2) # 0), ((_t2 # 2) # 1), ((_t2 # 0) # 0), ((_t2 # 0) # 1)] call FUNC(linesIntersect))});

//this part is no longer needed i believe
/*{([_t10, _t2] call FUNC(pointInTriangle)LA);});|| 
{([_t11, _t2] call FUNC(pointInTriangle)LA)}) || 
{([_t12, _t2] call FUNC(pointInTriangle)LA)}) || 
{([_t20, _t1] call FUNC(pointInTriangle)LA)}) || 
{([_t21, _t1] call FUNC(pointInTriangle)LA)}) || 
{([_t22, _t1] call FUNC(pointInTriangle)LA)}) //;
then {if (_deb1) then {debTri append [_this]}; true;} else {pass = pass + 1; false;};*/
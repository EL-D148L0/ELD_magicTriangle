#include "script_component.hpp"

/*
*	no longer an accurate check of trinagle intersection. triangle in triangle is not checked.
*
*
*
*/
// _deb1 = false;

params ["_t1", "_t2"];
private _t10 = (_t1 # 0);
private _t11 = (_t1 # 1);
private _t12 = (_t1 # 2);
private _t20 = (_t2 # 0);
private _t21 = (_t2 # 1);
private _t22 = (_t2 # 2);

private _t100 = (_t10 # 0);
private _t110 = (_t11 # 0);
private _t120 = (_t12 # 0);
private _t200 = (_t20 # 0);
private _t210 = (_t21 # 0);
private _t220 = (_t22 # 0);

private _t101 = (_t10 # 1);
private _t111 = (_t11 # 1);
private _t121 = (_t12 # 1);
private _t201 = (_t20 # 1);
private _t211 = (_t21 # 1);
private _t221 = (_t22 # 1);

//if
((((((((([_t100, _t101, _t110, _t111, _t200, _t201, _t210, _t211] call FUNC(linesIntersect)) || 
{([_t100, _t101, _t110, _t111, _t210, _t211, _t220, _t221] call FUNC(linesIntersect))}) || 
{([_t100, _t101, _t110, _t111, _t220, _t221, _t200, _t201] call FUNC(linesIntersect))}) || 
{([_t110, _t111, _t120, _t121, _t200, _t201, _t210, _t211] call FUNC(linesIntersect))}) || 
{([_t110, _t111, _t120, _t121, _t210, _t211, _t220, _t221] call FUNC(linesIntersect))}) || 
{([_t110, _t111, _t120, _t121, _t220, _t221, _t200, _t201] call FUNC(linesIntersect))}) || 
{([_t120, _t121, _t100, _t101, _t200, _t201, _t210, _t211] call FUNC(linesIntersect))}) || 
{([_t120, _t121, _t100, _t101, _t210, _t211, _t220, _t221] call FUNC(linesIntersect))}) || 
{([_t120, _t121, _t100, _t101, _t220, _t221, _t200, _t201] call FUNC(linesIntersect))});

//this part is no longer needed i believe
/*{([_t10, _t2] call FUNC(pointInTriangle)LA);});|| 
{([_t11, _t2] call FUNC(pointInTriangle)LA)}) || 
{([_t12, _t2] call FUNC(pointInTriangle)LA)}) || 
{([_t20, _t1] call FUNC(pointInTriangle)LA)}) || 
{([_t21, _t1] call FUNC(pointInTriangle)LA)}) || 
{([_t22, _t1] call FUNC(pointInTriangle)LA)}) //;
then {if (_deb1) then {debTri append [_this]}; true;} else {pass = pass + 1; false;};*/
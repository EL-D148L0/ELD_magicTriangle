#include "script_component.hpp"
/*
 * Author: EL_D148L0
 * return a random plain color texture
 *
 * Arguments:
 * none
 *
 * Return Value:
 * texture <STRING>
 *
 * Example:
 *  call ELD_magicTriangle_scripts_fnc_randomColor;
 *
 * Public: No
 */




_r =  random 1; 
_g =  random 1; 
_b =  random 1; 
format ["#(rgb,8,8,3)color(%1,%2,%3,0.15)", _r, _g, _b];
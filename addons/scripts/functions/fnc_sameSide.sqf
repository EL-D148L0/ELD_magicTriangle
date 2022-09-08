#include "script_component.hpp"

params ["_p1", "_p2", "_a", "_b"];
// are 2d or 3d vectors
// does some rounding fuckery to fit my needs, do not use for unrelated stuff
// a and b are the end points of the line
private _v1 = [_b # 0 - _a # 0, _b # 1 - _a # 1];
private _cp1 = (_v1) vectorCrossProduct ([_p1 # 0 - _a # 0, _p1 # 1 - _a # 1]);
private _cp2 = (_v1) vectorCrossProduct ([_p2 # 0 - _a # 0, _p2 # 1 - _a # 1]);
private _f = (_cp1 #2) * (_cp2 #2);
(_f > 0.001);
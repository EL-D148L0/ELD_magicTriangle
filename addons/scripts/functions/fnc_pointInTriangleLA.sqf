#include "script_component.hpp"

//LA for less args
params ["_p1", "_t"];
[_p1, _t # 0, _t # 1, _t # 2] call FUNC(pointInTriangle);
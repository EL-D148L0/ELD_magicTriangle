#include <\a3\editor_f\Data\Scripts\dikCodes.h>

// // #define DEBUG_SYNCHRONOUS
#include "\x\cba\addons\main\script_macros_common.hpp"
#include "\x\cba\addons\xeh\script_xeh.hpp"

// #include "\z\ace\addons\main\script_macros.hpp"

// #define DFUNC(var1) TRIPLES(ADDON,fnc,var1)
// #define DEFUNC(var1,var2) TRIPLES(DOUBLES(PREFIX,var1),fnc,var2)

// #undef QFUNC
// #undef QEFUNC
// #define QFUNC(var1) QUOTE(DFUNC(var1))
// #define QEFUNC(var1,var2) QUOTE(DEFUNC(var1,var2))


#ifdef DISABLE_COMPILE_CACHE
    #undef PREP
    #define PREP(fncName) DFUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)
#else
    #undef PREP
    #define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
#endif



#define MAX_OC_DISTANCE 0.4//maximum distance at which corners will be merged

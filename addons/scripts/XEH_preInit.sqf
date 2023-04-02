#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;



ADDON = true;

GVAR(cellSize) = getTerrainInfo#2;
GVAR(defaultTriangleColor) = 1;

GVAR(coveredTrenchList) = [];



GVAR(trenchRankCounter) = 0;
GVAR(trenchObjectList) = [];
GVAR(terrainPointMap) = createHashMap; //contains all terrain points that have been modified
/* format of the keys: <ARRAY>
 * 		keys are the position of the lower left corner of the square the triangle is contained in.
*			0: position X <NUMBER>
*			1: position Y <NUMBER>
 * format of values: array in format TTR
 *
 *
 * TTR (TerrainTRiangle) is an array that contains information about a triangle of the terrain that has been modified and filled
 * array format TTR:
 * 		0: original corner position of this terrain point <ARRAY>
 *		3: associated trench objects. <ARRAY>
 * 			a trench object is associated when the triangle is affected by terrain modifications of that trench.
 *		2: array of 2 arrays <ARRAY>
 * 			0: filler objects that occupy the triangle northeast of the key point<ARRAY>
 * 			1: filler objects that occupy the triangle northeast of the northeastern triangle point<ARRAY>
 */ 



GVAR(colliderModelMap) = call FUNC(getTriangleColliderModelMap);

//functionname = QFUNC(fullyInitTrenchesWithIntersect);
// functionname2 = "asadasfasf";
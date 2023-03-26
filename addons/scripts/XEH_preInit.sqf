#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;



ADDON = true;



GVAR(coveredTrenchList) = [];



GVAR(trenchRankCounter) = 0;
GVAR(trenchObjectList) = [];
GVAR(terrainTriangleMap) = createHashMap; //contains all terrain triangles that have been modified
/* format of the keys: <ARRAY>
 * 		keys are the position of the lower left corner of the square the triangle is contained in.
*			0: position X <NUMBER>
*			1: position Y <NUMBER>
*			2: 0 if bottom triangle, 1 if top triangle <NUMBER>
 * format of values: array in format TTR
 *
 *
 * TTR (TerrainTRiangle) is an array that contains information about a triangle of the terrain that has been modified and filled
 * array format TTR:
 * 		0: original corner positions in clockwise order <ARRAY>
 * 			0-2: array in format PositionASL
 * 		1: normal vector of te original terrain triangle (normalized, facing up) <ARRAY>
 *		2: filler objects that occupy the area of the triangle <ARRAY>
 *		3: associated trench objects. <ARRAY>
 * 			a trench object is associated when the triangle is affected by terrain modifications of that trench.
 */ 



GVAR(colliderModelMap) = call FUNC(getTriangleColliderModelMap);

//functionname = QFUNC(fullyInitTrenchesWithIntersect);
// functionname2 = "asadasfasf";
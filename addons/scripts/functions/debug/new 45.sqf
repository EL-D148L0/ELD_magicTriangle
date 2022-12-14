


//testing setup start



[] spawn {
	 
	//_this = [[tre0, tre1, tre2, tre3, tre4, tre5, tre6, tre7, tre8, tre9, tre10, tre11]]; 
	_this = [[oblist # 0]];

	// testing setup end

	params ["_trenches"];


	[] call compile preprocessFileLineNumbers "MagicTriangle\scripts\createHoleInGround.sqf";
	//[] call compile preprocessFileLineNumbers "MagicTriangle\scripts\getTerrainPointsToBeLowered.sqf"; // this new thing does not work yet

	_blFromConfig = [];
	_tftFromConfig = [];
	_ocFromConfig = [];
	{
		_thisTrench = _x;
		_blNames = getArray ((configOf _thisTrench) >> "trench_borderLines");
		_blPositions = [];
		{
			_thisblCoords = [_thisTrench modelToWorldWorld (_thisTrench selectionPosition [_x # 0, "Memory"]), _thisTrench modelToWorldWorld (_thisTrench selectionPosition [_x # 1, "Memory"])];
			_blPositions append [_thisblCoords];
		} foreach _blNames;
		
		_tftNames = getArray ((configOf _thisTrench) >> "trench_fillingTriangles");
		_tftPositions = [];
		{
			_thistftCoords = [_thisTrench modelToWorldWorld (_thisTrench selectionPosition [_x # 0, "Memory"]), _thisTrench modelToWorldWorld (_thisTrench selectionPosition [_x # 1, "Memory"]), _thisTrench modelToWorldWorld (_thisTrench selectionPosition [_x # 2, "Memory"])];
			_tftPositions append [_thistftCoords];
		} foreach _tftNames;
		
		_ocNames = getArray ((configOf _thisTrench) >> "trench_openCorners");
		_ocPositions = [];
		{
			_thisocCoords = (_thisTrench modelToWorldWorld (_thisTrench selectionPosition [_x, "Memory"]));
			_ocPositions append [_thisocCoords];
		} foreach _ocNames;
		
		_blFromConfig append _blPositions;
		_tftFromConfig append _tftPositions;
		_ocFromConfig append _ocPositions;
		
	} foreach _trenches;

	//oc stands for open corner
	_analysingOC = ((count _ocFromConfig) > 0);
	_maxOCdistance = 0.4; //maximum distance at which corners will be merged
	_maxOCdistanceSquared = _maxOCdistance ^ 2;
	_errorEndScript = false;
	while {_analysingOC} do {
		_thisOC = _ocFromConfig # 0;
		_ocListCompare = + _ocFromConfig;
		_ocListCompare deleteAt 0;
		_found = false;
		_matchingOC = [];
		for "_i" from 0 to ((count _ocListCompare) - 1) do {
			_compOC = _ocListCompare # _i;
			if ((_thisOC vectorDistance _compOC) < _maxOCdistance) then { //i assume using distanceSqr is cheaper
				_found = true;
				_matchingOC = _compOC;
				_ocListCompare deleteAt _i;
				break;
			};
		};
		
		if (!_found) then {
			errorOC = _thisOC;
			hint "Open corner detected" + str _thisOC;
			_errorEndScript = true;
			break;
		} else {
			_newPos = ((_thisOC vectorAdd _matchingOC) vectormultiply 0.5);
			
			for "_i" from 0 to ((count _blFromConfig) - 1) do {
				_thisElement = _blFromConfig # _i;
				for "_k" from 0 to ((count _thisElement) - 1) do {
					if (((_thisElement # _k) isEqualTo _thisOC) || ((_thisElement # _k) isEqualTo _matchingOC)) then {
						_thisElement set [_k, _newPos];
						_blFromConfig set [_i, _thisElement];
					}; 
				};
			};
			
			for "_i" from 0 to ((count _tftFromConfig) - 1) do {
				_thisElement = _tftFromConfig # _i;
				for "_k" from 0 to ((count _thisElement) - 1) do {
					if (((_thisElement # _k) isEqualTo _thisOC) || ((_thisElement # _k) isEqualTo _matchingOC)) then {
						_thisElement set [_k, _newPos];
						_tftFromConfig set [_i, _thisElement];
					}; 
				};
			};
			
			_ocFromConfig = + _ocListCompare;
		};
		_analysingOC = ((count _ocFromConfig) > 0); 
	};
	if (_errorEndScript) exitwith {"open corner"}; // stop if open corner 




	_pointsToModify = [_trenches] call makeManyHole;
	_terrainLines = [_pointsToModify] call getTerrainlines;
	//d = _terrainLines;
	



	
	_terrainPoints = [];

	{
		_terrainPoints pushBackUnique ((_x # 0) select [0,2]);
		_terrainPoints pushBackUnique ((_x # 1) select [0,2]);
	} foreach _terrainLines;
	
	_PTMForList = [];
	{
		_PTMForList pushBackUnique (_x select [0,2]);
	} foreach _pointsToModify;

	_allAffectedTP = (_terrainPoints + _PTMForList);//bad var name
	
	
	_clashingCoveredTrenches = [];
	
	_len = count GVAR(coveredTrenchList);
	
	for "_i" from 0 to ((_len) - 1) do {
		if ((count (_PTMForList arrayIntersect ((GVAR(coveredTrenchList) # _i # 5) + (GVAR(coveredTrenchList) # _i # 1)))) > 0) then {
			_clashingCoveredTrenches append [_i];
		};
	};
	
	
	//setup for data storage 
	private _trenchesAdd = [];
	private _PTMForListAdd = [];
	private _trianglesPositionsAndObjectsAdd = [];
	private _tftFromConfigAdd = [];
	private _blFromConfigAdd = [];
	private _trenchPointsAdd = [];
	private _terrainPointsAdd = [];
	private _terrainPointsForList = + _terrainPoints;
	
	
	private _PTMForListToNotLower = [];

	
	// this is all done assuming that the trench objects do not intersect or get too close to each other or anything
	_trianglesToDelete = [];
	{
		private _thisCTLEntry = (GVAR(coveredTrenchList) # _x);
		
		_trenchesAdd append (_thisCTLEntry # 0);
		_PTMForListAdd append (_thisCTLEntry # 1);
		_tftFromConfigAdd append (_thisCTLEntry # 3);
		_blFromConfigAdd append (_thisCTLEntry # 6);
		_trenchPointsAdd append (_thisCTLEntry # 7);
		
		_terrainPointsAdd append ((_thisCTLEntry # 5) - _PTMForList);
		
		_terrainPointsForList = _terrainPointsForList - ((_thisCTLEntry # 5) + (_thisCTLEntry # 1));
		
		_PTMForListToNotLower append (_PTMForList arrayIntersect (_thisCTLEntry # 1));
		
		_clashTP = _PTMForList arrayIntersect ((_thisCTLEntry # 5) + (_thisCTLEntry # 1));
		private _deletedTriangles = [];
		private _tl2d = _terrainLines apply {[[_x#0#0, _x#0#1], [_x#1#0, _x#1#1]]};
		private _tlp2d = [];
		{
			_tlp2d pushBackUnique _x#0;
			_tlp2d pushBackUnique _x#1;
		} foreach _tl2d;
		private _bpFromConfig3d = [];
		{
			_bpFromConfig3d pushBackUnique (_x#0);
			_bpFromConfig3d pushBackUnique (_x#1);
		} foreach _blFromConfig;
		{
			private _thisTrianglePos = _x # 0;
			private _thisTrianglePos2d = _thisTrianglePos apply {_x select [0, 2];};
			// private _deleteThisTriangle = ((count (_clashTP arrayIntersect _thisTrianglePos2d)) > 0) || ((count (_tlp2d arrayIntersect _thisTrianglePos2d)) > 0);
			private _deleteThisTriangle = ((count (_clashTP arrayIntersect _thisTrianglePos2d)) > 0);
			{
				_deleteThisTriangle = _deleteThisTriangle || (_x inPolygon _thisTrianglePos);
			} forEach _bpFromConfig3d;
			
			
			if (!_deleteThisTriangle) then {
				//this is probably expensive processing wise but it only gets run once per triangle
				//ellipse check cause i can't think of anything cheaper that makes sense
				{
					private _side = [_thisTrianglePos2d#0, _thisTrianglePos2d#1];
					private _sideLength = (_side#0) distance2D (_side#1);
					private _lA = (_side#0) distance2D _x;
					private _lB = (_side#1) distance2D _x;
					if ((_lA + _lB - _sideLength) < 0.2) then {
						_deleteThisTriangle = true;
					} else {
						_side = [_thisTrianglePos2d#0, _thisTrianglePos2d#2];
						_sideLength = (_side#0) distance2D (_side#1);
						_lA = (_side#0) distance2D _x;
						_lB = (_side#1) distance2D _x;
						if ((_lA + _lB - _sideLength) < 0.2) then {
							_deleteThisTriangle = true;
						} else {
							_side = [_thisTrianglePos2d#1, _thisTrianglePos2d#2];
							_sideLength = (_side#0) distance2D (_side#1);
							_lA = (_side#0) distance2D _x;
							_lB = (_side#1) distance2D _x;
							if ((_lA + _lB - _sideLength) < 0.2) then {
								_deleteThisTriangle = true;
							};
						};
					};
					if (_deleteThisTriangle) then {break;};
				} forEach _bpFromConfig3d;
			};

			if (_deleteThisTriangle) then {
				_deletedTriangles append [_thisTrianglePos];
				_trianglesToDelete append [_x # 1];
			} else {
				_trianglesPositionsAndObjectsAdd append [_x];
			};
		} foreach (_thisCTLEntry # 2);
		
		_openLines = [];
		_openPoints = [];
		_deletedTrianglesLines = [];
		{
			private _lines = [[_x # 0, _x # 1], [_x # 1, _x # 2], [_x # 2, _x # 0]];
			{_x sort true} foreach _lines;
			_deletedTrianglesLines append _lines;
		} foreach _deletedTriangles;
		
		{
			_thisDTL = _x;
			private _cnt = {_thisDTL isEqualTo _x} count _deletedTrianglesLines;
			if (_cnt == 1) then {
				// if the line in question does not connect to any clash points
				if (!((((_x # 0) select [0,2]) in _clashTP) || (((_x # 1) select [0,2]) in _clashTP))) then {
					_openLines append [_thisDTL];
				};
			};
		} foreach _deletedTrianglesLines;
		
		
		
		// this part removes all terrain lines that lie in the affected area
		_TPForTLRemoval = _allAffectedTP arrayIntersect ((_thisCTLEntry # 1));
		_terrainLinesNew = [];
		{
			if (!((((_x # 0) select [0,2]) in _TPForTLRemoval) || (((_x # 1) select [0,2]) in _TPForTLRemoval))) then {
				_terrainLinesNew append [_x];
			};
		} foreach _terrainLines;
		_terrainLines = _terrainLinesNew;
		
		
		//unsure about this part
		{_x sort true} foreach _terrainLines;
		deb_msg5 = + _terrainLines;

		_tl2d = _terrainLines apply {[[_x#0#0, _x#0#1], [_x#1#0, _x#1#1]]};
		{
			// Current result is saved in variable _x
			if (!([[_x#0#0, _x#0#1], [_x#1#0, _x#1#1]] in _tl2d)) then {
				private _thisLine = _x;
				{
					if ([_thisLine#0#0,_thisLine#0#1] isEqualTo (_x#0 select [0,2])) then {
						_x set [0, _thisLine#0];
					};
					if ([_thisLine#0#0,_thisLine#0#1] isEqualTo (_x#1 select [0,2])) then {
						_x set [1, _thisLine#0];
					};
					if ([_thisLine#1#0,_thisLine#1#1] isEqualTo (_x#0 select [0,2])) then {
						_x set [0, _thisLine#1];
					};
					if ([_thisLine#1#0,_thisLine#1#1] isEqualTo (_x#1 select [0,2])) then {
						_x set [1, _thisLine#1];
					};
				} forEach _terrainlines;
				_terrainLines pushBack _x;
			};
		} forEach _openLines;


		


		// _terrainLines append _openLines;
		// _terrainLines = _terrainLines arrayIntersect _terrainLines;
	} foreach _clashingCoveredTrenches;


	// if ((count _clashingCoveredTrenches) > 0) then {
	// 	{
	// 		private crossing = false;
	// 		private _thisTL = _x;
	// 		{
	// 			if (((_thisTL#0) inPolygon _x) || ((_thisTL#1) inPolygon _x)) then {
	// 				crossing = true;
	// 				break;
	// 			};
	// 		} forEach _tftFromConfig;
	// 	} forEach _terrainLines;
	// };



	//remember to redo below this point EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
		
	//deb_msg4 = _positionsAndHeights;
	
	
	_positionsAndHeights = [];
	
	private _cellsize = getTerrainInfo#2;

	{
		_height = getTerrainHeight _x;
		_newPosAndHeight = + _x;
		_newPosAndHeight set [2, _height - _cellsize];
		_positionsAndHeights append [_newPosAndHeight];
	} foreach (_PTMForList - _PTMForListToNotLower);
	
	//modification was here
	
	deb_msg6 = + _terrainLines;
	deb_msg7 = + _blFromConfig;
	deb_msg8 = + _tftFromConfig;
	deb_msg4 = _trianglesToDelete;
	
	_trenchPoints = [];
	{
		_trenchPoints pushBackUnique (_x # 0);
		_trenchPoints pushBackUnique (_x # 1);
	} foreach _blFromConfig;

	// recalculate terrainlines by finding all triangle lines that connect to two terrain points
	_terrainLines = [];
	_terrainPointsForListFinal = _terrainPointsForList + _terrainPointsAdd;
	//_allLines = [];
	
	
	
	
	//_thisTrenchListEntry = [_trenches + _trenchesAdd, (_PTMForList - _PTMForListToNotLower) + _PTMForListAdd, _trianglesPositionsAndObjects + _trianglesPositionsAndObjectsAdd, _tftFromConfig + _tftFromConfigAdd, _terrainLines, _terrainPointsForListFinal, _blFromConfig + _blFromConfigAdd, _trenchPoints + _trenchPointsAdd];
	
	

	"done"

};
_trenchP
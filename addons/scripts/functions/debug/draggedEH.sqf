_tr = get3DENSelected "object" # 0;
[_tr] call ELD_magicTriangle_scripts_fnc_initCoreTrench;
_tr  addEventHandler ["Dragged3DEN", {
	params ["_trench"];
	
	if(current3DENOperation isEqualTo "")then
	{
		//stuff in here happens when drag is finished
		//since this is atm only for core trenches rank and sides can stay the same
		
		private _cornerPositions = [_trench] call (ELD_magicTriangle_scripts_fnc_getTrenchCornersFromConfig);
		private _terrainPoints = [_trench] call (ELD_magicTriangle_scripts_fnc_makeSingleHole);
		private _tp = [_trench] call (ELD_magicTriangle_scripts_fnc_TPRemoveTrench);
		_trench setVariable ["corners", _cornerPositions];
		_trench setVariable ["terrainPoints", _terrainPoints];
		_tp append ([_trench] call (ELD_magicTriangle_scripts_fnc_TPAddTrench));
		[_tp] call (ELD_magicTriangle_scripts_fnc_TPUpdate);
	};

}];
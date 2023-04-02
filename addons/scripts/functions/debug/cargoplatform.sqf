/*
	bin_fnc_cargoPlatform_01_update

	Update cargo platform position
*/
params["_object"];

// If there is another cargo platform nearby then try to snap to it
// First we have to wait till dragging is completed
if(current3DENOperation isEqualTo "")then
{
	private _nearbyObjects = nearestObjects [_object, ["CargoPlatform_01_base_F"], 6.5];
	_nearbyObjects = _nearbyObjects - [_object];

	if(!(_nearbyObjects isEqualTo []))then
	{
		private _nearestObject	= _nearbyObjects # 0;
		private _pos			= getposASL _object;


		// Search for available snap points
		// Those are recognized as valid points only when side of platform is hidden
		private _snapPoint			= [];
		private _snapPointsParent	= [];
		for "_i" from 1 to 4 do
		{
			if(_object animationSourcePhase format["Panel_%1_Hide_Source",_i] isEqualTo 1)then
			{
				_snapPointsParent pushBack (_object modelToWorldVisual (_object selectionPosition format["panel%1_snap",_i]));
			};
		};
		if(!(_snapPointsParent isEqualTo []))then
		{
			for "_i" from 1 to 4 do
			{
				if(_nearestObject animationSourcePhase format["Panel_%1_Hide_Source",_i] isEqualTo 1)then
				{
					_snapPoint = _nearestObject modelToWorldVisual (_nearestObject selectionPosition format["panel%1_snap",_i]);
					{
						// Continue if snap points are found
						if(_snapPoint distance _x <= 1)exitWith
						{
							// Reconvert to model space due to dir change
							_posModel = _object worldToModel _x;

							// Adjust direction
							_dirTo		= getDir _nearestObject - 360;
							_dirObject	= getDir _object;
							_dir		= _dirTo;

							for "_i" from 0 to 7 do
							{
								_dir = _dirTo + _i * 90;
								if(abs(_dir - _dirObject) < 45)then
								{
									_i = 10;
								};
							};
							_object set3DENAttribute ["rotation",[0,0, _dir]];

							// Recalc position in case direction was changed
							_x = _object modelToWorldVisual _posModel;

							// Transform position
							_pos = _pos vectorDiff (_x vectorDiff _snapPoint);
							_pos = [_pos # 0, _pos # 1, (getposASL (_nearbyObjects # 0)) # 2];
							//systemChat format["pos found %1",_pos];

							// Snap to position
							_object set3DENAttribute ["position",ASLToATL _pos];

							// Exit "for" loop
							_i = 10;
						};
					}forEach _snapPointsParent;
				};
			};
		};

		//systemChat format["nearby objects %1 %2 snap point %3",_nearestObject,_object distance _nearestObject,_snapPointsParent];
	};
};

// Adjust legs length
[_object] call bin_fnc_cargoPlatform_01_adjust;

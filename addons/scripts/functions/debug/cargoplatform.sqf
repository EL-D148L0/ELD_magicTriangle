/*
	bin_fnc_cargoPlatform_01_update

	Update cargo platform position
*/
params["_object"];

//dragged3den EH
// If there is another cargo platform nearby then try to snap to it
// First we have to wait till dragging is completed
if(current3DENOperation isEqualTo "")then
{
	//stuff in here happens when drag is finished
};

// Adjust legs length
// this happens even while dragging
[_object] call bin_fnc_cargoPlatform_01_adjust;

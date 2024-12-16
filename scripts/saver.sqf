loop_saving = [] spawn {
	while { true } do {
		if (save_var_hohol == 1) then {
			[false, 0] call grad_persistence_fnc_saveMission;
			systemChat "Сохранено";
		} else {};
		if (clean_var_hohol == 1) then {
			{
				if (_x iskindof "man") then {
					// don't delete crew in vehicles, as that is part of vehicle removal 
					if (vehicle _x == _x) then {
						deleteVehicle _x;
						sleep 0.01;
					};
				};
				if (!(_x iskindof "man")) then {
					deleteVehicleCrew _x;// Works with game version v2.06. Deletes all crew members
					deleteVehicle _x;
					sleep 0.01;
				};
			} forEach allDead;
		};
		sleep 600;
	};
};
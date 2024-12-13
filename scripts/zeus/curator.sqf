_playerUID = getPlayerUID player;
zeusmodule = [ 
    "76561198316727609", /// doctor
    "76561199042520076", /// ermak
    "76561198815605790", /// varden
    "76561198047690862", /// hengels
    "76561198284004882", /// miller
	"76561198984888750", /// Vender
	"76561198432363921", /// Shiza
	"76561199503659947", /// Gromov
	"76561198135788033", /// Zakinal
	"76561199022022230", /// Subarist
	"76561198376736313", /// Борщ
	"76561199524484032", /// Волинський
	"76561199275087338", /// Кислый
	"76561198097650908", /// Зодиак
	"76561199165216019", /// Бабка
	"76561198201205878", /// Fraer
	"76561199034188469", /// MIRK
	"76561199147083582", /// Каскад
	"76561198361041147", /// Лазурь
	"76561199246126737", /// Хвойный
	"76561199287760678" /// Шилов
];
if (!(_playerUID in zeusmodule)) exitwith {};
if ((side player != civilian) && (_playerUID != "76561198432363921") && (_playerUID != "76561198284004882") && (_playerUID !="76561198135788033") && (_playerUID != "76561198047690862") && (_playerUID != "76561199287760678")) exitwith {};

_index = zeusmodule find _playerUID;
_dedman = format["dedman%1", _index];
[_dedman]  call { 
	
	missionNamespace setVariable [_this select 0, player, true];
	[0, {
		params ["_myName"]; private _curVarName = _myName+"Cur";
		
		if (isNil _curVarName) then {
			[-1, compile format["if (player == %1) then {%1 sideChat 'creating Curator';}", _myName]] call CBA_fnc_globalExecute;
			if (isNil "DedmenCur_group") then {DedmenCur_group = creategroup sideLogic;};
			private _myCurObject = DedmenCur_group createunit["ModuleCurator_F", [0, 90, 90], [], 0.5, "NONE"];	//Logic Server
			_myCurObject setVariable ["showNotification",false];

			missionNamespace setVariable [_curVarName, _myCurObject, true];
			publicVariable "DedmenCur_group";
			unassignCurator _myCurObject;
			_cfg = (configFile >> "CfgPatches");
			_newAddons = [];
			for "_i" from 0 to((count _cfg) - 1) do {
				_name = configName(_cfg select _i);
				_newAddons pushBack _name;
			};
			if (count _newAddons > 0) then {_myCurObject addCuratorAddons _newAddons};
			_myCurObject setcuratorcoef["place", 0];
			_myCurObject setcuratorcoef["delete", 0];
			private _enableSyncVar = _myName+"_enableSync";
			private _val = random 500;
			missionNamespace setVariable [_enableSyncVar, random 500];
			[_enableSyncVar,_val] spawn {
				while  {(missionNamespace getVariable [_this select 0, 0]) == (_this select 1)} do {
				// {
				_myCurObject addCuratorEditableObjects[(allMissionObjects "All"), true];
				// } forEach allCurators;
				sleep 2;
			};};

		};
		private _myCurObject = missionNamespace getVariable [_curVarName, objNull];
		private _myPlayer = missionNamespace getVariable [_myName, objNull];
		_myCurObject addEventHandler ["CuratorObjectPlaced", {
			params ["_curator", "_entity"];
			class = missionNamespace getVariable ([(getDescription _entity) select 0, 0]);
			missionNamespace setVariable [(getDescription _entity) select 0, class + 1];
			publicVariable ((getDescription _entity) select 0);
		}];
		_myCurObject addEventHandler ["CuratorObjectDeleted", {
			params ["_curator", "_entity"];
			class = missionNamespace getVariable ([(getDescription _entity) select 0, 0]);
			if (class > 0) then {
				missionNamespace setVariable [(getDescription _entity) select 0, class - 1];
				publicVariable ((getDescription _entity) select 0);
			};
		}];
		/*
		//if (getAssignedCuratorUnit (_myCurObject) != kapayji) then {
		*/
		unassignCurator _myCurObject;
		sleep 0.4;
		_myPlayer assignCurator _myCurObject;
		///* };*/
		[-1, compile format["if (player == %1) then {%1 sideChat 'you are Curator';}", _myName]] call CBA_fnc_globalExecute;
	}, _this] call CBA_fnc_globalExecute;
};


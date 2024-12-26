_playerUID = getPlayerUID player;
zeusmodule = [ 
    "76561199002226480", /// Фламберг
    "76561198376736313", /// Борв
    "76561198284004882", /// Миллер
    "76561199042520076", /// Ермак
    "76561199147083582", /// Каскад
    "76561198047690862", /// Стена
    "76561198361041147", /// Кириенко
    "76561199034188469", /// Мирк
    "76561198815605790", /// Струна
    "76561198908535754", /// Князев
	"76561198995428804", /// Gaga
	"76561198135788033", /// Арестун
	"76561198338806858", /// Цикада
	"76561198216667587", /// Каппа
	"76561198297574929", /// Giga
	"76561198201205878", /// Фраер
	"76561198984888750", /// Варден
	"76561198055139490" /// ГБР теыты [8 ОПСпН] Бiйрактар

	
];
if (!(_playerUID in zeusmodule)) exitwith {};
if ((side player != civilian) && (_playerUID != "76561198432363921") && (_playerUID != "76561198284004882") && (_playerUID !="76561198135788033") && (_playerUID != "76561198047690862") && (_playerUID != "76561199287760678") && (_playerUID != "76561198216667587") && (_playerUID != "76561198297574929") && (_playerUID != "76561198201205878")) exitwith {};

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


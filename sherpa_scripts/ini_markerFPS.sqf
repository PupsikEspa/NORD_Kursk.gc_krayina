sleep 2;

private _sourcestr = "Сервер";
private _position = 0;

sleep 2;

if (!isServer) then {
    if (isNil "HC1") exitWith {
        HC1 = true;
        publicVariable "HC1";
        _sourcestr = "HC1";
        _position = 1;
    };
    if (isNil "HC2") exitWith {
        HC2 = true;
        publicVariable "HC2";
        _sourcestr = "HC2";
        _position = 2;
    };
    if (isNil "HC3") exitWith {
        HC3 = true;
        publicVariable "HC3";
        _sourcestr = "HC3";
        _position = 3;
    };
    if (isNil "HC4") exitWith {
        HC4 = true;
        publicVariable "HC4";
        _sourcestr = "HC4";
        _position = 4;
    };
    if (isNil "HC5") exitWith {
        HC5 = true;
        publicVariable "HC5";
        _sourcestr = "HC5";
        _position = 5;
    };
};

private _myfpsmarker = createMarker [format ["fpsmarker%1", _sourcestr], [0, -500 - (500 * _position)]];
_myfpsmarker setMarkerType "mil_start";
_myfpsmarker setMarkerSize [0.7, 0.7];

while {true} do {

    private _myfps = diag_fps;
    private _localgroups = {local _x} count allGroups;
    private _localunits = {local _x} count allUnits;

    _myfpsmarker setMarkerColor "ColorGREEN";
    if (_myfps < 30) then {_myfpsmarker setMarkerColor "ColorYELLOW";};
    if (_myfps < 20) then {_myfpsmarker setMarkerColor "ColorORANGE";};
    if (_myfps < 10) then {_myfpsmarker setMarkerColor "ColorRED";};

    _myfpsmarker setMarkerText format ["%1: %2 фпс / fps, %3 локальных групп / local groups, %4  локальных юнитов / local units", _sourcestr, (round (_myfps * 100.0)) / 100.0, _localgroups, _localunits];

    sleep 5;
};
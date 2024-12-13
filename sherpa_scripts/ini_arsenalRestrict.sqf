{
	if (_x != ((group player) getVariable "regArs")) then {[_x, false] call ace_arsenal_fnc_removeBox; _x lockInventory true;};
} forEach [vks_ars,obrmp810_ars,pdp51_ars,pyatnashka_ars,obrmp155_ars,odshbr95_ars,omsbr64_ars,gnl_ars,ombr61_ars,odsbr82_ars,obrmp36_ars,odshbr80_ars,psu_ars,legion_pidorasov_ars,dshp56_ars,obrmp61_ars,obrtro127_ars,ombr92_ars,omsbr200_ars];
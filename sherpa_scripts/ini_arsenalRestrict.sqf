{
	if (_x != ((group player) getVariable "regArs")) then {[_x, false] call ace_arsenal_fnc_removeBox; _x lockInventory true;};
} forEach [vks_ars,obrmp810_ars,pdp51_ars,pyatnashka_ars,obrmp155_ars,omsbr64_ars,dshp56_ars,obrmp61_ars,omsbr200_ars,akhmat_ars,finist_ars,ps_fsb_ars,gnl_ars,odshbr95_ars,ombr61_ars,odsbr82_ars,obrmp36_ars,odshbr80_ars,psu_ars,legion_pidorasov_ars,ombr47_ars,tso_a_ars,oppcp8_ars,msco73_ars];
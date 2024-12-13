{
	if (_x != ((group player) getVariable "regArs")) then {[_x, false] call ace_arsenal_fnc_removeBox; _x lockInventory true;};
} forEach [vks_ars,sobr_ars,odshbr31_ars,obrspn2_ars,churki_ars,ufl_ars,odshbr11_ars,otbr3_ars,kraken_ars,omega_ars,oshb_425_ars,ombr93_ars,psu_ars,oambr81_ars,omon_ars,obrmp61_ars,obrtro127_ars,ombr92_ars,msbr200_ars];
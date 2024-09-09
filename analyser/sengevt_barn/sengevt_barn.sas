%let oppdatering_filbane=/sas_smb/skde_analyse/Brukere/Mattias/oppdaterte_analyser;
%let filbane=/sas_smb/skde_analyse/Data/SAS/felleskoder/main;

%include "&oppdatering_filbane/makroer/npr.sas";
%include "&oppdatering_filbane/makroer/oppdater.sas";
%include "&oppdatering_filbane/makroer/assemble.sas";
%include "&oppdatering_filbane/makroer/publiser_rate.sas";
%include "&filbane/rateprogram/standard_rate.sas";
%include "&filbane/formater/bo.sas";

%include "/sas_smb/skde_analyse/Brukere/Mattias/sas_codes/makroer/kodematch.sas";

data sengevt_barn;
  %NPR(avd aspes,
     periode=2015-2023,
	 aktivitetskategori3=1 2,
	 in_diag=N39[34] F980 R32,
	 ut_diag=,
	 in_pros=,
     ut_pros=,
	 where=alder < 17
  )
  sengevt = 1;
run;

%oppdater(sengevt_barn/sengevt)

%publiser_rate(
   sengevt_barn/sengevt,
   description="Sengevæting og urinlekkasje pr 1000 barn, poli/dag-konsultasjoner.",
   description_en="Something or other pr. 10 00 inhabitants.",
   tags=barn sengevæting
)

%let oppdatering_filbane=/sas_smb/skde_analyse/Brukere/Mattias/oppdaterte_analyser;
%let filbane=/sas_smb/skde_analyse/Data/SAS/felleskoder/main;

%include "&oppdatering_filbane/makroer/npr.sas";
%include "&oppdatering_filbane/makroer/oppdater.sas";
%include "&oppdatering_filbane/makroer/assemble.sas";
%include "&oppdatering_filbane/makroer/publiser_rate.sas";
%include "&filbane/rateprogram/standard_rate.sas";
%include "&filbane/formater/bo.sas";

data dupuy_1;
  %NPR(avd aspes,
     periode=2023-2023,
	 in_diag=M720,
	 ut_diag=,
	 in_pros=NDM[01]9,
     ut_pros=
  )
  handkir = 1;
run;
data dupuy_2;
  %NPR(aspes, periode=2023-2023, normaltariff=140c)
  handkir = 1;
run;

proc sql;
create table handkir_dupuytrens as
   select * from dupuy_1 union corr select * from dupuy_2;
quit;

data _null_;
  %NPR(avd aspes,
     periode=2015-2023,
	 in_diag=,
	 ut_diag=,
	 in_pros=,
     ut_pros=
  )
run;

%oppdater(handkir_dupuytrens/handkir, force_update=true)

%publiser_rate(
   handkir_dupuytrens/handkir,
   description="Et eller annet pr. 10 000 innbyggere.",
   description_en="Something or other pr. 10 000 inhabitants.",
   tags=revurdering håndkirurgi
)

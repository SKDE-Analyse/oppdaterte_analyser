%let oppdatering_filbane=/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser;
%let filbane=/sas_smb/skde_analyse/Data/SAS/felleskoder/main;

%include "&oppdatering_filbane/makroer/setup.sas";
%include "&filbane/makroer/beh_eget_annet_priv.sas";

%include "&filbane/stiler/anno_logo_kilde_npr_ssb.sas";
%let bildesti =/sas_smb/skde_analyse/helseatlas/oppdaterte_analyser/Figurer/injeksjon/injeksjon_kont;



data injeksjon_kont;
  %NPR(avd,
    periode=2015-2023,
	 in_diag=H353 H360 E103 E113 H348 H349, /*AMD, blodpropp i netthinne, diabetisk retinopati*/
	 in_pros=CKD05,
	 where=alder in (50:105)
  );
  injeksjon = 1;	/*alle*/

  array diagnose {*} Hdiag: Bdiag:;
	do i=1 to dim(diagnose);
		if diagnose{i} in ('H353', 'H360', 'E103', 'E113', 'H348','H349')  then Injeksjon_d=1;
		if diagnose{i} eq 'H353'  then Injeksjon_AMD=1;
		if diagnose{i} in ('H348', 'H349')  then Injeksjon_RVO=1;
		if diagnose{i} in ('H360', 'E103', 'E113')  then Injeksjon_diab=1;
	end;

	array legem {*} NC: ATC:;
		do j=1 to dim(diagnose);
			if legem{j} in ('1XC07','L01XC07')  then bevac=1;
			if legem{j} in ('1LA05','S01LA05')  then afliber=1;
			if legem{j} in ('1LA04', 'S01LA04', '1BA01', 'S01BA01', '1XX02')  then andre_legem=1;
		end;

	/*Deler etter diagnose vha hdiag*/
	if hdiag eq 'H353'  then amd=1;
	if hdiag in ('H348', 'H349')  then rvo=1;
	if hdiag in ('H360', 'E103', 'E113')  then diab=1;
	if hdiag in ('H353', 'H360', 'E103', 'E113', 'H348','H349') then hdiag_sjekk=1;
	/*hvis ikke hdiag er en av disse blir det rangering 1. amd 2. diabetes 3. rvo*/
	if hdiag_sjekk ne 1 then do;
		if injeksjon_AMD eq 1 then amd=1;
		else if injeksjon_AMD ne 1 and injeksjon_diab eq 1 then diab=1;
		else if injeksjon_AMD ne 1 and injeksjon_diab ne 1 then rvo=1;
	end;

	if afliber eq 1 then afl=1; 
	else andre=1;

run;

%oppdater(injeksjon_kont,
   total=injeksjon,
   variables=amd diab rvo afl andre,
   force_update=true
);

%publiser_rate(injeksjon_kont,
   total=injeksjon,
   custom_views=
	%define_view(
        name=diagnose, 
        variables=amd diab rvo,
        title=%str(no := Enkeltår, diagnose
                || en := Single year, diagnosis),
        label_1=no := AMD || en := nAMD,
        label_2=no := Diabetes || en := Diabetes,
        label_3=no := Karokklusjon || en := Vein Occlusion)
	%define_view(
        name=legemiddel, 
        variables=afl andre,
        title=%str(no := Enkeltår, legemiddel
                || en := Single year, drug),
        label_1=no := Aflibercept || en := Aflibercept,
        label_2=no := Annet || en := Other),
   title=
      no := Injeksjonsbehandling i Øyet
   || en := Eye injection treatment,
   summary=
      no := hallo
   || en := hallo,
   discussion=%str(
      no := Injeksjonsbehandling har endret seg og greier blabla vi tolker ting her.
   || en := Interpretation of results, there are changes and what do they mean.),
   tags=eldre oye, 
   min_age=50, max_age=105
);

data injeksjon;
set injeksjon_kont;
run;

%let tema=injeksjon;
%let bildesti =/sas_smb/skde_analyse/helseatlas/oppdaterte_analyser/Figurer/injeksjon/injeksjon_kont;

/*Figurer og tabeller*/
%include "/sas_smb/skde_analyse/helseatlas/oppdaterte_analyser/figurmakroer/panel_ny.sas";
%panelfigur_ny(tema=injeksjon, dim1=amd, dim2=diab, dim3=rvo, dimensjon=diagnose);
%include "/sas_smb/skde_analyse/helseatlas/rutine_oppdatering/figurmakroer/panel_ny_todelt.sas";
%panelfigur_ny_todelt(tema=injeksjon, dim1=afl, dim2=andre, dimensjon=legemiddel);



/*SLETTE ALLE DATASETT I WORK */
/*proc datasets nolist library=WORK kill;*/
/*   run; quit;*/
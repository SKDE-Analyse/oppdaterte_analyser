/*!
###Dokumentasjon
Opprettet oktober 2024 av Hanne Sigrun Byhring
Sist endret 22/10-24 av Frank Olsen
Endringer 22/10-2024, ny struktur
*/


/*************************************
 GJØR ENDRINGER I DENNE LILLE BOLKEN
*************************************/
%let tema=injeksj_kont;
%let startaar=2015;
%let sluttaar=2023;
/****************************************
 OG TILPASS MAKROER ETTER PUBLISER_RATE
*****************************************/


/*Endre denne stien når alt er klart*/
%let oppdatering_filbane=/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser_kloner/oppd_ana_FO;
/*Analysetekst*/
%include "&oppdatering_filbane/analyser/&tema./text/&sluttaar..sas";
/*Makroer for å lage data til analyse*/
%include "&oppdatering_filbane/makroer/setup.sas";

/*Generelle makroer*/
%let filbane=/sas_smb/skde_analyse/Data/SAS/felleskoder/main;
%include "&filbane/makroer/beh_eget_annet_priv.sas";
%include "&filbane/stiler/anno_logo_kilde_npr_ssb.sas";
%include "&filbane/rateprogram/graf.sas";

/*Bildesti*/
%let bildesti =/sas_smb/skde_analyse/helseatlas/oppdaterte_analyser/Figurer/&sluttaar._figurer/&tema;

/*Figurmakroer*/
%include "&oppdatering_filbane/figurmakroer/total_figurer.sas";
%include "&oppdatering_filbane/figurmakroer/panelfigur_todelt.sas";
%include "&oppdatering_filbane/figurmakroer/panelfigur_tredelt.sas";
%include "&oppdatering_filbane/figurmakroer/rate_alder_kjonn.sas";
%include "&oppdatering_filbane/figurmakroer/dim_rate_alder_kjonn.sas";

data injeksj_kont_utv;
  %NPR(avd,
    periode=2015-2023,
	 in_diag=H353 H360 E103 E113 H348 H349, /*AMD, blodpropp i netthinne, diabetisk retinopati*/
	 in_pros=CKD05,
	 where=alder in (50:105)
  );
  &tema. = 1;	/*alle*/

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

/*Kjøre makro for å lage tredeling kn. til behandlingssted*/
%beh_eget_annet_priv(inndata=injeksj_kont_utv, utdata=injeksj_kont, as_data=0);


%oppdater(&tema.,
   total=&tema.,
   variables=amd diab rvo afl andre eget annet privat,
   force_update=true
);

%publiser_rate(&tema.,
   total=&tema.,
   custom_views=
	%define_view(
        name=diagnose, 
        variables=amd diab rvo,
        title=%str(no := Enkeltår, diagnose
                || en := Single year, diagnosis),
        label_1=no := AMD || en := AMD,
        label_2=no := Diabetes || en := Diabetes,
        label_3=no := Karokklusjon || en := Vein Occlusion)
	%define_view(
        name=legemiddel, 
        variables=afl andre,
        title=%str(no := Enkeltår, legemiddel
                || en := Single year, drug),
        label_1=no := Aflibercept || en := Aflibercept,
        label_2=no := Annet || en := Other)
	%define_view(
        name=behandler, 
        variables=eget annet privat,
        title=%str(no := Enkeltår, behandler
                || en := Single year, public/private),
        label_1=no := Eget HF || en := Local public,
        label_2=no := Annet HF || en := Other public,
        label_3=no := Privat || en := Private)
,
&settinn_txt.
   tags=eldre oye, 
   min_age=50, max_age=105
);

/*FIGURER TIL STØTTE I SKRIVINGEN UNDER HER:*/
/*Figurer og tabeller*/
%total_figurer;

%panelfigur_todelt(dim1=afl,dim2=andre,dimensjon=legemiddel);

%panelfigur_tredelt(dim1=amd,dim2=diab,dim3=rvo,dimensjon=diagnose);

%rate_alder_kjonn(aarmin=&startaar,aarmax=&sluttaar,aldermin=50,aldermax=105,kjonn=);

%dim_rate_alder_kjonn(dim=afl,aarmin=&startaar,aarmax=&sluttaar,aldermin=50,aldermax=105,kjonn=);

%dim_rate_alder_kjonn(dim=adm,aarmin=&startaar,aarmax=&sluttaar,aldermin=50,aldermax=105,kjonn=);

/**/

/*SLETTE ALLE DATASETT I WORK */
proc datasets nolist library=WORK kill;
   run; quit;
/*!
###Dokumentasjon
Opprettet 25.november 2024 av Hanne Sigrun Byhring
Sist kj�rt dato av hvem
Endringer hva, hvem og n�r
*/

/*************************************
 GJ�R ENDRINGER I DENNE LILLE BOLKEN
*************************************/
%let tema=fremfall;
%let startaar=2015;
%let sluttaar=2023;
/****************************************
 OG TILPASS MAKROER ETTER PUBLISER_RATE
*****************************************/

%let oppdatering_filbane=/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser_kloner/oppd_ana_HSB;
/*Makroer for � lage data til analyse*/
%include "&oppdatering_filbane/makroer/setup.sas";
/*Makroer og stier for figurer*/
%include "&oppdatering_filbane/figurmakroer/oppsett.sas";

/*** Utvalg og analyse ***/

data fremfall_utv;
  %NPR(avd, /*Gj�res kun p� sykehus*/
    periode=2015-2023,
	 in_diag=N81, 
	 in_pros=LEF00 LEF03 LEF10 LEF13 LEF16 LEF20 LEF23 LEF34 LEF40 LEF41 LEF50 LEF51 LEF53 LEF96 LEF97, 
         /*HSB_19nov2024: Utvalgskoder sjekket mot metodebok.no (https://metodebok.no/index.php?action=topic&item=tE5VKGaZ) */
	 where= alder ge 16 and ermann=0
  );
 fremfall = 1;	/*alle*/

run;

/*Kj�re makro for � lage tredeling kn. til behandlingssted*/
%beh_eget_annet_priv(inndata=fremfall_utv, utdata=fremfall, as_data=0);


%oppdater(fremfall,
   total=fremfall,
   variables=eget annet privat,
   force_update=true
);

%publiser_rate(fremfall,
   total=fremfall,
   kjonn=kvinner,
   custom_views=
	%define_view(
        name=behandler, 
        variables=eget annet privat,
        title=%str(no := Enkelt�r, behandlingssted
                || en := Single year, public/private),
        label_1=no := Eget HF || en := Local public,
        label_2=no := Annet HF || en := Other public,
        label_3=no := Privat || en := Private)
        ,
        &settinn_txt.
        tags=kvinner gynekologi prolaps
);

/*FIGURER TIL ST�TTE I SKRIVINGEN UNDER HER:*/
/*Figurer og tabeller*/
%total_figurer;

%panelfigur_tredelt(dim1=eget,dim2=annet,dim3=privat,dimensjon=beh);

%rate_alder_kjonn(aarmin=&startaar,aarmax=&sluttaar,aldermin=0,aldermax=105,kjonn=0);


/*SLETTE ALLE DATASETT I WORK */
proc datasets nolist library=WORK kill;
   run; quit;
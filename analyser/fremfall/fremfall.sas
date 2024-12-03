/*!
###Dokumentasjon
Opprettet 25.november 2024 av Hanne Sigrun Byhring
Sist kjørt dato av hvem
Endringer hva, hvem og når
*/

/*************************************
 GJØR ENDRINGER I DENNE LILLE BOLKEN
*************************************/
%let tema=fremfall;
%let startaar=2015;
%let sluttaar=2023;
/****************************************
 OG TILPASS MAKROER ETTER PUBLISER_RATE
*****************************************/

%let oppdatering_filbane=/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser;
/*Makroer for å lage data til analyse*/
%include "&oppdatering_filbane/makroer/setup.sas";
/*Makroer og stier for figurer*/
%include "&oppdatering_filbane/figurmakroer/oppsett.sas";

/*** Utvalg og analyse ***/

data fremfall;
  %NPR(avd, /*Gjøres kun på sykehus*/
    periode=2015-2023,
	 in_diag=N81, 
	 in_pros=LEF00 LEF03 LEF10 LEF13 LEF16 LEF20 LEF23 LEF34 LEF40 LEF41 LEF50 LEF51 LEF53 LEF96 LEF97, 
         /*HSB_19nov2024: Utvalgskoder sjekket mot metodebok.no (https://metodebok.no/index.php?action=topic&item=tE5VKGaZ) */
	 where= alder ge 16 and ermann=0
  );
 fremfall = 1;	/*alle*/

 if aktivitetskategori3 eq 1 then dogn=1;
 else if aktivitetskategori3 ne 1 then dagkir=1;

run;


%oppdater(fremfall,
   total=fremfall,
   variables=eget_hf annet_hf privat dogn dagkir,
   force_update=true
);

%publiser_rate(fremfall,
   total=fremfall,
   kjonn=kvinner,
   custom_views=
	%define_view(
        name=behandler, 
        variables=eget_hf annet_hf privat,
        title=%str(no := Enkeltår, behandlingssted
                || en := Single year, public/private),
        label_1=no := Eget HF || en := Local public,
        label_2=no := Annet HF || en := Other public,
        label_3=no := Privat || en := Private)
	%define_view(
        name=dogn_dag, 
        variables=dogn dagkir,
        title=%str(no := Enkeltår, Døgn/Dagkirurgi
                || en := Single year, Inpatient/Outpatient),
        label_1=no := Døgnopphold || en := Inpatient,
        label_2=no := Dagkirurgi || en := Outpatient)
        ,
        &settinn_txt.
        tags=kvinner gynekologi prolaps
);

/*FIGURER TIL STØTTE I SKRIVINGEN UNDER HER:*/
/*Figurer og tabeller*/
%total_figurer;

%panelfigur_tredelt(dim1=eget_hf,dim2=annet_hf,dim3=privat,dimensjon=beh);
%panelfigur_todelt(dim1=dogn,dim2=dagkir,dimensjon=dagkir);

%rate_alder_kjonn(aarmin=&startaar,aarmax=&sluttaar,aldermin=0,aldermax=105,kjonn=0);


/*SLETTE ALLE DATASETT I WORK */
proc datasets nolist library=WORK kill;
   run; quit;
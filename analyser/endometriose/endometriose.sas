/*!
###Dokumentasjon
Opprettet 20.november 2024 av Frank Olsen
Sist kjørt dato av hvem
Endringer hva, hvem og når
*/

/*************************************
 GJØR ENDRINGER I DENNE LILLE BOLKEN
*************************************/
%let tema=endometriose;
%let startaar=2015;
%let sluttaar=2023;
/****************************************
 OG TILPASS MAKROER ETTER PUBLISER_RATE
*****************************************/

%let oppdatering_filbane=/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser_kloner/oppd_ana_FO;
/*Makroer for å lage data til analyse*/
%include "&oppdatering_filbane/makroer/setup.sas";
/*Makroer og stier for figurer*/
%include "&oppdatering_filbane/figurmakroer/oppsett.sas";

/*** Utvalg og analyse ***/

data endo_1;
  %NPR(avd,
  	 periode=&startaar-&sluttaar,
	 in_diag=N80 N941 N944 N945 N946,
	 in_pros=LCD00 LCD30 LCD96 LCD10 LCD40 LCD01 LCD04 LCD11 LCD31 LCD97 LCC10 LCC11 LCC20 
		JAL21 JAL24 JAP00 JAP01 JAL20 JAL21 JAA10 JAA11 LAC00 LAC01 LAC10 LAC11 LAC20 LAC21 LCF00
		LCF01 LAD00 LAD01 LAE10 LAE11 LAE20 LAE21 LAF00 LAF01 LAF10 LAF11 LAF20 LAF30 LBD00
		LBD01 LBE00 LBE01 LCC00 LCC01 LCC05 LCC96 LCC97 LCF97 LCF96,
	where = alder in (16:55) and ermann=0 
  );
  endometriose = 1;
run;

/*Hystrektomi*/
data endo_2;
  %NPR(avd,
  	 periode=&startaar-&sluttaar,
	 in_diag=N80 N941 N944 N945 N946,
	 in_pros=LCD00 LCD30 LCD96 LCD10 LCD40 LCD01 LCD04 LCD11 LCD31 LCD97 LCC10 LCC11 LCC20,
	where = alder in (16:55) and ermann=0  
  );
  endo_hyst = 1;
run;

/*Andre pros*/
data endo_3;
  %NPR(avd,
  	 periode=&startaar-&sluttaar,
	 in_diag=N80 N941 N944 N945 N946,
	 in_pros=JAL21 JAL24 JAP00 JAP01 JAL20 JAL21 JAA10 JAA11 LAC00 LAC01 LAC10 LAC11 LAC20 LAC21 
		LCF00 LCF01 LAD00 LAD01 LAE10 LAE11 LAE20 LAE21 LAF00 LAF01 LAF10 LAF11 LAF20 LAF30 
		LBD00 LBD01 LBE00 LBE01 LCC00 LCC01 LCC05 LCC96 LCC97 LCF97 LCF96,
	where = alder in (16:55) and ermann=0  
  );
  endo_andre = 1;
run;

/*Tverrfaglig kirurgi*/
data endo_4;
  %NPR(avd,
  	 periode=&startaar-&sluttaar,
	 in_diag=N80 N941 N944 N945 N946,
	 in_pros=JGB01 JGB97 JGA97 JGW97 KBH51 KBH21 KCH01 KCD97 JBA21 JBA11,
	where = alder in (16:55) and ermann=0 
  );
  tverr = 1;
run;

/*slå sammen*/

proc sort data=endo_1; by pid inndato utdato inntid uttid; run;
proc sort data=endo_2; by pid inndato utdato inntid uttid; run;
proc sort data=endo_3; by pid inndato utdato inntid uttid; run;
proc sort data=endo_4; by pid inndato utdato inntid uttid; run;


data end_o1;
    merge endo_1 (in=a)
          endo_2 (in=b)
          endo_3 (in=c)
		  endo_4 (in=d);
    by pid inndato utdato inntid uttid;
    if a;
run;

data endo;
set end_o1;
if endo_hyst=1 then endo_andre=.;
if endo_hyst=. then endo_hyst=0;
if endo_andre=. then endo_andre=0;
if tverr=. then tverr=0;
ikke_tverr=1;
if tverr=1 then ikke_tverr=0;
run;

/*Kjøre makro for å lage tredeling kn. til behandlingssted*/
%beh_eget_annet_priv(inndata=endo, utdata=&tema._3delt, as_data=0);

data &tema.;
set &tema._3delt;
run;

%oppdater(&tema.,
   total=&tema.,
	variables=endo_hyst endo_andre eget annet privat ikke_tverr tverr,
   force_update=true
);

%publiser_rate(&tema.,
   total=&tema.,
   custom_views=
    %define_view(
        name=behandler, 
        variables=eget annet privat,
        title=%str(no := Enkeltår, behandlingssted
                || en := Single year, public/private),
        label_1=no := Eget HF || en := Local public,
        label_2=no := Annet HF || en := Other public,
        label_3=no := Privat || en := Private)
	%define_view(
        name=metode, 
        variables=endo_hyst endo_andre,
        title=%str(no := Enkeltår, type inngrep
                || en := Single year, procedure type),
        label_1=no := Hysterektomi || en := Hysterectomy,
        label_2=no := Andre inngrep || en := Other)
	%define_view(
        name=type, 
        variables=ikke_tverr tverr,
        title=%str(no := Enkeltår, type inngrep
                || en := Single year, procedure type),
        label_1=no := Ikke tverr || en := Hysterectomy,
        label_2=no := tverr || en := Other)
,
&settinn_txt.
tags=kvinner endometriose, 
   min_age=16, max_age=55
);

/*Figurer og tabeller*/
%total_figurer;

%panelfigur_todelt(dim1=endo_hyst,dim2=endo_andre,dimensjon=metode);

%panelfigur_todelt(dim1=ikke_tverr,dim2=tverr,dimensjon=type);

%panelfigur_tredelt(dim1=eget,dim2=annet,dim3=privat,dimensjon=beh);

%rate_alder_kjonn(aarmin=&startaar,aarmax=&sluttaar,aldermin=16,aldermax=55,kjonn=0);

%dim_rate_alder_kjonn(dim=endo_hyst,aarmin=&startaar,aarmax=&sluttaar,aldermin=16,aldermax=55,kjonn=0);

/*SLETTE ALLE DATASETT I WORK */
proc datasets nolist library=WORK kill;
   run; quit;
/*!
###Dokumentasjon
Opprettet desember 2024 av Frank Olsen
Sist endret 09/12-24 av Frank Olsen
Oppdateres med T2-tall årlig - for å få med forløp på konisering
*/


/*************************************
 GJØR ENDRINGER I DENNE LILLE BOLKEN
*************************************/
%let tema=livmorhals;
%let startaar=2017;
%let sluttaar=2023;
%let forlop='30Jun2024'd;
%let avd_t2=avd_2024_10;
%let aspes_t2=aspes_2024_t2;
/****************************************
 OG TILPASS MAKROER ETTER PUBLISER_RATE
*****************************************/

%let oppdatering_filbane=/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser_kloner/oppd_ana_fo;
/*Makroer for å lage data til analyse*/
%include "&oppdatering_filbane/makroer/setup.sas";
/*Makroer og stier for figurer*/
%include "&oppdatering_filbane/figurmakroer/oppsett.sas";

/*** Utvalg og analyse ***/

data &tema._1;
  %NPR(avd,
  	 periode=&startaar.-&sluttaar.,
	 in_pros=LDA10 LDA20 LDA96 LDC00 LDC03,
	 where = alder in (18:105) and ermann=0	 
  );
  &tema. = 1;
run;

/*Ta med første 6 mnd i året etter sluttår*/
data &tema._1a;
set hnana.&avd_t2;
where inndato le &forlop. and alder in (18:105) and ermann=0;
array prosedyre {*} NC:;
    	do j=1 to dim(prosedyre); 
		if substr(prosedyre{j},1,5) in ('LDA10','LDA20','LDA96','LDC00','LDC03') then &tema.=1;					
	end;
drop j permisjonsdogn;
if &tema.=1;
run;

data &tema._1;
set &tema._1 &tema._1a;
run;

data &tema._2;
  %NPR(aspes,
     periode=&startaar.-&sluttaar.,
	 normaltariff= 212a 210,
	 where = alder in (18:105) and ermann=0
	   );
  &tema. = 1;
run;

data &tema._3;
  %NPR(aspes,
     periode=&startaar.-&sluttaar.,
	 in_pros=LDA10 LDA20 LDA96 LDC00 LDC03,
	 where = alder in (18:105) and ermann=0
	   );
  &tema. = 1;
run;

proc sort data=&tema._2;
by pid inndato utdato inntid uttid;
run;

proc sort data=&tema._3;
by pid inndato utdato inntid uttid;
run;

data &tema.23;
merge &tema._2(in=a) &tema._3(in=b);
by pid inndato utdato inntid uttid;
if a or b;
run;

/*Ta med første 6 mnd i året etter sluttår*/
data &tema._2a;
set hnana.&aspes_t2;
where inndato le &forlop. and alder in (18:105) and ermann=0;
array prosedyre {*} NC:;
    	do j=1 to dim(prosedyre); 
		if substr(prosedyre{j},1,5) in ('LDA10','LDA20','LDA96','LDC00','LDC03') then &tema.=1;					
	end;
array normt {*} normaltariff:;
    	do i=1 to dim(normt); 
		if normt{i} in ('212a','210') then &tema.=1;					
	end;
drop i;
if &tema.=1;
run;

data &tema.23;
set &tema.23 &tema._2a;
run;

data &tema.;
set &tema._1 &tema.23;
run;

/*data &tema.;*/
/*set &tema.;*/
/*keep pid aar alder ermann inndato utdato all_pros normaltariff:;*/
/*run;*/

data &tema.;
set &tema.;
biopsi = 0;
konisering = 0;
array prosedyre {*} NC:;
    	do j=1 to dim(prosedyre); 
		if substr(prosedyre{j},1,5) in ('LDA10','LDA20','LDA96') then biopsi=1;	
		if substr(prosedyre{j},1,5) in ('LDC00','LDC03') then konisering=1;		
	end;
array normt {*} normaltariff:;
	do i=1 to dim(normt);
		if normt{i} = '212a'  then biopsi=1; 
		if normt{i} = '210'  then konisering=1; 
	end;
drop i j;
run;

proc sort data=&tema.;
by pid inndato utdato;
run;

/*Forløpsanalyse*/
%include "&oppdatering_filbane/figurmakroer/forlop.sas";
%forlop(inndata=&tema., indeks=biopsi, event=konisering);

data &tema.;
set &tema.;
where biopsi=1;
konisert=1;
if dager_etter_biopsi gt (365/2) or dager_etter_biopsi = . then konisert=0;
if konisert=1 then ikke_konisert=0;
if konisert=0 then ikke_konisert=1;
run;

data &tema.;
set &tema.;
where aar le &sluttaar.;
run;

proc sql;
select distinct
aar
from &tema.
group by aar;
quit;
proc sql;
select distinct
dager_etter_biopsi,
count(*) as antall
from &tema.
group by dager_etter_biopsi;
quit;

/**************************************/
%oppdater(&tema.,
   total=&tema.,
	variables=eget_hf annet_hf privat konisert ikke_konisert,
   force_update=true
);

%publiser_rate(&tema.,
   total=&tema.,
   kjonn=kvinner,
   custom_views=
     %define_view(
        name=behandler, 
        variables=eget_hf annet_hf privat,
        title=%str(no := Behandlingssted
                || en := Single year, public/private),
        label_1=no := Eget HF || en := Local public,
        label_2=no := Annet HF || en := Other public,
        label_3=no := Privat || en := Private)
	%define_view(
        name=konisering, 
        variables=konisert ikke_konisert,
        title=%str(no := Konisering innen 6 mnd
                || en := Single year, procedure type),
        label_1=no := Konisering || en := Tonsillectomy,
        label_2=no := Ikke konisering || en := Tonsillotomy)
,
&settinn_txt.
/*tags = kvinner gynekologi,*/
tags= livmorhals, 
   min_age=0, max_age=105
);

%total_figurer;

%panelfigur_todelt(dim1=konisert,dim2=ikke_konisert,dimensjon=konisering);

%panelfigur_tredelt(dim1=eget_hf,dim2=annet_hf,dim3=privat,dimensjon=beh);

%rate_alder_kjonn(aarmin=&startaar,aarmax=&sluttaar,aldermin=16,aldermax=105,kjonn=);

/*SLETTE ALLE DATASETT I WORK */
/*proc datasets nolist library=WORK kill;*/
/*   run; quit;*/
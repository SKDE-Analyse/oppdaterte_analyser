/*!
###Dokumentasjon
Opprettet desember 2024 av Frank Olsen
Sist endret 02/12-24 av Frank Olsen

*/


/*************************************
 GJØ˜R ENDRINGER I DENNE LILLE BOLKEN
*************************************/
%let tema=pacemaker;
%let startaar=2015;
%let sluttaar=2023;
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
	 in_pros=FPE00 FPE10 FPE20 FPE26 FPG30 FPG33 FPG36
		FPF00 FPF10 FPF20 FPG10 FPG20
		FPK10A FPK13A FPK16A FPK20A FPK23A FPK30A FPK33A FPK36A FPK40A FPK50A FPK53A,
	 where = alder in (0:105)	 
  );
  &tema. = 1;
run;

proc sql;
select distinct
aar,
count(*) as antall
from &tema._1
group by aar;
quit;

data &tema.;
set &tema._1;
pm = 1;
crt = 0;
if find(all_pros, 'FPE26') > 0 
    or find(all_pros, 'FPG36') > 0
    or find(all_pros, 'FPK20A') > 0
    or find(all_pros, 'FPK23A') > 0
	or find(all_pros, 'FPK36A') > 0
then crt = 1;
if crt = 1 then pm = 0;
run;

proc sql;
select distinct
aar,
sum(&tema.) as antall,
sum(pm) as pm,
sum(crt) as crt
from &tema.
group by aar;
quit;

%oppdater(&tema.,
   total=&tema.,
	variables=eget_hf annet_hf privat pm crt,
   force_update=true
);

%publiser_rate(&tema.,
   total=&tema.,
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
        name=metode, 
        variables=pm crt,
        title=%str(no := Ordinær pacemaker og CRT
                || en := Single year, procedure type),
        label_1=no := Pacemaker || en := Pacemaker,
        label_2=no := CRT || en := CRT)
,
&settinn_txt.
/*tags= dagkirurgi hjerte,*/
tags = pacemaker, 
   min_age=0, max_age=105
);

%total_figurer;

%panelfigur_tredelt(dim1=eget_hf,dim2=annet_hf,dim3=privat,dimensjon=beh);

%panelfigur_todelt(dim1=pm,dim2=crt,dimensjon=metode);

%rate_alder_kjonn(aarmin=&startaar,aarmax=&sluttaar,aldermin=16,aldermax=105,kjonn=);

/*SLETTE ALLE DATASETT I WORK */
/*proc datasets nolist library=WORK kill;*/
/*   run; quit;*/
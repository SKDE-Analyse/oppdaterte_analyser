/*!
###Dokumentasjon
Opprettet oktober 2024 av Frank Olsen
Sist endret 22/10-24 av Frank Olsen
Endringer 22/10-2024, ny struktur
*/


/*************************************
 GJØR ENDRINGER I DENNE LILLE BOLKEN
*************************************/
%let tema=tonsiller_barn;
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

data &tema._1;
  %NPR(avd,
  	 periode=&startaar.-&sluttaar.,
	 in_pros=EMB10 EMB12 EMB15 EMB20 EMB99 ENC40,
	 in_diag=J350 J351 J353 J358 J359 J36 J390 J030 J038 J039 G473,
	 where = alder in (0:15)	 
  );
  &tema. = 1;
run;

data &tema._2;
  %NPR(aspes,
     periode=&startaar.-&sluttaar.,
	 normaltariff=K02a K02e K02f K02g k02a k02e k02f k02g,
	 in_diag=J350 J351 J353 J358 J359 J36 J390 J030 J038 J039 G473,
	 where = alder in (0:15)
	   );
  &tema. = 1;
run;

data &tema._3;
  %NPR(aspes,
     periode=&startaar.-&sluttaar.,
	 in_pros=EMB10 EMB12 EMB15 EMB20 EMB99 ENC40,
	 in_diag=J350 J351 J353 J358 J359 J36 J390 J030 J038 J039 G473,
	 where = alder in (0:15)
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

data &tema._4;
set &tema._1 &tema.23;
run;

/*Hel vs delvis fjerning - Tonsillektomi vs Tonsillotomi*/
data &tema._4;
set &tema._4;
hel=0; del=0;
array Pros {*} NC:;
    do j=1 to dim(Pros); 
	if Pros{j} in ('EMB10', 'EMB20', 'ENC40') then hel=1;
	if Pros{j} in ('EMB12', 'EMB15', 'EMB99') then del=1;
end;
array normalt {*} normaltariff:;
    do i=1 to dim(normalt); 
	if normalt{i} in ('K02a', 'K02b', 'K02d', 'K02e', 'K02f', 'K02g', 'k02a', 'k02b', 'k02d', 'k02e', 'k02f', 'k02g') then hel=1;
end;
run;

proc sql;
select 
    sum(case when hel = 1 then 1 else 0 end) as hel,
    sum(case when del = 1 then 1 else 0 end) as del,
    sum(case when hel = 1 and del = 1 then 1 else 0 end) as begge,
    sum(case when hel = 0 and del = 0 then 1 else 0 end) as ingen,
	count(*) as alle
from &tema._4;
quit;

data &tema._4;
set &tema._4;
if hel=1 then del=0;
if hel=0 and del=0 then hel=1;
run;

proc sql;
select 
    sum(case when hel = 1 then 1 else 0 end) as hel,
    sum(case when del = 1 then 1 else 0 end) as del,
    sum(case when hel = 1 and del = 1 then 1 else 0 end) as begge,
    sum(case when hel = 0 and del = 0 then 1 else 0 end) as ingen,
	count(*) as alle
from &tema._4;
quit;


/*Kjøre makro for å lage tredeling kn. til behandlingssted*/
%beh_eget_annet_priv(inndata=&tema._4, utdata=&tema._3delt, as_data=1);

data &tema.;
set &tema._3delt;
run;

%oppdater(&tema.,
   total=&tema.,
	variables=eget annet privat hel del,
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
        variables=hel del,
        title=%str(no := Enkeltår, type inngrep
                || en := Single year, procedure type),
        label_1=no := Tonsillektomi || en := Tonsillectomy,
        label_2=no := Tonsillotomi || en := Tonsillotomy)
,
&settinn_txt.
   tags=barn tonsillektomi dagkirurgi ore-nese-hals, 
   min_age=0, max_age=15
);

/**/
/*Figurer og tabeller*/
%total_figurer;

%panelfigur_todelt(dim1=hel,dim2=del,dimensjon=metode);

%panelfigur_tredelt(dim1=eget,dim2=annet,dim3=privat,dimensjon=beh);

%rate_alder_kjonn(aarmin=&startaar,aarmax=&sluttaar,aldermin=0,aldermax=15,kjonn=);

%dim_rate_alder_kjonn(dim=del,aarmin=&startaar,aarmax=&sluttaar,aldermin=0,aldermax=15,kjonn=);

/**/

/*til nrk*/
data nrk_rate;
set pub_sykehus_rate_long;
keep aar pop tonsiller_barn_ant tonsiller_barn_rate;
where bohf = 8888 and aar ne 9999;
run;

%include "&filbane/formater/beh.sas";

data utvalg;
set &tema.;
format behsh behsh_fmt.;
run;

proc sql;
select distinct
behsh
from utvalg;
quit;

proc sql;
create table haukeland as
select distinct
aar, count(*) as ant
from utvalg
where behsh=101
group by aar;
quit;

/*SLETTE ALLE DATASETT I WORK */
proc datasets nolist library=WORK kill;
   run; quit;
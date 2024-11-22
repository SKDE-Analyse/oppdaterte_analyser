/*!
###Dokumentasjon
Opprettet oktober 2024 av Frank Olsen
Sist endret 22/10-24 av Frank Olsen
Endringer 22/10-2024, ny struktur
*/


/*************************************
 GJØR ENDRINGER I DENNE LILLE BOLKEN
*************************************/
%let tema=tonsiller_voksne;
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

data &tema._1;
  %NPR(avd,
  	 periode=2015-2023,
	 in_pros=EMB10 EMB12 EMB15 EMB20 EMB99 ENC40,
	 in_diag=J350 J351 J353 J358 J359 J36 J390 J030 J038 J039 G473,
	 where = alder in (16:105)	 
  );
  &tema. = 1;
run;

data &tema._2;
  %NPR(aspes,
     periode=2015-2023,
	 normaltariff=K02a K02e K02f K02g k02a k02e k02f k02g,
	 in_diag=J350 J351 J353 J358 J359 J36 J390 J030 J038 J039 G473,
	 where = alder in (16:105)
	   );
  &tema. = 1;
run;

data &tema._3;
  %NPR(aspes,
     periode=2015-2023,
	 in_pros=EMB10 EMB12 EMB15 EMB20 EMB99 ENC40,
	 in_diag=J350 J351 J353 J358 J359 J36 J390 J030 J038 J039 G473,
	 where = alder in (16:105)
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
,
&settinn_txt.
tags=voksne tonsillektomi ore-nese-hals, 
   min_age=16, max_age=105
);

%total_figurer;

%panelfigur_tredelt(dim1=eget,dim2=annet,dim3=privat,dimensjon=beh);

%rate_alder_kjonn(aarmin=&startaar,aarmax=&sluttaar,aldermin=16,aldermax=105,kjonn=);

%dim_rate_alder_kjonn(dim=endo_hyst,aarmin=&startaar,aarmax=&sluttaar,aldermin=16,aldermax=105,kjonn=);

/*SLETTE ALLE DATASETT I WORK */
proc datasets nolist library=WORK kill;
   run; quit;
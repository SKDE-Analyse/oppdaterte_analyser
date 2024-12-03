/*!
###Dokumentasjon
Opprettet desember 2024 av Frank Olsen
Sist endret 02/12-24 av Frank Olsen

*/


/*************************************
 GJØ˜R ENDRINGER I DENNE LILLE BOLKEN
*************************************/
%let tema=taakirurgi;
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
	 in_pros=NHG09 NHG44 NHG46 NHG49 NHK17 NHK18 NHK57 NHK58,
	 in_diag=M201 M202 M203 M204 M205 M206,
	 where = alder in (0:105)	 
  );
  &tema. = 1;
  drop bdiag: nc:;
run;

data &tema._2;
  %NPR(aspes,
     periode=&startaar.-&sluttaar.,
	 normaltariff= 134a 134b 140d,
	 in_diag=M201 M202 M203 M204 M205 M206,
	 where = alder in (0:105)
	   );
  &tema. = 1;
  drop bdiag:;
run;

data &tema._3;
  %NPR(aspes,
     periode=&startaar.-&sluttaar.,
	 in_pros=NHG09 NHG44 NHG46 NHG49 NHK17 NHK18 NHK57 NHK58,
	 in_diag=M201 M202 M203 M204 M205 M206,
	 where = alder in (0:105)
	   );
  &tema. = 1;
  drop bdiag:;
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

/*Kjøre makro for å lage tredeling kn. til behandlingssted*/
%beh_eget_annet_priv(inndata=&tema._4, utdata=&tema._3delt, as_data=1);

data &tema.;
set &tema._3delt;
run;

%oppdater(&tema.,
   total=&tema.,
	variables=eget annet privat,
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
tags= dagkirurgi ortopedi, 
   min_age=0, max_age=105
);

%total_figurer;

%panelfigur_tredelt(dim1=eget,dim2=annet,dim3=privat,dimensjon=beh);

%rate_alder_kjonn(aarmin=&startaar,aarmax=&sluttaar,aldermin=16,aldermax=105,kjonn=);

/*SLETTE ALLE DATASETT I WORK */
/*proc datasets nolist library=WORK kill;*/
/*   run; quit;*/
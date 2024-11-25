/*!
###Dokumentasjon
Opprettet oktober 2024 av Hanne Sigrun Byhring
Sist endret 22/10-24 av Frank Olsen
Endringer 22/10-2024, ny struktur
*/


/*************************************
 GJØR ENDRINGER I DENNE LILLE BOLKEN
*************************************/
%let tema=injeksj_pas;
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

data inj_rader;
  %NPR(avd,
    periode=&startaar.-&sluttaar.,
	 in_diag=H353 H360 E103 E113 H348 H349, /*AMD, blodpropp i netthinne, diabetisk retinopati*/
	 in_pros=CKD05,
	 where=alder in (50:105)
  );
 &tema. = 1;	/*alle*/

run;


/*Skal kun telle hver pasient en gang, derfor mÃ¥ jeg legge inn 
steg her for Ã¥ fjerne alle rader unntatt en pr pas pr Ã¥r*/

/*START UTVALG AV BOHF OG BEHHF, BASERT PÃ… ANTALL KONTAKTER*/

/*Må velge bosted for pasienter med flere bosted/behandlingssteder ila Året
Velger bosted med flest kontakter*/

/* 1. tell antall bohf pr pid og aar */
proc sql;
   create table bohf_ant as
   select 
       pid, aar, bohf, 
	   inndato, inntid, utdato, uttid, 
       count(*) as bohf_ant
   from inj_rader
   group by pid, aar, bohf;
quit;

/* 2. Velg kun bohf som forekommer oftest - velger også det første blandt det som forekommer oftest */
proc sort data=bohf_ant;
   by pid aar descending bohf_ant inndato inntid utdato uttid;
run;

data oftest_bohf;
   set bohf_ant;
   by pid aar descending bohf_ant inndato inntid utdato uttid;
   if last.aar then output;
run;

/* 3. Merge de valgte til inj_rader */
proc sql;
   create table inj_rader_flagg as
   select 
       a.*, 
       case 
           when a.bohf = b.bohf then 1 
           else 0 
       end as bohf_flag
   from inj_rader as a
   left join oftest_bohf as b
   on a.pid = b.pid 
   and a.aar = b.aar 
   and a.bohf = b.bohf
   and a.inndato = b.inndato
   and a.inntid = b.inntid
   and a.utdato = b.utdato
   and a.uttid = b.uttid;
quit;

proc sql;
	create table inj_rader_flagg as
	select *,
		max(bohf_flag) as flagget_bohf
	from inj_rader_flagg
	group by pid, aar, bohf;
quit;


/*GÃ…R VIDERE MED UTVALGSDATASETTET "injeksj_pas"*/
data injeksj_pas;
set inj_rader_flagg;
where bohf_flag=1;
run;


%oppdater(&tema.,
   total=&tema.,
   force_update=true
);

/*Kun totalrater for pasientnivået! Ingen "custom views". */
%publiser_rate(&tema.,
   total=&tema.,
&settinn_txt.
   tags=eldre oye, 
   min_age=50, max_age=105
);

/*FIGURER FOR ANALYSE/SKRIVING UNDER HER:*/
%total_figurer;

%rate_alder_kjonn(aarmin=&startaar,aarmax=&sluttaar,aldermin=50,aldermax=105,kjonn=);

/*lage kopi av datasett med samme navn som variabel for å få figurmakroer til å funke ...*/
/* data injeksjon;
set injeksj_pas;
run;

%let tema=injeksjon;
%let bildesti =/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser/Figurer/injeksjon/injeksjon_pas;
%include "/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser/figurmakroer/panel_total.sas";
%panelfigur_tot(tema=injeksjon);


%include "/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser/figurmakroer/rate_alder_kjonn.sas";
%rate_alder_kjonn(aarmin=2015,aarmax=2023,aldermin=50,aldermax=105,kjonn=); */

/*SLETTE ALLE DATASETT I WORK */
/* proc datasets nolist library=WORK kill;
   run; quit; */




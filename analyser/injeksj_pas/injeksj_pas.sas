%let oppdatering_filbane=/sas_smb/skde_analyse/Brukere/Mattias/oppdaterte_analyser;
%let filbane=/sas_smb/skde_analyse/Data/SAS/felleskoder/main;

%include "&oppdatering_filbane/makroer/setup.sas";
%include "&filbane/makroer/beh_eget_annet_priv.sas";

%include "&filbane/stiler/anno_logo_kilde_npr_ssb.sas";
%let bildesti =/sas_smb/skde_analyse/helseatlas/rutine_oppdatering/Figurer/injeksjon/injeksjon_pas;



data inj_rader;
  %NPR(avd,
    periode=2015-2023,
	 in_diag=H353 H360 E103 E113 H348 H349, /*AMD, blodpropp i netthinne, diabetisk retinopati*/
	 in_pros=CKD05,
	 where=alder in (50:105)
  );
  injeksjon = 1;	/*alle*/

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

%oppdater(injeksj_pas,
   total=injeksjon,
   force_update=true
);

/*Kun totalrater for pasientnivået! Ingen "custom views". */
%publiser_rate(injeksj_pas,
   total=injeksjon,
   custom_views=
     %define_view(
        name=tot, 
        variables=injeksjon,
        title=%str(no := Enkeltår
                || en := Single year),
        label_1=no := Total  || en := Total ),
	summary=blabla,
	discussion=blabla,
   title=
      no := Injeksjonsbehandling i øyet
   || en := Eye injection treatment,
   tags=eldre oye, 
   min_age=50, max_age=105
);

/*lage kopi av datasett med samme navn som variabel for å få figurmakroer til å funke ...*/
data injeksjon;
set injeksj_pas;
run;

%let tema=injeksjon;
%let bildesti =/sas_smb/skde_analyse/helseatlas/rutine_oppdatering/Figurer/injeksjon/injeksjon_pas;
/*Figurer og tabeller*/
%include "/sas_smb/skde_analyse/helseatlas/rutine_oppdatering/makro/panel_total.sas";
%panelfigur_tot(tema=injeksjon);


%include "/sas_smb/skde_analyse/helseatlas/rutine_oppdatering/makro/rate_alder_kjonn.sas";
%rate_alder_kjonn(aarmin=2015,aarmax=2023,aldermin=50,aldermax=105,kjonn=);

/*SLETTE ALLE DATASETT I WORK */
proc datasets nolist library=WORK kill;
   run; quit;




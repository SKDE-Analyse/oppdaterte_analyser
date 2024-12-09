/*************************************
 GJ�R ENDRINGER I DENNE LILLE BOLKEN
*************************************/
%let tema=kneprotese;
%let startaar=2015;
%let sluttaar=2023;
/****************************************
 OG TILPASS MAKROER ETTER PUBLISER_RATE
*****************************************/

%let oppdatering_filbane=/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser;
/*Makroer for � lage data til analyse*/
%include "&oppdatering_filbane/makroer/setup.sas";
/*Makroer og stier for figurer*/
%include "&oppdatering_filbane/figurmakroer/oppsett.sas";
%include "&filbane/makroer/kodematch.sas";

/*** Utvalg og analyse ***/

data &tema.;
  %NPR(avd aspes,
    periode=&startaar.-&sluttaar.,
    in_pros=NGB0 NGB1 NGB20 NGB30 NGB40 NGB99,
	where = alder in (18:105)
  )
  &tema. = 1;

  *hoftebrudd = %kodematch(all_diag, S72[0-2]);
  *ikke_hoftebrudd = not hoftebrudd;

  *if ikke_hoftebrudd;
run;

/*
proc freq data=&tema.;table aar/missing;run;
*/
*if substr((diagnose{j}),1,4) in ('S720' 'S721' 'S722') then hoftebrudd=1; 




/* Sjekker dubletter
proc sort data=&tema. nodupkey out=slett dupout=dub;by  pid inndato utdato inntid uttid;run;
*/

%oppdater(&tema.,
   total=&tema.,
   variables=eget_hf annet_hf privat,
   force_update=true
);

/*kj�rer rate*/
%publiser_rate(&tema.,
   total=&tema.,
   custom_views=
     %define_view(
        name=behandler, 
        variables=eget_hf annet_hf privat,
        title=%str(no := Enkelt�r, behandlingssted
                || en := Single year, public/private),
        label_1=no := Eget HF || en := Local public,
        label_2=no := Annet HF || en := Other public,
        label_3=no := Privat || en := Private),
   &settinn_txt.
   tags=hofteprotese, 
   min_age=18, max_age=105
);


/*Figurer og tabeller*/
%total_figurer;

%panelfigur_tredelt(dim1=eget_hf,dim2=annet_hf,dim3=privat,dimensjon=beh);

%rate_alder_kjonn(aarmin=&startaar.,aarmax=&sluttaar.,aldermin=18,aldermax=105,kjonn=);

/*SLETTE ALLE DATASETT I WORK */
/* proc datasets nolist library=WORK kill;
   run; quit; */

/*************************************
 GJØR ENDRINGER I DENNE LILLE BOLKEN
*************************************/
%let tema=kneprotese;
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
%include "&filbane/makroer/kodematch.sas";

/*** Utvalg og analyse ***/

data &tema.;
  %NPR(avd aspes,
    periode=&startaar.-&sluttaar.,
    in_pros=NGB0 NGB1 NGB20 NGB30 NGB40 NGB99,
	where = alder in (50:105)
  )
  &tema. = 1;
  delprotese = %kodematch(all_pros, NGB0 NGB1);
  helprotese = %kodematch(all_pros, NGB20 NGB30 NGB40 NGB99);
  if delprotese + helprotese = 2 then do;
    both = 1;
    helprotese = 0.5;
	delprotese = 0.5;
  end;
run;

/*Teller treff per år
proc freq data=&tema.;table aar/missing;run;

Sjekker dubletter
proc sort data=&tema. nodupkey out=slett dupout=dub;by  pid inndato utdato inntid uttid;run;
*/

%oppdater(&tema.,
   total=&tema.,
   variables=eget_hf annet_hf privat delprotese helprotese,
   force_update=true
);

/*kjører rate*/
%publiser_rate(&tema.,
   total=&tema.,
   custom_views=
     %define_view(
        name=behandler, 
        variables=eget_hf annet_hf privat,
        title=%str(no := Behandlingssted
                || en := Public/private),
        label_1=no := Eget HF || en := Local public,
        label_2=no := Annet HF || en := Other public,
        label_3=no := Privat || en := Private)
     %define_view(
        name=en_hel_del, 
        variables=helprotese delprotese,
        title=%str(no := Helprotese/delprotese
                || en := Whole/partial prosthesis),
        label_1=no := Helprotese || en := Whole,
        label_2=no := Delprotese || en := Partial),
   &settinn_txt.
   tags=ortopedi eldre, 
   min_age=50, max_age=105
);


/*Figurer og tabeller*/
%total_figurer;

%panelfigur_tredelt(dim1=eget_hf,dim2=annet_hf,dim3=privat,dimensjon=beh);

%rate_alder_kjonn(aarmin=&startaar.,aarmax=&sluttaar.,aldermin=50,aldermax=105,kjonn=);
%dim_rate_alder_kjonn(dim=privat,aarmin=&startaar.,aarmax=&sluttaar.,aldermin=50,aldermax=105,kjonn=);

/*SLETTE ALLE DATASETT I WORK */
/* proc datasets nolist library=WORK kill;
   run; quit; */

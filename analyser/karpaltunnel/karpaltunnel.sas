/*************************************
 GJØR ENDRINGER I DENNE LILLE BOLKEN
*************************************/
%let tema=karpaltunnel;
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
  %NPR(avd aspes,
    periode=&startaar.-&sluttaar.,
	 in_diag=G560,
	 in_pros=ACC51 NDE1[12] NDM[14]9 NDL50,
	 where = alder in (17:105)
  )
  &tema. = 1;
run;

data &tema._2;
  %NPR(aspes,
    periode=&startaar.-&sluttaar.,
	 in_diag=G560,
	 normaltariff=140i,
	 where = alder in (17:105)
  )
  &tema. = 1;
run;

*Sorterer (men kan også brukes for å sjekker dubletter);

proc sort data=&tema._1;* nodupkey out=slett dupout=dub;by  pid inndato utdato inntid uttid;run;
proc sort data=&tema._2;* nodupkey out=slett dupout=dub;by  pid inndato utdato inntid uttid;run;

data &tema.;
  merge &tema._1(in=a) &tema._2(in=b);
  by pid inndato utdato inntid uttid;
  if a or b;
run;

/* Sjekker dubletter
proc sort data=&tema._merged nodupkey out=slett dupout=dub;by  pid inndato utdato inntid uttid;run;
*/

%oppdater(&tema.,
   total=&tema.,
   variables=eget_hf annet_hf privat,
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
,
&settinn_txt.
   tags=ortopedi dagkirurgi,
   min_age=17, max_age=105
);


/*Figurer og tabeller*/
%total_figurer;

%panelfigur_tredelt(dim1=eget_hf,dim2=annet_hf,dim3=privat,dimensjon=beh);

%rate_alder_kjonn(aarmin=&startaar,aarmax=&sluttaar,aldermin=17,aldermax=105,kjonn=);

/* 
proc print data=karpaltunnel_1;where pid in(2021337884 2021439627 2021466596 2021470400 2021527888 2021841050 2021891667)and aar=2018;run;
proc freq data=karpaltunnel;table alder*aar/missing nocol nopercent norow;run;
*/

/*SLETTE ALLE DATASETT I WORK */
/* proc datasets nolist library=WORK kill;
   run; quit; */

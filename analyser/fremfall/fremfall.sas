/*!
# Dokumentasjon skjede- og livmorfremfall

*/

%let oppdatering_filbane=/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser;
%let filbane=/sas_smb/skde_analyse/Data/SAS/felleskoder/main;

%include "&oppdatering_filbane/makroer/setup.sas";
%include "&filbane/makroer/beh_eget_annet_priv.sas";

%include "&filbane/stiler/anno_logo_kilde_npr_ssb.sas";
%let bildesti =/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser/Figurer/fremfall/fremfall_kont;

%let no_utvalg=
Analysen er basert på aktivitetsdata fra Norsk pasientregister (NPR) for 
somatisk spesialisthelsetjeneste. Data inkluderer aktivitet i offentlige sykehus og 
private sykehus som leverer offentlig finansierte tjenester. 
Data fra avtalespesialister er ikke inkludert, fordi denne behandlingen kun gis på sykehus. 
\n \n 
Utvalget består av 
\n \n
Hvor pasienten er behandlet er delt inn i tre kategorier:\n
- Eget HF, behandlet ved et av sykehusene i opptaksområdet
\n - Annet HF, behandlet ved et sykehus utenfor opptaksområdet
\n - Privat, behandlet ved et privat sykehus 
;

%let en_utvalg=
The analysis is based on activity data from the Norwegian Patient Register (NPR) for somatic specialist health services. 
The data includes activity in public hospitals and private hospitals that provide publicly funded services. 
Data from specialists under public funding contracts are not included, as this treatment is only provided in hospitals.
\n \n
The sample consists of 
\n \n
The place of treatment is divided into three categories:\n
- Local public, treated at one of the hospitals in the catchment area
\n - Other public, treated at a public hospital outside the catchment area
\n - Private, treated by a private hospital
;

%let no_summary=
- A
\n - B
\n - C
;

%let en_summary=
- A
\n - B
\n - C
;

%let no_discussion=
Diskusjon
;

%let en_discussion=
Discussion
;

%let no_utvalg = %superq(no_utvalg);
%let en_utvalg = %superq(en_utvalg);
%let no_summary = %superq(no_summary);
%let en_summary = %superq(en_summary);
%let no_discussion = %superq(no_discussion);
%let en_discussion = %superq(en_discussion);

data fremfall_utv;
  %NPR(avd, /*Gjøres kun på sykehus*/
    periode=2015-2023,
	 in_diag=N81, 
	 in_pros=LEF00 LEF03 LEF10 LEF13 LEF16 LEF20 LEF23 LEF34 LEF40 LEF41 LEF50 LEF51 LEF53 LEF96 LEF97, 
         /*HSB_19nov2024: Utvalgskoder sjekket mot metodebok.no (https://metodebok.no/index.php?action=topic&item=tE5VKGaZ) */
	 where=
  );
 fremfall = 1;	/*alle*/

run;

/*Kjøre makro for å lage tredeling kn. til behandlingssted*/
%beh_eget_annet_priv(inndata=fremfall_utv, utdata=fremfall, as_data=0);


%oppdater(fremfall,
   total=fremfall,
   variables=eget annet privat,
   force_update=true
);

%publiser_rate(fremfall,
   total=fremfall,
   custom_views=
	%define_view(
        name=behandler, 
        variables=eget annet privat,
        title=%str(no := Enkeltår, behandler
                || en := Single year, public/private),
        label_1=no := Eget HF || en := Local public,
        label_2=no := Annet HF || en := Other public,
        label_3=no := Privat || en := Private),
   title=
      no := Operasjon for skjede/livmorfremfall
   || en := Surgery, pelvic organ prolapse,
   description=
      no := %str(Antall kontakter pr 1000 kvinner)
   || en := %str(Number of contacts pr 1000 women),
   info =
   no :=%nrstr(&no_utvalg)
|| en :=%nrstr(&en_utvalg),
   summary =
   no :=%nrstr(&no_summary)
|| en :=%nrstr(&en_summary),
   discussion=
   no := %nrstr(&no_discussion)   
|| en := %nrstr(&en_discussion),
   tags=gynekologi kvinner
);

/*FIGURER TIL STØTTE I SKRIVINGEN UNDER HER:*/

%let tema=fremfall;
%let bildesti =/sas_smb/skde_analyse/helseatlas/oppdaterte_analyser/Figurer/fremfall/fremfall_kont;

/*Figurer og tabeller*/
%include "/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser/figurmakroer/panelfig.sas";
%panelfigur(tema=fremfall);

%include "/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser/figurmakroer/panel_total.sas";
%panelfigur_tot(tema=fremfall);


/*SLETTE ALLE DATASETT I WORK */
proc datasets nolist library=WORK kill;
   run; quit;
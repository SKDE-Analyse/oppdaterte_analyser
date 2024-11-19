
%let oppdatering_filbane=/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser;
%let filbane=/sas_smb/skde_analyse/Data/SAS/felleskoder/main;
%include "&oppdatering_filbane/makroer/setup.sas";
%include "&filbane/makroer/beh_eget_annet_priv.sas";
%include "&filbane/stiler/anno_logo_kilde_npr_ssb.sas";

%let bildesti =/sas_smb/skde_analyse/helseatlas/oppdaterte_analyser/Figurer/endometriose;

%include "/sas_smb/skde_analyse/helseatlas/oppdaterte_analyser/figurmakroer/panelfig.sas";
%include "/sas_smb/skde_analyse/helseatlas/oppdaterte_analyser/figurmakroer/rate_alder_kjonn.sas";

%let tema=endometriose;

%let no_utvalg=
Analysen 
;

%let en_utvalg=
The analysis
;

%let no_summary = 
- Det er stor geografisk variasjon i operasjoner av mandler (tonsilleoperasjoner)
\n - Antall operasjoner pr år har holdt seg forholdsvis stabil i perioden (bortsett fra pandemien)
\n - Andelen operasjoner med tonsillotomi har økt fra under 10 % i 2015 til over 40 % i 2023
;

%let en_summary = 
- There is significant geographical variation in tonsil operations
\n - The number of patients undergoing surgery per year has remained relatively stable over the period (except during the pandemic)
\n - The proportion procedures with tonsillotomy has increased from less than 10 % in 2015 to more than 40 % in 2023
;

/*1 000 000*/
/*0 000*/


%let no_discussion = 
Det utføres i underkant av 5 000 tonsilleoperasjoner pr år på barn under 16 år. Antall operasjoner falt markant under pandemien, 
og nådde først i 2023 nivået fra før covid-19. Det er stor geografisk variasjon i antall operasjoner. 
Gutter opereres i større grad enn jenter, og gjennomsnittsalderen er noe lavere for gutter enn jenter ved operasjonstidspunktet.
\n\n 
Andelen som får delvis fjerning av mandlene (tonsillotomier) har økt fra i underkant av 10 % i 2015 til over 40 % etter pandemien. 
I følge Tonsilleregisteret er en av årsakene til dette at indikasjon hypertrofi benyttes oftere for barn, og da ansees tonsillotomi 
som et tryggere inngrep med færre postoperative komplikasjoner.
\n\n 
Barna behandles hovedsakelig i eget HF. Den betydelige observerte geografiske variasjonen over tid kan tyde på overbehandling i noen 
områder og underbehandling i andre. Data fra Tonsilleregisteret for 2023 viser imidlertid at 92 % var symptomfrie 6 måneder etter operasjon. 
Reduksjonen i raten for opptaksområdet Bergen fra 2022 til 2023 skyldes sannsynligvis manglende innrapportering fra avtalespesialist i 2023.  
;

%let en_discussion = 
Approximately 5 000 tonsil operations are performed annually on children under 16 years old. The number of operations dropped 
significantly during the pandemic and only returned to pre-COVID-19 levels in 2023. There is significant geographical variation 
in the number of operations. Boys are operated on more frequently than girls, and the average age at the time of surgery is 
slightly lower for boys than for girls. 
\n\n
The proportion of partial tonsil removals (tonsillotomies) has increased from just under 10 % in 2015 to over 40 % after the pandemic. 
According to the Tonsil Register, one reason for this is that the indication for hypertrophy is used more often for children, 
and tonsillotomy is considered a safer procedure with fewer postoperative complications.
\n\n
Children are mainly treated in their own health trust. The significant observed geographical variation over time may indicate 
overtreatment in some areas and undertreatment in others. However, data from the Tonsil Register for 2023 shows that 92 % were 
symptom-free 6 months after surgery. The reduction in the rate for the Bergen catchment area from 2022 to 2023 is likely due to a 
lack of reporting from contracted specialists in 2023.
;

%let no_utvalg = %superq(no_utvalg);
%let en_utvalg = %superq(en_utvalg);
%let no_summary = %superq(no_summary);
%let en_summary = %superq(en_summary);
%let no_discussion = %superq(no_discussion);
%let en_discussion = %superq(en_discussion);

/*Endometriose
1. Skille på Hysterektomi og andre prosedyrer
2. Skille på åpne, vaginale og lapraskopiske
*/

data endo_1;
  %NPR(avd,
  	 periode=2022-2023,
	 in_diag=N80 N941 N944 N945 N946,
	 in_pros=LCD00 LCD30 LCD96 LCD10 LCD40 LCD01 LCD04 LCD11 LCD31 LCD97 LCC10 LCC11 LCC20 
		JAL21 JAP00 JAP01 JAL20 JAL21 JAA10 JAA11 LAC00 LAC01 LAC10 LAC11 LAC20 LAC21 LCF00
		LCF01 LAD00 LAD01 LAE10 LAE11 LAE20 LAE21 LAF00 LAF01 LAF10 LAF11 LAF20 LAF30 LBD00
		LBD01 LBE00 LBE01 LCC00 LCC01 LCC05 LCC96 LCC97 LCF97 LCF96,
	where = alder in (16:55) and ermann=0 
  );
  endometriose = 1;
run;

/*Hystrektomi*/
data endo_2;
  %NPR(avd,
  	 periode=2022-2023,
	 in_diag=N80 N941 N944 N945 N946,
	 in_pros=LCD00 LCD30 LCD96 LCD10 LCD40 LCD01 LCD04 LCD11 LCD31 LCD97 LCC10 LCC11 LCC20,
	where = alder in (16:55) and ermann=0  
  );
  endo_hyst = 1;
run;

/*Andre pros*/
data endo_3;
  %NPR(avd,
  	 periode=2022-2023,
	 in_diag=N80 N941 N944 N945 N946,
	 in_pros=JAL21 JAP00 JAP01 JAL20 JAL21 JAA10 JAA11 LAC00 LAC01 LAC10 LAC11 LAC20 LAC21 
		LCF00 LCF01 LAD00 LAD01 LAE10 LAE11 LAE20 LAE21 LAF00 LAF01 LAF10 LAF11 LAF20 LAF30 
		LBD00 LBD01 LBE00 LBE01 LCC00 LCC01 LCC05 LCC96 LCC97 LCF97 LCF96,
	where = alder in (16:55) and ermann=0  
  );
  endo_andre = 1;
run;

proc sql;
   create table endo as
   select 
       a.*, 
       b.endo_hyst, 
       c.endo_andre
   from endo_1 as a
   left join endo_2 as b
   on a.pid = b.pid
   and a.inndato = b.inndato
   and a.utdato = b.utdato
   and a.inntid = b.inntid
   and a.uttid = b.uttid
   left join endo_3 as c
   on a.pid = c.pid
   and a.inndato = c.inndato
   and a.utdato = c.utdato
   and a.inntid = c.inntid
   and a.uttid = c.uttid;
quit;

data endo;
set endo;
if endo_hyst=1 then endo_andre=.;
if endo_hyst=. then endo_hyst=0;
if endo_andre=. then endo_andre=0;
run;

/*Kjøre makro for å lage tredeling kn. til behandlingssted*/
%beh_eget_annet_priv(inndata=endo, utdata=&tema._3delt, as_data=0);

data &tema.;
set &tema._3delt;
run;

%oppdater(&tema.,
   total=&tema.,
	variables=endo_hyst endo_andre eget annet privat,
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
        variables=endo_hyst endo_andre,
        title=%str(no := Enkeltår, type inngrep || en := Single year, procedure type),
        label_1=no := Hysterektomi || en := Hysterectomy,
        label_2=no := Andre inngrep || en := Other),
   title=
      no := Kirurgiske inngrep for endometriose
   || en := Surgery,
   description=%str(
      no := Antall inngrep pr 1000 kvinner, 16-55 år || en := Number of procedures per 1000 women, 16-55 years),
   info =
   no :=%nrstr(&no_utvalg)
|| en :=%nrstr(&en_utvalg),
   summary=
      no := &no_summary. || en := &en_summary. ,
   discussion=%nrstr(
      no := &no_discussion. || en := &en_discussion. ),
   tags=kvinner endometriose
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
   title=
      no := Kirurgiske inngrep for endometriose
   || en := Surgery,
   description=%str(
      no := Antall inngrep pr 1000 kvinner, 16-55 år || en := Number of procedures per 1000 women, 16-55 years),
   info =
   no :=%nrstr(&no_utvalg)
|| en :=%nrstr(&en_utvalg),
   summary=
      no := &no_summary. || en := &en_summary. ,
   discussion=%nrstr(
      no := &no_discussion. || en := &en_discussion. ),
   tags=kvinner endometriose
);




%let oppdatering_filbane=/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser;
%let filbane=/sas_smb/skde_analyse/Data/SAS/felleskoder/main;

%include "&oppdatering_filbane/makroer/setup.sas";
%include "&filbane/makroer/beh_eget_annet_priv.sas";

%include "&filbane/stiler/anno_logo_kilde_npr_ssb.sas";
%let bildesti =/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser/Figurer/injeksjon/injeksjon_pas;

%let no_utvalg=
Analysen er basert på aktivitetsdata fra Norsk pasientregister (NPR) for 
somatisk spesialisthelsetjeneste. Data inkluderer aktivitet i offentlige sykehus og 
private sykehus som leverer offentlig finansierte tjenester. 
Data fra avtalespesialister er ikke inkludert, fordi denne behandlingen kun gis på sykehus. 
\n \n
Utvalget består av pasienter i alderen 50 år eller eldre registrert med hoved- eller bidiagnose aldersrelatert 
makuladegernerasjon, AMD (H35.3), veneokklusjon (H34.8 eller H34.9) eller 
diabetisk retinopati (H36.0, E10.3 eller E11.3) 
i kombinasjon med prosedyrekode CKD05. 
\n \n
Dersom pasienten har flyttet mellom to opptaksområder i løpet av et år er pasientens bosted 
definert som det bostedet/opptaksområdet der pasienten hadde flest kontakter i løpet av året.
;

%let en_utvalg=
The analysis is based on activity data from the Norwegian Patient Register (NPR) for somatic specialist health services. 
The data includes activity in public hospitals and private hospitals that provide publicly funded services. 
Data from specialists under public funding contracts are not included, as this treatment is only provided in hospitals.
\n \n
The sample consists of patients aged 50 years or older registered with a primary or secondary diagnosis 
of age-related macular degeneration, AMD (H35.3), venous occlusion (H34.8 or H34.9), 
or diabetic retinopathy (H36.0, E10.3, or E11.3) in combination with 
procedure code CKD05. 
\n \n
If the patient has moved between two catchment areas within a year, 
the residence is defined as the residence/catchment area where the patient 
had the most contacts during the year.
;

%let no_summary=
- Det er betydelig geografisk variasjon i bruk av injeksjonsbehandling
\n - Antall pasienter i behandling øker med omlag 1 300 pr år
\n - Raten er 24 % høyere for kvinner enn for menn
;

%let en_summary=
- There is significant geographical variation in the use of injection treatment
\n - The number of patients in treatment increases by approximately 1,300 per year
\n - The rate is 24 % higher for women than for men
;

%let no_discussion=
Antall pasienter i behandling økte med omlag 1 300 pr år i perioden 2015 - 2023 
fra 11 043 pasienter i 2015 til 21 911 pasienter i 2023. Årsaken til pasientveksten er at dette er behandling 
for kroniske tilstander, hovedsakelig aldersrelatert makuladegenerasjon, og at antall nye pasienter år for år 
overstiger antall pasienter som avslutter sin behandling. Dersom antall pasienter i behandling fortsetter å øke i 
årene fremover kan det bli behov for endringer i organisering av tjenesten for å sikre tilgang til god og likeverdig behandling. 
\n \n
De fleste pasientene var mellom 70 og 90 år gamle. Raten for kvinner var på 11,7 pasienter pr 1 000 kvinner og 
raten for menn var på 9,5 pasienter pr 1 000 menn i 2023. Det er betydelig geografisk variasjon i pasientraten. 
Dette er i tråd med funnene til [Husum et al. 2023](https://onlinelibrary.wiley.com/doi/10.1111/aos.16598) 
som antyder at den observerte variasjonen kan ha sammenheng med overbehandling enkelte steder og underbehandling i andre områder. 
Artikkelforfatterne peker på et behov for tydeligere styring, nasjonale retningslinjer og et nasjonalt kvalitetsregister på området.
;

%let en_discussion=
The number of patients in treatment increased by approximately 1,300 per year from 2015 to 2023, 
from 11,043 patients in 2015 to 21,911 patients in 2023. The reason for the patient growth is that this is a 
treatment for chronic conditions like age-related macular degeneration, and that the number of new patients each year exceeds the 
number of patients who discontinue their treatment. If the number of patients in treatment continues to increase in the coming years, 
changes in the organization of services may be needed to ensure access to good and equitable treatment. 
\n \n
Most of the patients were between 70 and 90 years old. The rate for women was 11,7 pastients pr 1 000 women and 
the rate for men was 9,5 patiens pr 1 000 men in 2023. There is significant geographical variation in the patient rate. 
This is in agreement with [Husum et al. 2023](https://onlinelibrary.wiley.com/doi/10.1111/aos.16598), 
who suggest that the observed variation may be related to overtreatment in some areas and undertreatment in others. 
The authors point to a need for clearer management, national guidelines, and a national quality register in the field.
;

%let no_utvalg = %superq(no_utvalg);
%let en_utvalg = %superq(en_utvalg);
%let no_summary = %superq(no_summary);
%let en_summary = %superq(en_summary);
%let no_discussion = %superq(no_discussion);
%let en_discussion = %superq(en_discussion);


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
	title=
      no := %str(Injeksjonsbehandling (pasientrate, 50 år+))
   || en := %str(Injection treatment (pasient rate, 50 yrs+)),
   description=%str(
      no := Antall pasienter pr 1000 innbyggere, 50 år eller eldre
   || en := Number of patients pr 1000 inhabitants, 50 years or older),
	info =
   no :=%nrstr(&no_utvalg)
|| en :=%nrstr(&en_utvalg),
	summary =
   no :=%nrstr(&no_summary)
|| en :=%nrstr(&en_summary),
   discussion=
   no := %nrstr(&no_discussion)   
|| en := %nrstr(&en_discussion),
   tags=eldre oye, 
   min_age=50, max_age=105
);


/*FIGURER FOR ANALYSE/SKRIVING UNDER HER:*/

/*lage kopi av datasett med samme navn som variabel for å få figurmakroer til å funke ...*/
data injeksjon;
set injeksj_pas;
run;

%let tema=injeksjon;
%let bildesti =/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser/Figurer/injeksjon/injeksjon_pas;
/*Figurer og tabeller*/
%include "/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser/figurmakroer/panel_total.sas";
%panelfigur_tot(tema=injeksjon);


%include "/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser/figurmakroer/rate_alder_kjonn.sas";
%rate_alder_kjonn(aarmin=2015,aarmax=2023,aldermin=50,aldermax=105,kjonn=);

/*SLETTE ALLE DATASETT I WORK */
proc datasets nolist library=WORK kill;
   run; quit;




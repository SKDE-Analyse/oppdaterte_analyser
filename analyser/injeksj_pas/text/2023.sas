/*Injeksjon pasienter*/

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

\n\n
For å kunne sammenligne opptaksområdene og mellom år, er ratene kjønns- og aldersjustert. Justeringen er gjort ved direkte metode med landets befolkning i 2023 som referansepopulasjon.
\n\n
Fraskrivelse: SKDE er eneansvarlig for tolkning og presentasjon av de utleverte data fra NPR. FHI/NPR har ikke ansvar for analyser eller tolkninger basert på dataene.
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

\n\n
In order to compare the catchment areas and between years, the rates have been adjusted for gender and age. The adjustment was done using the direct method with the population in 2023 as the reference population.
\n\n
SKDE is solely responsible for the interpretation and presentation of the data provided by NPR. FHI/NPR is not responsible for analyses or interpretations based on the data.
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

%let no_title =
Injeksjonsbehandling (Antall pasienter, 50 år+)
;

%let en_title =
Injection treatment (Number of patients, 50 yrs+)
;

%let no_description =
Antall pasienter pr 1000 innbyggere, 50 år eller eldre
;

%let en_description =
Number of patients pr 1000 inhabitants, 50 years or older
;

/*NB! Ikke endre noe under her*/
%let no_utvalg = %superq(no_utvalg);
%let en_utvalg = %superq(en_utvalg);
%let no_summary = %superq(no_summary);
%let en_summary = %superq(en_summary);
%let no_discussion = %superq(no_discussion);
%let en_discussion = %superq(en_discussion);
%let no_title = %superq(no_title);
%let en_title = %superq(en_title);
%let no_description = %superq(no_description);
%let en_description = %superq(en_description);

%let settinn_txt =
   title=%nrstr(
   		no := &no_title. || en := &en_title.),
   description=%nrstr(
   		no := &no_description. || en := &en_description.),
   info =%nrstr(
   		no := &no_utvalg. || en := &en_utvalg.),
   summary=%nrstr(
   		no := &no_summary. || en := &en_summary.),
   discussion=%nrstr(
   		no := &no_discussion. || en := &en_discussion.),
;
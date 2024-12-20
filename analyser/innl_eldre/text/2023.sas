/*Fremfall (skjede/livmor)*/

%let no_utvalg=
Analysen er basert på aktivitetsdata fra Norsk pasientregister (NPR) for 
somatisk spesialisthelsetjeneste. Data inkluderer aktivitet i offentlige sykehus og 
private sykehus som leverer offentlig finansierte tjenester. 

\n\n
Utvalget består av innleggelser på sykehus for pasienter i alderen 75 år og eldre. 
For å unngå systematiske skjevheter grunnet funksjonsfordeling mellom sykehus er det tatt hensyn til overføringer mellom sykehus/helseforetak. 
Dersom innskrivelse til et sykehusopphold skjer mindre enn åtte timer etter utskrivelse fra et tidligere sykehusopphold er de to sykehusoppholdene slått sammen og talt eom ett opphold.

\n\n Hvor pasienten er behandlet er delt inn i tre kategorier:
\n - Eget HF, behandlet ved et av sykehusene i opptaksområdet
\n - Annet HF, behandlet ved et sykehus utenfor opptaksområdet
\n - Privat, behandlet ved et privat sykehus 

For å kunne sammenligne opptaksområdene og mellom år, er ratene kjønns- og aldersjustert. Justeringen er gjort ved direkte metode med landets befolkning i 2023 som referansepopulasjon.
SKDE er eneansvarlig for tolkning og presentasjon av de utleverte data fra NPR. FHI/NPR har ikke ansvar for analyser eller tolkninger basert på dataene.

;

%let en_utvalg=
The analysis is based on activity data from the Norwegian Patient Register (NPR) for somatic specialist health services. 
The data includes activity in public hospitals and private hospitals that provide publicly funded services. 


\n\n
The sample consists of inpatient contacts for patients aged 75 years or older.
To avoid systematic bias resulting from routine transfers between hospitals, transfers have been taken into account.
If the admission for one hospital stay occurs less than eight hours after the discharge from a previoys stay, the two hospital stays have been combined and counted as one.

\n\n The place of treatment is divided into three categories:
\n - Local public, treated at one of the hospitals in the catchment area
\n - Other public, treated at a public hospital outside the catchment area
\n - Private, treated by a private hospital

In order to compare the catchment areas and between years, the rates have been adjusted for gender and age. 
The adjustment was done using the direct method with the countrys population in 2023 as the reference population.
SKDE is solely responsible for the interpretation and presentation of the data provided by NPR. 
FHI/NPR is not responsible for analyses or interpretations based on the data.
;

%let no_summary = 
- Det er betydelig geografisk variasjon i bruk av innleggelser for pasienter 75 år og eldre
\n - Mellom 2015 og 2023 økte antall innleggelser med 20 %
\n - En økende andel av innleggelsene er akutte
;

%let en_summary = 
- There is significant geographical variation in the use of admissions for patients 75 years or older
\n - Between 2015 and 2023 the number of admissions increased by 20 %
\n - An increasing share of admissions are acute
;

%let no_discussion = 
Nasjonalt økte antall innleggelser for pasienter 75 år og eldre fra 181 754 i 2015 til 217 966 i 2023, en økning på 20 %. Økningen i antall innleggelser skyldes økende antall eldre.
Det er hovedsakelig antall akuttinnleggelser som har økt, men akuttinnleggelsesraten har vært forholdsvis uendret gjennom hele perioden med unntak av en liten reduksjon i 2020.
Antallet planlagte innleggelser har vært forholdsvis stabilt, med unntak av en reduksjon i 2020. Raten for planlagte innleggelser var imidlertid markant lavere i perioden 2021-2023 sammenliknet med perioden 2015-2019.
Innleggelsesraten totalt sett har også vært noe lavere i perioden 2021-2023 enn i perioden 2015-2019. \n
Samlet sett viser disse resultatene at det brukes stadig mer ressurser på innleggelser for eldre og at en stadig økende andel av disse ressursene brukes på akuttinnleggelser.
Sett i sammenheng kan et økende antall innleggelser kombinert med noe redusert innleggelsesrate og en økt andel akuttinnleggelser, være et tegn på at kapasiteten i sykehusene er under press.
\n\n
Det var betydelig geografisk variasjon i bruk av innleggelser for pasienter 75 år og eldre gjennom hele perioden 2015-2023. 
Opptaksområdet med høyest rate hadde bare 30 % høyere innleggelsesrate enn opptaksområdet med lavest rate, men årlig antall innleggelser er så høyt at selv små forskjeller kan gi konsekvenser av betydning. 
Differansen mellom opptaksområdet med den høyeste og den laveste raten er på mer enn 100 innleggelser pr. 1000 innbyggere, noe som tilsvarer en vesentlig høyere ressursbruk. 
\n\n
Opptaksområdene Finnmark, Bergen og Lovisenberg har hatt høye rater gjennom hele perioden fra 2015-2023, mens opptaksområdet Sørlandet har hatt en lav rate i hele perioden.
Dette tyder på vedvarende og strukturelt betingede forskjeller i ressursbruk. At opptaksområdet Finnmark har hatt en høy rate over år skyldes i stor grad høy bruk av planagte innleggelser sammenliknet med resten av landet.
Andelen akuttinnleggelser for bosatte i Finnmark er dermed også lav i hele perioden. For øvrig er det forholdsvis lite variasjon i andel akuttinnleggelser.
\n\n
Også gjennomsnittlig antall liggedøgn pr. sykehusopphold varierer betydelig mellom opptaksområdene, i 2023 varierte liggetid pr. opphold fra 5,98 i opptaksområdet UNN til 3,9 i opptaksområdene Vestfold og Sørlandet.
Nasjonalt har liggetid pr. opphold gått ned fra 5,4 i 2015 til 4,7 i 2023. Opptaksområdene UNN, OUS og St. Olav har hatt høy liggetid pr. opphold gjennom hele perioden, 
mens opptaksområdene Vestfold, Sørlandet og Diakonhjemmet har hatt lav liggetid pr. opphold gjennom hele perioden.
;

%let en_discussion = 
Nationally, the number of hospital admissions for patients aged 75 and older increased from 181 754 in 2015 to 217 966 in 2023, a 20 % increase. The rise in admissions is due to the growing number of elderly people.
It is mainly the number of emergency admissions that has increased, but the emergency admission rate has remained relatively unchanged throughout the period, except for a slight reduction in 2020.
The number of planned admissions has been relatively stable, except for a reduction in 2020. However, the rate of planned admissions was significantly lower in the period 2021-2023 compared to the period 2015-2019.
Overall, the admission rate has also been somewhat lower in the period 2021-2023 than in the period 2015-2019.\n
These results indicate that more and more resources are being used for admissions for the elderly, and an increasing proportion of these resources are being used for emergency admissions.
An increasing number of admissions combined with a somewhat reduced admission rate and an increased proportion of emergency admissions may be a sign that hospital capacity is under pressure.
\n\n
There was significant geographical variation in the use of admissions for patients aged 75 and older throughout the period 2015-2023.
The catchment area with the highest rate had only 30% higher admission rate than the catchment area with the lowest rate, but the annual number of admissions is so high that even small differences can have significant consequences.
The difference between the catchment area with the highest and the lowest rate is more than 100 admissions per 1 000 inhabitants, which corresponds to significantly higher resource use.
\n\n
The catchment areas of Finnmark, Bergen, and Lovisenberg have had high rates throughout the period from 2015-2023, while the catchment area of Sørlandet has had a low rate throughout the period.
This indicates persistent and structurally conditioned differences in resource use. The fact that the catchment area of Finnmark has had a high rate over the years is largely due to high use of planned admissions compared to the rest of the country.
The proportion of emergency admissions for residents in Finnmark is therefore also low throughout the period. Otherwise, there is relatively little variation in the proportion of emergency admissions.
\n\n
The average number of hospital days per stay also varies significantly between catchment areas. In 2023, the length of stay per admission varied from 5.98 in the catchment area of UNN to 3.9 in the catchment areas of Vestfold and Sørlandet.
Nationally, the length of stay per admission has decreased from 5.4 in 2015 to 4.7 in 2023. The catchment areas of UNN, OUS, and St. Olav have had high lengths of stay per admission throughout the period, 
while the catchment areas of Vestfold, Sørlandet, and Diakonhjemmet have had low lengths of stay per admission throughout the period.
;

%let no_title =
Innleggelser for pasienter 75 år og eldre
;

%let en_title =
Admissions for patients aged 75 years or older
;

%let no_description =
Antall innleggelser pr. 1 000 innbyggere 75 år og eldre
;

%let en_description =
Number of admissions per 1 000 population 75 years or older
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
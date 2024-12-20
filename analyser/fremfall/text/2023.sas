/*Fremfall (skjede/livmor)*/

%let no_utvalg=
Analysen er basert på aktivitetsdata fra Norsk pasientregister (NPR) for 
somatisk spesialisthelsetjeneste. Data inkluderer aktivitet i offentlige sykehus og 
private sykehus som leverer offentlig finansierte tjenester. 
Data fra avtalespesialister er ikke inkludert, fordi denne behandlingen kun gis på sykehus. 

\n\n
Utvalget består av kontakter for kvinner i alderen 16 år eller eldre med hoved- eller bidiagnose N81 i kombinasjon med en eller flere av følgende prosedyrekoder:
LEF 00, LEF 03, LEF 10, LEF 13, LEF 16, LEF 20, LEF 23, LEF 34, LEF 40, LEF 41, LEF 50, LEF 51, LEF 53, LEF 96 eller LEF 97.
Se også [Metodebok.no](https://metodebok.no/index.php?action=topic&item=tE5VKGaZ)

\n\n Hvor pasienten er behandlet er delt inn i tre kategorier:
\n - Eget HF, behandlet ved et av sykehusene i opptaksområdet
\n - Annet HF, behandlet ved et sykehus utenfor opptaksområdet
\n - Privat, behandlet ved et privat sykehus 

\n\n
For å kunne sammenligne opptaksområdene og mellom år, er ratene kjønns- og aldersjustert. Justeringen er gjort ved direkte metode med landets befolkning i 2023 som referansepopulasjon.
\n\n
SKDE er eneansvarlig for tolkning og presentasjon av de utleverte data fra NPR. FHI/NPR har ikke ansvar for analyser eller tolkninger basert på dataene.

;

%let en_utvalg=
The analysis is based on activity data from the Norwegian Patient Register (NPR) for somatic specialist health services. 
The data includes activity in public hospitals and private hospitals that provide publicly funded services. 
Data from specialists under public funding contracts are not included, as this treatment is only provided in hospitals.

\n\n
The sample consists of contact for women aged 16 years or older with a primary or secondary diagnosis of N81 in combination with one or more of the following procedure codes:
LEF 00, LEF 03, LEF 10, LEF 13, LEF 16, LEF 20, LEF 23, LEF 34, LEF 40, LEF 41, LEF 50, LEF 51, LEF 53, LEF 96 eller LEF 97.

\n\n The place of treatment is divided into three categories:
\n - Local public, treated at one of the hospitals in the catchment area
\n - Other public, treated at a public hospital outside the catchment area
\n - Private, treated by a private hospital

\n\n
In order to compare the catchment areas and between years, the rates have been adjusted for gender and age. 
The adjustment was done using the direct method with the countrys population in 2023 as the reference population.
\n\n
SKDE is solely responsible for the interpretation and presentation of the data provided by NPR. 
FHI/NPR is not responsible for analyses or interpretations based on the data.
;

%let no_summary = 
- Det er stor geografisk variasjon i bruk av kirurgi for skjede- og livmorfremfall
\n - Variasjonen har endret seg lite i perioden 2015-2023
\n - Årlig antall inngrep har vært noe lavere etter pandemien enn i perioden 2015-2019
;

%let en_summary = 
- There is significant geographical variation in the use of surgery for female genital prolapse
\n - The variation has changed little in the period 2015-2023.
\n - The annual number of procedures has been somewhat lower after 2020 than in the period 2015-2019.
;

%let no_discussion = 
I perioden 2015-2019 lå antall inngrep stabilt på i overkant av 4000 pr år. I 2020 ble antall inngrep redusert med omlag 20 % relativt til perioden 2015-2019.
Etter pandemien har årlig antall inngrep økt for hvert år og i 2023 ble det utført ca 3700 inngrep.
Median alder for pasientene var 64 år i 2023 og 63 år i perioden 2015-2022.
\n \n
Den geografiske variasjonen har vært stor gjennom hele perioden fra 2015 til 2023. 
Variasjonen har vært noe større i perioden etter pandemien (2021-2023) enn i perioden før pandemien (2015-2019).
Opptaksområdene OUS, Diakonhjemmet, Lovisenberg, Akershus og Vestfold har hatt lave rater gjennom hele perioden fra 2015 til 2023.
Opptaksområdet Finnmark har hatt den høyeste raten gjennom hele perioden 2015-2023, med unntak av pandemiåret 2020.
Også Helgeland, Fonna og Nord-Trøndelag har hatt høye rater gjennom hele perioden 2015-2023.
\n \n
I hovedsak behandles pasientene i eget HF, og omfanget av behandling hos private er svært begrenset.
\n \n
På landsbasis har andelen inngrep som gjøres dagkirurgisk økt fra 24 % i 2015 til 40,5 % i 2023. Det er stor variasjon mellom opptaksområdene.
I opptaksområdene Finnmark, OUS, Sørlandet og Lovisenberg ble under 10 % av operasjonene gjort dagkirurgisk i 2023, 
mens i opptaksområdet St. Olav var tilsvarende andel 84 %.
;

%let en_discussion = 
During the period 2015-2019, the number of procedures remained stable at just over 4,000 per year. 
In 2020, the number of procedures decreased by approximately 20% compared to the period 2015-2019. 
After the pandemic, the annual number of procedures has increased each year, and in 2023, around 3,700 procedures were performed. 
The median age was 64 years in 2023 and 63 years for the perioden 2015-2022.
\n \n
The geographical variation has been significant throughout the period from 2015 to 2023. 
The variation has been somewhat greater in the period after the pandemic (2021-2023) than in the period before the pandemic (2015-2019). 
The catchment areas of OUS, Diakonhjemmet, Lovisenberg, Akershus, and Vestfold have had low rates throughout the period from 2015 to 2023. 
The catchment area of Finnmark has had the highest rate throughout the period 2015-2023, except for the pandemic year 2020. 
Helgeland, Fonna, and Nord-Trøndelag have also had high rates throughout the period 2015-2023. 
\n \n
The extent of treatment in private facilities is very limited.
\n \n
Nationally, the proportion of procedures performed as day surgery increased from 24% in 2015 to 40.5% in 2023. There is significant variation between the catchment areas. 
In the catchment areas of Finnmark, OUS, Sørlandet, and Lovisenberg, less than 10% of operations were performed as day surgery in 2023, 
while in the catchment area of St. Olav, the corresponding proportion was 84%.
;

%let no_title =
Kirurgiske inngrep for skjede- og livmorfremfall
;

%let en_title =
Surgical procedures for female genital prolapse
;

%let no_description =
Antall inngrep pr 1 000 kvinner
;

%let en_description =
Number of procedures per 1 000 women
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
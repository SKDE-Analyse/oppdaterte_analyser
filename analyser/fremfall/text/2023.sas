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
;

%let no_summary = 
- Det er stor grografisk variasjon i bruk av kirurgi for skjede- og livmorfremfall
\n - Variasjonen har endret seg lite i perioden 2015-2023
\n - Årlig antall inngrep har vært noe lavere etter 2020 enn i perioden 2015-2019
;

%let en_summary = 
- There is significant geographical variation in the use of surgery for female genital prolapse
\n - The variation has changed little in the period 2015-2023.
\n - The annual number of procedures has been somewhat lower after 2020 than in the period 2015-2019.
;

%let no_discussion = 
I perioden 2015-2019 lå antall inngrep stabilt på i overkant av 4000 pr år. I 2020 ble antall inngrep redusert med omlag 20 % relativt til perioden 2015-2019.
Etter pandemien har årlig antall inngrep økt for hvert år og i 2023 ble det utført ca 3700 inngrep.
\n \n
Den geografiske variasjonen har vært stor gjennom hele perioden fra 2015 til 2023. 
Variasjonen har vært noe større i perioden etter pandemien (2021-2023) enn i perioden før pandemien (2015-2019).
Opptaksområdene OUS, Diakonhjemmet, Lovisenberg, Akershus og Vestfold har hatt lave rater gjennom hele perioden fra 2015 til 2023.
Opptaksområdet Finnmark har hatt den høyeste raten gjennom hele perioden 2015-2023, med unntak av pandemiåret 2020.
Også Helgeland, Fonna og Nord-Trøndelag har hatt høye rater gjennom hele perioden 2015-2023.
\n \n
Omfanget av behandling hos private er svært begrenset.
;

%let en_discussion = 
During the period 2015-2019, the number of procedures remained stable at just over 4,000 per year. 
In 2020, the number of procedures decreased by approximately 20% compared to the period 2015-2019. 
After the pandemic, the annual number of procedures has increased each year, and in 2023, around 3,700 procedures were performed. 
\n \n
The geographical variation has been significant throughout the period from 2015 to 2023. 
The variation has been somewhat greater in the period after the pandemic (2021-2023) than in the period before the pandemic (2015-2019). 
The catchment areas of OUS, Diakonhjemmet, Lovisenberg, Akershus, and Vestfold have had low rates throughout the period from 2015 to 2023. 
The catchment area of Finnmark has had the highest rate throughout the period 2015-2023, except for the pandemic year 2020. 
Helgeland, Fonna, and Nord-Trøndelag have also had high rates throughout the period 2015-2023. 
\n \n
The extent of treatment in private facilities is very limited.
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
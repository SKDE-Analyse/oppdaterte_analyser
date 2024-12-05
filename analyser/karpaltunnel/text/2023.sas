/*Karpaltunnel*/

%let no_utvalg=
Analysen er basert på aktivitetsdata fra Norsk pasientregister (NPR) for 
somatisk spesialisthelsetjeneste. Data inkluderer aktivitet i offentlige sykehus, 
private sykehus som leverer offentlig finansierte tjenester og avtalespesialister
som har avtale om offentlig finansiering.
\n\n

Utvalget omfatter pasienter 17 år og eldre registrert med hoved- eller bidiagnose 
G56.0 i kombinasjon med:
\n - For sykehusene - prosedyrekode ACC51, NDE11, NDE12, NDM19, NDM49 eller NDL50 
\n - For avtalespesialistene - tilsvarende prosedyrekoder som for sykehusene ELLER takstkode 140i

\n\n Hvor pasienten er behandlet er delt inn i tre kategorier:
\n - Eget HF, behandlet ved et av sykehusene i opptaksområdet
\n - Annet HF, behandlet ved et sykehus utenfor opptaksområdet
\n - Privat, behandlet ved et privat sykehus eller hos avtalespesialist 

\n\n Operasjoner av karpaltunnelsyndrom utføres i hovedsak på voksne pasienter, derfor er 
populasjonen avgrenset til personer 17 år og eldre. 
Når det gjelder barn (0-16 år) utføres det i gjennomsnitt kun 3 operasjoner pr år. 
\n\n
For å kunne sammenligne opptaksområdene og mellom år, er ratene kjønns- og aldersjustert. 
Justeringen er gjort ved direkte metode med landets befolkning i 2023 som referansepopulasjon. 
\n\n
SKDE er eneansvarlig for tolkning og presentasjon av de utleverte data fra NPR. 
FHI/NPR har ikke ansvar for analyser eller tolkninger basert på dataene. 
;

%let en_utvalg=
The analysis is based on data from the Norwegian Patient Registry (NPR) for  
specialist healthcare services. The data includes activity in public hospitals, publicly funded 
private hospitals, and specialists in private practice under public funding contacts.

\n\n The sample consists of patients aged 17 years or older registered with a primary 
or secondary diagnosis of G56.0 
in combination with: 
\n - For hospitals - procedure codes ACC51, NDE11, NDE12, NDM19, NDM49, or NDL50
\n - For contracted specialists - the same procedure codes as for hospitals OR tariff code 140i

\n\n The place of treatment is divided into three categories:
\n - Local public, treated at one of the hospitals in the catchment area
\n - Other public, treated at a public hospital outside the catchment area
\n - Private, treated by a private hospital or a private specialist

\n\n Surgeries for carpal tunnel syndrome are mainly performed on adults.
On average, only 3 surgeries per year are performed on children under the age of 17.

\n\n
In order to compare the catchment areas and between years, the rates have been adjusted for gender and age. 
The adjustment was done using the direct method with the population in 2023 as the reference population.

\n\n
SKDE is solely responsible for the interpretation and presentation of the data provided by NPR. 
FHI/NPR is not responsible for analyses or interpretations based on the data.
;

%let no_summary = 
- I perioden 2015-2023 ble det gjennomført 7 000 til 8 000 operasjoner pr år
\n - Det er stor geografisk variasjon i raten mellom opptaksområdene, variasjonen vurderes som uberettiget
\n - I opptaksområdene UNN og Førde HF har ratene økt kraftig de siste tre årene. 
;

%let en_summary = 
- In the period 2015–2023, 7,000 to 8,000 operations were performed annually
\n - There is significant geographic variation in the rates between catchment areas, and the variation is considered unwarranted
\n - In the catchment areas of UNN and Førde HF, the rates have increased sharply over the past three years
;

%let no_discussion = 
Det utføres i gjennomsnitt omlag 7 400 operasjoner av karpaltunnelsyndrom pr år. 
Årlig antall operasjoner ble i liten grad påvirket av pandemien. Det var en liten nedgang for kvinner i 2020, og toppår for 
begge kjønn i 2021, målt i forhold til de andre årene i perioden 2015-2023.
\n\n 
Det er betydelig geografisk variasjon i operasjonsratene. I opptaksområdene med høyest rate 
utføres det om lag tre ganger så mange operasjoner pr 1 000 innbygger sammenliknet med opptaksområdene som utfører færrest operasjoner. 
I 2023 varierte antall operasjoner pr 1 000 innbyggerer fra 0,9 for Lovisenberg til 2,7 for Nordland. 
\n\n
Oslo-området (OUS, Lovisenberg og Diakonhjemmet HF) har gjennomgående de laveste ratene i hele perioden. Innlandet og Østfold HF har de 
høyeste ratene i perioden. Den lave raten i Østfold Hf i 2023 skyldes sannsynligvis manglende innrapportering fra avtalespesialister.
I opptaksområdene UNN og Førde HF har ratene økt kraftig de siste tre årene. 
\n\n 
Kvinner opereres i større grad enn menn, og andelen operasjoner utført på kvinner var 61 % i 2023. 
\n\n
;

%let en_discussion = 
An average of approximately 7,400 operations for carpal tunnel syndrome are performed annually.
The annual number of operations was minimally affected by the pandemic. 
There was a slight decrease for women in 2020, and 2021 was a peak year for both sexes 
compared to the other years in the period 2015–2023.
\n\n
There is significant geographic variation in operation rates. In the catchment areas with the highest rates, 
approximately three times as many operations per 1,000 inhabitants are performed compared to the areas with the lowest rates.
In 2023, the number of operations per 1,000 inhabitants ranged from 0.9 in Lovisenberg to 2.7 in Nordland.
\n\n
The Oslo area (OUS, Lovisenberg, and Diakonhjemmet HF) consistently has the lowest rates throughout the period. 
Innlandet and Østfold HF have had the highest rates during the period.
The low rate in Østfold HF in 2023 is likely due to incomplete reporting from private specialists.
In the catchment areas of UNN and Førde HF, rates have risen sharply over the past three years.
\n\n
Women undergo surgery more often than men, and the proportion of surgeries performed on women was 61 % in 2023.

;

%let no_title =
Operasjoner for karpaltunnelsyndrom
;

%let en_title =
Surgeries for carpal tunnel syndrome
;

%let no_description =
Antall operasjoner for karpaltunnelsyndrom pr 1 000 innbyggere
;

%let en_description =
Number of surgeries for carpal tunnel syndrome per 1,000 inhabitants
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
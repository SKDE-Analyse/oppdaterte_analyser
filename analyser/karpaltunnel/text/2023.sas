/*Karpaltunnel*/

%let no_utvalg=
Analysen er basert på aktivitetsdata fra Norsk pasientregister (NPR) for 
somatisk spesialisthelsetjeneste. Data inkluderer aktivitet i offentlige sykehus, 
private sykehus som leverer offentlig finansierte tjenester og avtalespesialister
som har avtale om offentlig finansiering.
\n\n

Utvalget omfatter pasienter registrert med hoved- eller bidiagnose 
G56.0 i kombinasjon med:
\n - prosedyrekode ACC51, NDE11, NDE12, NDM19, NDM49 eller NDL50 på sykehus eller 
\n - tilsvarende prosedyrekoder eller takstkode 140i hos avtalespesialist

\n\n Hvor pasienten er behandlet er delt inn i tre kategorier:
\n - Eget HF, behandlet ved et av sykehusene i opptaksområdet
\n - Annet HF, behandlet ved et sykehus utenfor opptaksområdet
\n - Privat, behandlet ved et privat sykehus eller hos avtalespesialist 

\n\n Operasjoner av karpaltunnelsyndrom utføres i hovedsak på voksne pasienter. 
Når det gjelder barn (0-15 år) utføres det i gjennomsnitt kun 2 operasjoner pr år. 
Ratene er kjønns- og aldersjustert basert på hele befolkningen. 
;

%let en_utvalg=
The analysis is based on data from the Norwegian Patient Registry (NPR) for  
specialist healthcare services. The data includes activity in public hospitals, publicly funded 
private hospitals, and specialists in private practice under public funding contacts.

\n\n The sample consists of patients aged 16 years or older registered with a primary 
or secondary diagnosis of G56.0 
in combination with: 
\n - procedure code ACC51, NDE11, NDE12, NDM19, NDM49 or NDL50 in hospitals or 
\n - the same procedure code or fee code 140i with a specialist 

\n\n The place of treatment is divided into three categories:
\n - Local public, treated at one of the hospitals in the catchment area
\n - Other public, treated at a public hospital outside the catchment area
\n - Private, treated by a private hospital or a private specialist

\n\n Surgeries for carpal tunnel syndrome are mainly performed on adults.
On average, only 2 surgeries per year are performed on children under the age of 16.
The rates are gender- and age-adjusted based on the entire Norwegian population.
;

%let no_summary = 
- I perioden 2015-2023 ble gjennonført 7 000 til 8 000 operasjoner pr 1 000 innbyggere pr år
\n - Det er stor geografisk variasjon i raten mellom opptaksområdene, variasjonen vurderes som uberettiget
\n - I opptaksområdene UNN og Førde HF har ratene økt kraftig de siste tre årene. 
;

%let en_summary = 
- The annual national rate ranged from 1.4 to 1.5 operations per 1,000 throughout the period 2015-2023.
\n - There is significant geographic variation in the rate, ranging from 0.7 to 2.2 per 1,000 in 2023.
\n - Helse Nord had the lowest rate in 2015/2016. In the years following the pandemic, Helse Nord RHF has had the highest rate.
;

%let no_discussion = 
Det utføres i underkant av 7 500 operasjoner for karpaltunnelsyndrom pr år. 
Antall operasjoner pr år ble i liten grad påvirket av pandemien. Det var en liten nedgang for kvinner i 2020, og toppår for 
begge kjønn i 2021, målt i forhold til de andre årene i perioden 2015-2023.
\n\n 
Det er betydelig geografisk variasjon i operasjonsratene. I opptaksområdene med høyest rate 
utføres det om lag tre ganger så mange operasjoner pr 1 000 innbygger sammenliknet med opptaksområdene som utfører færrest operasjoner. 
I 2023 varierte antall operasjoner pr 1 000 innbyggerer fra 0,7 for Lovisenberg til 2,2 for Nordland. 
Oslo-området (OUS, Lovisenberg og Diakonhjemmet HF) har gjennomgående de laveste ratene i hele perioden. Innlandet og Østfold HF har de 
høyeste ratene i perioden. Den lave raten i Østfold Hf i 2023 skyldes sannsynligvis manglende innrapportering fra avtalespesialister.
I opptaksområdene UNN og Førde HF har ratene økt kraftig de siste tre årene. 
\n\n 
Kvinner opereres i større grad enn menn, og andelen operasjoner utført på kvinner var 61 % i 2023. 
\n\n

;

%let en_discussion = 
Approximately 7,500 surgeries for carpal tunnel syndrome are performed annually. 
The number of surgeries per year was only slightly affected by the pandemic. 
There was a small decrease for women in 2020, and 2021 was the peak year for both genders compared to other years in the 2015-2023 period.
\n\n
There is significant geographic variation in surgery rates, 
with the areas with the highest rates performing about three times as many surgeries per 1,000 inhabitants
 compared to the areas with the lowest rates.
\n\n
Women undergo surgery more often than men, and the proportion of surgeries performed on women was 61 % in 2023.

;

%let no_title =
Operasjon for karpaltunnelsyndrom
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
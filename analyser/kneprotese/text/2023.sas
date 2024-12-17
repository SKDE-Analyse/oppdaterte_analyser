/*Kneprotese*/

%let no_utvalg=
Analysen er basert på aktivitetsdata fra Norsk pasientregister (NPR) for 
somatisk spesialisthelsetjeneste. Data inkluderer aktivitet i offentlige sykehus og 
private sykehus som leverer offentlig finansierte tjenester.
\n\n

Utvalget omfatter kontakter registrert med en eller flere av følgende 6 prosedyrekoder:
\n - Delproteser - NGB0, NGB1
\n - Helproteser - NGB20, NGB30, NGB40, NGB99 


\n\n Hvor pasienten er behandlet er delt inn i tre kategorier:
\n - Eget HF, behandlet ved et av sykehusene i opptaksområdet
\n - Annet HF, behandlet ved et sykehus utenfor opptaksområdet
\n - Privat, behandlet ved et privat sykehus 

\n\n Innsetting av kneproteser utføres i hovedsak på voksne pasienter. 
Populasjonen omfatter derfor kun pasienter som er 50 år og eldre. 
Det ble i 2023 utført 201 operasjoner på pasienter under 50 år,
 av disse var 179 pasienter mellom 40 og 49 år.
\n\n
For å kunne sammenligne opptaksområdene og mellom år, er ratene kjønns- og aldersjustert. 
Justeringen er gjort ved direkte metode med landets befolkning i 2023 som referansepopulasjon. 
\n\n
SKDE er eneansvarlig for tolkning og presentasjon av de utleverte data fra NPR. 
FHI/NPR har ikke ansvar for analyser eller tolkninger basert på dataene. 
;

%let en_utvalg=
The analysis is based on activity data from the Norwegian Patient Register (NPR) for somatic specialist healthcare services. 
The data includes activities in public hospitals and private hospitals providing publicly funded services.

The selection includes patients registered with one or more of the following six procedure codes:
\n - Partial prostheses - NGB0, NGB1
\n - Total prostheses - NGB20, NGB30, NGB40, NGB99

\n\n Where the patient was treated is divided into three categories:
\n - Own health trust (HF), treated at one of the hospitals within the catchment area
\n - Other health trust (HF), treated at a hospital outside the catchment area
\n - Private, treated at a private hospital

\n\n Knee prosthesis implantation is primarily performed on adult patients.
The population therefore includes only patients aged 50 years and older.
In 2023, 201 operations were performed on patients under the age of 50,
of which 179 patients were between 40 and 49 years old.
\n\n 
In order to compare the catchment areas and between years, the rates have been adjusted for gender and age. 
The adjustment was done using the direct method with the countrys population in 2023 as the reference population.
\n\n 
SKDE is solely responsible for the interpretation and presentation of the data provided by NPR. 
FHI/NPR is not responsible for analyses or interpretations based on the data.
;

%let no_summary = 
- Antall operasjoner knyttet til innsetting av kneproteser økte med 39 % i perioden 2015-2023
\n - Antall operasjoner per 1 000 innbygger hadde en økning på 14 % i samme periode, fra 3,5 til 4,0
\n - Samlet rate, og forholdet mellom hel- og delproteser varierer en del mellom de ulike opptaksområdene
;

%let en_summary = 
- The number of operations involving knee prosthesis implantation increased by 39 % during the period 2015-2023
\n - The number of operations per 1,000 inhabitants rose by 14 % over the same period, from 3.5 to 4.0
\n - The overall rate and the ratio between total and partial prostheses vary significantly across the different catchment areas
;

%let no_discussion = 
For pasienter 50 år og eldre ble det satt inn 5 857 kneproteser i 2015 økende til 8 154 i 2023. Dette tilsvarer en økning på 39 %.
Det var en liten nedgang i antallet operasjoner i pandemiåret 2020. Etter pandemien er nivået høyere enn før pandemien. 
Andel delkneproteser har hatt en tydelig økning i perioden fra 12 % i 2015 til  til 16 % i 2023.
\n\n 
Det er geografisk variasjon i operasjonsratene. I opptaksområdene med høyest rate 
utføres det mer enn dobbelt så mange operasjoner pr 1 000 innbygger sammenliknet med opptaksområdene som utfører færrest operasjoner. 
I 2023 varierte raten fra 2,1 for opptaksområdet knyttet til Lovisenberg HF til 4,8 for Førde. Forholdet mellom hel- og delproteser
 variere mye mellom de ulike opptaksområdene. I 2023 varierte andelen som fikk innsatt delprotese fra under 5 % i for Helgeland og Sørlandet
  til 32 % for Diakonhjemmet og St. Olav.
\n\n 
Kvinner opereres i større grad enn menn, og andelen operasjoner utført på kvinner var 57 % i 2023. Gjennomsnittsalderen 
var omtrent lik for begge kjønn i 2023 og lå rett under 70 år. 
\n\n
;

%let en_discussion = 
For patients aged 50 and older, 5,857 knee prostheses were implanted in 2015, increasing to 8,154 in 2023. 
This corresponds to a 39 % increase.
There was a slight decline in the number of operations during the pandemic year 2020. Following the pandemic, 
the level is higher than it was pre-pandemic.
The proportion of partial knee prostheses has shown a clear increase over the period, from 12 % in 2015 to 16 % in 2023.
\n\n
There is geographic variation in operation rates. In the catchment areas with the highest rates, 
more than twice as many operations per 1,000 inhabitants are performed compared to the areas with the lowest rates.
In 2023, the rates ranged from 2.1 in the Lovisenberg HF catchment area to 4.8 in Førde.
The ratio between total and partial prostheses also varies significantly across the different catchment areas.
In 2023, the proportion of patients receiving partial prostheses ranged from less than 5 % in Helgeland and Sørlandet 
to 32 % at Diakonhjemmet and St. Olav.
\n\n
Women are operated on more frequently than men, with women accounting for 57 % of operations in 2023.
The average age was approximately the same for both genders in 2023, just under 70 years.
\n\n
;

%let no_title =
Innsetting av primære kneproteser
;

%let en_title =
Insertions of primary knee prostheses
;

%let no_description =
Antall innsettinger av primære kneproteser pr 1 000 innbyggere
;

%let en_description =
Number of insertions of primary knee prostheses per 1,000 inhabitants
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
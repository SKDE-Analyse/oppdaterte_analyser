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
- Antall operasjoner knyttet til innsetting av kneproteser har økt med 39 % perioden 2015-2023
\n - Antall operasjoner per 1 000 innbygger hadde en økning på 14 % fra 3,5 til 4,0 i samme periode
\n - Raten varierer en del mellom de ulike opptaksområdene
;

%let en_summary = 
- Antall operasjoner knyttet til innsetting av kneproteser har økt med 39 % perioden 2015-2023
\n - Antall operasjoner per 1 000 innbygger hadde en økning på 14 % fra 3,5 til 4,0 i samme periode
\n - Raten varierer en del mellom de ulike opptaksområdene, det samme gjorde andelen som fikk insatt delprotese
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
For pasienter 50 år og eldre ble det satt inn 5 857 kneproteser i 2015 økende til 8 154 i 2023. En økning på 39 %.
Det var en liten nedgang i antallet i pandemiåret 2020. Etter pandemien er nivået høyere enn før pandemien.
\n\n 
Det er geografisk variasjon i operasjonsratene. I opptaksområdene med høyest rate 
utføres det mer enn dobbelt så mange operasjoner pr 1 000 innbygger sammenliknet med opptaksområdene som utfører færrest operasjoner. 
I 2023 varierte raten fra 2,1 for opptaksområdet knyttet til Lovisenberg HF,  økende til 4,8 for Førde. 
\n\n 
Kvinner opereres i større grad enn menn, og andelen operasjoner utført på kvinner var 57 % i 2023. 
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
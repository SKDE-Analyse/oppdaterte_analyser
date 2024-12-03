/*Hofteprotese*/

%let no_utvalg=
Analysen er basert på aktivitetsdata fra Norsk pasientregister (NPR) for 
somatisk spesialisthelsetjeneste. Data inkluderer aktivitet i offentlige sykehus og 
private sykehus som leverer offentlig finansierte tjenester.
\n\n

Utvalget omfatter kontakter registrert med en eller flere av prosedyrekodene 
\n - Delproteser: NGB0 og NGB1
\n - Helproteser: NGB20, NGB30, NGB40 eller NGB99 


\n\n Hvor pasienten er behandlet er delt inn i tre kategorier:
\n - Eget HF, behandlet ved et av sykehusene i opptaksområdet
\n - Annet HF, behandlet ved et sykehus utenfor opptaksområdet
\n - Privat, behandlet ved et privat sykehus 

\n\n Innsetting av kneproteser utføres i hovedsak på voksne pasienter. 
Populasjonen omfatter derfor kun pasienter som er 50 år og eldre.
Ratene er kjønns- og aldersjusterte. 
;

%let en_utvalg=
Analysen er basert på aktivitetsdata fra Norsk pasientregister (NPR) for 
somatisk spesialisthelsetjeneste. Data inkluderer aktivitet i offentlige sykehus og 
private sykehus som leverer offentlig finansierte tjenester.

Utvalget omfatter kontakter registrert med en eller flere av prosedyrekodene 
\n - Delproteser: NGB0 og NGB1
\n - Helproteser: NGB20, NGB30, NGB40 og NGB99 

\n\n The place of treatment is divided into three categories:
\n - Local public, treated at one of the hospitals in the catchment area
\n - Other public, treated at a public hospital outside the catchment area
\n - Private, treated by a private hospital or a private specialist

\n\n Innsetting av kneproteser utføres i hovedsak på voksne pasienter. 
Populasjonen omfatter derfor pasienter som er 18 år og eldre.
Ratene er kjønns- og aldersjusterte.
;

%let no_summary = 
- Antall operasjoner knyttet til innsetting av kneproteser har økt med 39 % perioden 2015-2023
\n - Antall operasjoner per 1 000 innbygger hadde en økning på 14 % fra 3,5 til 4,0 i samme periode
\n - Raten varierer en del mellom de ulike opptaksområdene
;

%let en_summary = 
- Antall operasjoner knyttet til innsetting av kneproteser har økt med 39 % perioden 2015-2023
\n - Antall operasjoner per 1 000 innbygger hadde en økning på 14 % fra 3,5 til 4,0 i samme periode
\n - Raten varierer en del mellom de ulike opptaksområdene
;

%let no_discussion = 
For pasienter 50 år og eldre ble det satt inn 5 857 kneproteser i 2015 økende til 8 154 i 2023. Dette tilsvarer en økning på 39 %.
Det var en liten nedgang i antallet operasjoner i pandemiåret 2020. Etter pandemien er nivået høyere enn før pandemien.
\n\n 
Det er geografisk variasjon i operasjonsratene. I opptaksområdene med høyest rate 
utføres det mer enn dobbelt så mange operasjoner pr 1 000 innbygger sammenliknet med opptaksområdene som utfører færrest operasjoner. 
I 2023 varierte raten fra 2,1 for opptaksområdet knyttet til Lovisenberg HF til 4,8 for Førde. 
\n\n 
Kvinner opereres i større grad enn menn, og andelen operasjoner utført på kvinner var 57 % i 2023. Gjennomsnittsalderen 
var omtrent lik for begge kjønn i 2023og lå rett under 70 år. 
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
Innsetting av primære kneeproteser
;

%let no_description =
Antall Innsettinger av primære kneproteser pr 1 000 innbyggere
;

%let en_description =
Antall Innsettinger av primære kneproteser per 1,000 inhabitants
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
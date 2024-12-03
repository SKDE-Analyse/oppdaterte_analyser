/*Hofteprotese*/

%let no_utvalg=
Analysen er basert på aktivitetsdata fra Norsk pasientregister (NPR) for 
somatisk spesialisthelsetjeneste. Data inkluderer aktivitet i offentlige sykehus og 
private sykehus som leverer offentlig finansierte tjenester. 
\n\n

Utvalget omfatter kontakter registrert med en eller flere av prosedyrekodene 
NFB20, NFB30, NFB40 eller NFB99. Kontakter som inneholder diagnosekoder for 
hoftebrudd (S72.0, S72.1 og/eller S72.2) er ikke med.


\n\n Hvor pasienten er behandlet er delt inn i tre kategorier:
\n - Eget HF, behandlet ved et av sykehusene i opptaksområdet
\n - Annet HF, behandlet ved et sykehus utenfor opptaksområdet
\n - Privat, behandlet ved et privat sykehus. 

\n\n Innsetting av hofteproteser utføres i hovedsak på voksne pasienter. 
Populasjonen omfatter derfor kun pasienter som er 50 år og eldre.
For å kunne sammenligne opptaksområdene og mellom år, er ratene kjønns- og aldersjustert. 
Justeringen er gjort ved direkte metode med landets befolkning i 2023 som referansepopulasjon. 
SKDE er eneansvarlig for tolkning og presentasjon av de utleverte data fra NPR. 
FHI/NPR har ikke ansvar for analyser eller tolkninger basert på dataene.
;

%let en_utvalg=
The analysis is based on activity data from the Norwegian Patient Register (NPR) for somatic specialist healthcare services. 
The data includes activities in public hospitals and private hospitals providing publicly funded services.
\n\n

The selection includes contacts recorded with one or more of the procedure codes NFB20, NFB30, NFB40, or NFB99. 
Contacts containing diagnosis codes for hip fractures (S72.0, S72.1, and/or S72.2) are excluded.


\n\n The place of treatment is divided into three categories:
\n - Local public, treated at one of the hospitals in the catchment area
\n - Other public, treated at a public hospital outside the catchment area
\n - Private, treated by a private hospital

\n\n Hip prosthesis implantation is primarily performed on adult patients. 
Therefore, the population includes only patients aged 50 years and older.
In order to compare the catchment areas and between years, the rates have been adjusted for gender and age. 
The adjustment was done using the direct method with the country's population in 2023 as the reference population.
SKDE is solely responsible for the interpretation and presentation of the data provided by NPR. 
FHI/NPR is not responsible for analyses or interpretations based on the data.
;

%let no_summary = 
- Antall operasjoner knyttet til innsetting av hofteproteser har økt med 27 % i perioden 2015-2023
\n - Antall operasjoner per 1 000 innbygger hadde kun en marginal økning i samme periode
\n - Det er relativt liten variasjon mellom de ulike opptaksområdene 
;

%let en_summary = 
- The number of surgeries related to hip prosthesis insertions increased by 27% from 2015 to 2023
\n - The number of surgeries per 1,000 inhabitants showed only a marginal increase during the same period
\n - There is relatively little variation between the different catchment areas
;

%let no_discussion = 
Det ble i gjennomsnitt utført 8 225 innsettinger av hofteproteser pr år på pasienter 50 år og eldre. Antall operasjoner
 har økt med 27 % fra 7 441 i 2015 til 9 466 i 2023.
Antall kontakter pr år hadde en markant nedgang under pandemien. Etter pandemien er antallet høyere enn før pandemien.
\n\n 
Målt i antall operasjoner per 1 000 innbyggere er det kun en liten endring i perioden. Denne raten har økt med 5 %, 
fra 4,4 til 4,6. I samme periode har antall bosatte i Norge som er 50 år og eldre økt med 16 %. Det vil si at 
økningen i antall operasjoner i stor grad skyldes befolkningsøkning.
\n\n 
Kvinner opereres i større grad enn menn, og andelen operasjoner utført på kvinner var 65 % i 2023. Gjennomsnittsalderen 
var omtrent lik for begge kjønn i 2023 og lå omkring 70 år. 
\n\n
;

%let en_discussion = 
On average, 8,225 hip prosthesis implantations were performed per year on patients aged 50 years and older. 
The number of surgeries increased by 27 %, from 7,441 in 2015 to 9,466 in 2023.
The number of contacts per year saw a significant decline during the pandemic. 
After the pandemic, the numbers have risen higher than pre-pandemic levels.
\n\n 
Measured by the number of surgeries per 1,000 inhabitants, there has been only a slight change during the period. 
This rate increased by 5 %, from 4.4 to 4.6. During the same period, the number of residents in Norway aged 50 years and older increased by 16 %. 
This indicates that the rise in the number of surgeries is largely due to population growth.
\n\n 
Women undergo surgery more frequently than men, with 65 % of the operations performed on women in 2023. 
The average age was approximately the same for both genders in 2023, around 70 years.
\n\n
;

%let no_title =
Innsetting av primære hofteproteser
;

%let en_title =
Insertion of Primary Hip Prostheses
;

%let no_description =
Antall innsettinger av primære hofteproteser pr 1 000 innbyggere 50 år og eldre
;

%let en_description =
The number of primary hip prosthesis insertions per 1,000 inhabitants aged 50 years and older
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
/*Tonsiller voksne*/

%let no_utvalg=
Analysen er basert på aktivitetsdata fra Norsk pasientregister (NPR) for 
somatisk spesialisthelsetjeneste. Data inkluderer aktivitet i offentlige sykehus, 
private sykehus som leverer offentlig finansierte tjenester og avtalespesialister
som har avtaler om offentlig finansiering.
\n\n

Utvalget består av pasienter i alderen 16 år eller eldre registrert med hoved- eller bidiagnose 
J35.0, J35.1, J35.3, J35.8, J35.9, J36, J39.0, J03.0, J03.8, J03.9 eller G47.3 i 
kombinasjon med:
\n - prosedyrekode EMB10, EMB12, EMB15, EMB20, EMB99 eller ENC40 
på sykehus eller 
\n - med takstkode K02a, K02e, K02f, K02g hos avtalespesialist 

\n\n Hvor pasienten er behandlet er delt inn i tre kategorier:
\n - Eget HF, behandlet ved et av sykehusene i opptaksområdet
\n - Annet HF, behandlet ved et sykehus utenfor opptaksområdet
\n - Privat, behandlet ved et privat sykehus eller hos avtalespesialist 
;

%let en_utvalg=
The analysis is based on data from the Norwegian Patient Registry (NPR) for  
specialist healthcare services. The data includes activity in public hospitals, publicly funded 
private hospitals, and specialists in private practice under public funding contacts.

\n\n
The sample consists of patients aged 16 years or older registered with a primary or secondary diagnosis of 
J35.0, J35.1, J35.3, J35.8, J35.9, J36, J39.0, J03.0, J03.8, J03.9, or G47.3 
in combination with: 
\n - procedure code EMB10, EMB12, EMB15, EMB20, EMB99, or ENC40 in hospitals or 
\n - fee code K02a, K02e, K02f, K02g with a specialist 

\n\n The place of treatment is divided into three categories:
\n - Local public, treated at one of the hospitals in the catchment area
\n - Other public, treated at a public hospital outside the catchment area
\n - Private, treated by a private hospital or a private specialist
;

%let no_summary = 
- Det er stor geografisk variasjon i operasjoner av mandler (tonsilleoperasjoner)
\n - Ratene var økende frem til pandemien, og er ennå ikke tilbake på 2019-nivå
\n - Ratene er omlag 50 % høyere for kvinner enn for menn
;

%let en_summary = 
- There is significant geographic variation in tonsil surgeries
\n - The rates were increasing until the pandemic and have not yet returned to 2019 levels
\n - The rates are approximately 50 % higher for women than for men
;

%let no_discussion = 
Det utføres om lag 5 000 tonsilleoperasjoner pr år på pasienter 16 år og eldre. 
Antall operasjoner pr år var økende i perioden før pandemien med en topp i 2019 hvor det ble utført nesten 6 000 operasjoner, 
i 2023 ble det utført 5 000 operasjoner.
\n\n 
Det er betydelig geografisk variasjon i operasjonsratene, opptaksområdene med høyest rate 
utfører om lag dobbelt så mange tonsilleoperasjoner pr 1 000 innbygger sammenliknet med opptaksområdene som utfører færrest operasjoner.
\n\n 
Kvinner opereres i større grad enn menn, og gjennomsnittsalderen er ca to år lavere for kvinner (26 år i 2023) enn menn (28 år i 2023)
ved operasjonstidspunktet. Gjennomsnittsalderen har falt i perioden, for både menn og kvinner. 
Reduksjonen i raten for opptaksområdet Bergen fra 2022 til 2023 skyldes sannsynligvis manglende innrapportering fra avtalespesialist i 2023.
;

%let en_discussion = 
Approximately 5 000 tonsil operations are performed annually on patients aged 16 and older. 
The number of operations per year was increasing in the period before the pandemic, peaking in 
2019 with nearly 6 000 operations. In 2023, 5 000 operations were performed.
\n\n
There is significant geographical variation in operation rates, with the areas with the highest 
rates performing about twice as many tonsil operations per 1 000 inhabitants compared to the areas with the lowest rates.
\n\n
Women are operated on more frequently than men, and the average age at the time of surgery 
is about two years lower for women (26 years in 2023) than for men (28 years in 2023). 
The average age has decreased over the period for both men and women. The reduction in 
the rate for the Bergen catchment area from 2022 to 2023 is likely due to a lack of reporting from contracted specialists in 2023.
;

%let no_title =
Operasjon av mandler (16 år og eldre)
;

%let en_title =
Tonsil surgery (16 years and older)
;

%let no_description =
Antall tonsilleoperasjoner pr 1 000 innbyggere, 16 år og eldre
;

%let en_description =
Number of tonsil operations per 1 000 inhabitants, 16 years and older
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
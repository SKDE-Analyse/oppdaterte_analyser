/*Tonsiller barn*/

%let no_utvalg=
Analysen er basert på aktivitetsdata fra Norsk pasientregister (NPR) for 
somatisk spesialisthelsetjeneste. Data inkluderer aktivitet i offentlige sykehus, 
private sykehus som leverer offentlig finansierte tjenester og avtalespesialister
som har avtaler om offentlig finansiering.

\n\n
Utvalget består av pasienter i alderen 0-15 år registrert med hoved- eller bidiagnose 
J35.0, J35.1, J35.3, J35.8, J35.9, J36, J39.0, J03.0, J03.8, J03.9 eller G47.3 i 
kombinasjon med:
\n - prosedyrekode EMB10, EMB12, EMB15, EMB20, EMB99 eller ENC40 
på sykehus eller 
\n - med takstkode K02a, K02e, K02f, K02g hos avtalespesialist 

\n\n Tonsilleoperasjoner med kun prosedyrekodene EMB12 eller EMB15 og 
samtidig ingen av de andre prosedyrekodene eller takstkodene er definert som tonsillotomi. 
Alle andre tonsilleoperasjoner er definert som tonsillektomi.
Tonsillotomier utføres også hos avtalespesialister, men siden takstkodene K02f og K02g 
er tonsillektomi/tonsillotomi, er det ikke mulig å skille mellom 
tonsillektomi og tonsillotomi ved hjelp av takstkodene. K02a og K02e er tonsillektomi.

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
The sample consists of patients aged 0-15 years registered with a primary or secondary diagnosis of 
J35.0, J35.1, J35.3, J35.8, J35.9, J36, J39.0, J03.0, J03.8, J03.9, or G47.3 
in combination with: 
\n - procedure code EMB10, EMB12, EMB15, EMB20, EMB99, or ENC40 in hospitals or 
\n - fee code K02a, K02e, K02f, K02g with a specialist 

\n\n Tonsil operations with only the procedure codes EMB12 or EMB15 and at the same time none of the 
other procedure codes or fee codes are defined as tonsillotomy. All other tonsil operations are defined as tonsillectomy. 
Tonsillotomies are also performed by specialists, but since the fee codes K02f and K02g are tonsillectomy/tonsillotomy, 
it is not possible to distinguish between tonsillectomy and tonsillotomy using the fee codes. K02a and K02e are tonsillectomy.

\n\n The place of treatment is divided into three categories:
\n - Local public, treated at one of the hospitals in the catchment area
\n - Other public, treated at a public hospital outside the catchment area
\n - Private, treated by a private hospital or a private specialist
;

%let no_summary = 
- Det er stor geografisk variasjon i operasjoner av mandler (tonsilleoperasjoner)
\n - Antall operasjoner pr år har holdt seg forholdsvis stabil i perioden (bortsett fra pandemien)
\n - Andelen operasjoner med tonsillotomi har økt fra under 10 % i 2015 til over 40 % i 2023
;

%let en_summary = 
- There is significant geographical variation in tonsil operations
\n - The number of patients undergoing surgery per year has remained relatively stable over the period (except during the pandemic)
\n - The proportion procedures with tonsillotomy has increased from less than 10 % in 2015 to more than 40 % in 2023
;

%let no_discussion = 
Det utføres i underkant av 5 000 tonsilleoperasjoner pr år på barn under 16 år. Antall operasjoner falt markant under pandemien, 
og nådde først i 2023 nivået fra før covid-19. Det er stor geografisk variasjon i antall operasjoner. 
Gutter opereres i større grad enn jenter, og gjennomsnittsalderen er noe lavere for gutter enn jenter ved operasjonstidspunktet.
\n\n 
Andelen som får delvis fjerning av mandlene (tonsillotomier) har økt fra i underkant av 10 % i 2015 til over 40 % etter pandemien. 
I følge Tonsilleregisteret er en av årsakene til dette at indikasjon hypertrofi benyttes oftere for barn, og da ansees tonsillotomi 
som et tryggere inngrep med færre postoperative komplikasjoner.
\n\n 
Barna behandles hovedsakelig i eget HF. Den betydelige observerte geografiske variasjonen over tid kan tyde på overbehandling i noen 
områder og underbehandling i andre. Data fra Tonsilleregisteret for 2023 viser imidlertid at 92 % var symptomfrie 6 måneder etter operasjon. 
Reduksjonen i raten for opptaksområdet Bergen fra 2022 til 2023 skyldes sannsynligvis manglende innrapportering fra avtalespesialist i 2023.  
;

%let en_discussion = 
Approximately 5 000 tonsil operations are performed annually on children under 16 years old. The number of operations dropped 
significantly during the pandemic and only returned to pre-COVID-19 levels in 2023. There is significant geographical variation 
in the number of operations. Boys are operated on more frequently than girls, and the average age at the time of surgery is 
slightly lower for boys than for girls. 
\n\n
The proportion of partial tonsil removals (tonsillotomies) has increased from just under 10 % in 2015 to over 40 % after the pandemic. 
According to the Tonsil Register, one reason for this is that the indication for hypertrophy is used more often for children, 
and tonsillotomy is considered a safer procedure with fewer postoperative complications.
\n\n
Children are mainly treated in their own health trust. The significant observed geographical variation over time may indicate 
overtreatment in some areas and undertreatment in others. However, data from the Tonsil Register for 2023 shows that 92 % were 
symptom-free 6 months after surgery. The reduction in the rate for the Bergen catchment area from 2022 to 2023 is likely due to a 
lack of reporting from contracted specialists in 2023.
;

%let no_title =
Operasjon av mandler (0-15 år)
;

%let en_title =
Tonsil surgery (0-15 years)
;

%let no_description =
Antall tonsilleoperasjoner pr 1 000 barn, 0-15 år
;

%let en_description =
Number of tonsil operations per 1 000 child, 0-15 år
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
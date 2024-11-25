/*Karpaltunnel*/

%let no_utvalg=
Analysen er basert på aktivitetsdata fra Norsk pasientregister (NPR) for 
somatisk spesialisthelsetjeneste. Data inkluderer aktivitet i offentlige sykehus, 
private sykehus som leverer offentlig finansierte tjenester og avtalespesialister
som har avtaler om offentlig finansiering.
\n\n

Utvalget består av pasienter registrert med hoved- eller bidiagnose 
G56.0 i kombinasjon med:
\n - prosedyrekode ACC51, NDE11, NDE12, NDM19, NDM49 eller NDL50 på sykehus eller 
\n - tilsvarende prosedyrekoder eller takstkode 140i hos avtalespesialist 

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
The sample consists of patients aged 16 years or older registered with a primary 
or secondary diagnosis of G56.0 
in combination with: 
\n - procedure code ACC51, NDE11, NDE12, NDM19, NDM49 or NDL50 in hospitals or 
\n - the same procedure code or fee code 140i with a specialist 

\n\n The place of treatment is divided into three categories:
\n - Local public, treated at one of the hospitals in the catchment area
\n - Other public, treated at a public hospital outside the catchment area
\n - Private, treated by a private hospital or a private specialist
;

%let no_summary = 
- Det er stor geografisk variasjon i operasjoner av xxx karpaltunnelsyndrom
\n - Ratene var xxx frem til pandemien, og er xxx på 2019-nivå
\n - Ratene er omlag xxx høyere for kvinner enn for menn
;

%let en_summary = 
- There is significant geographic variation in xxx karpaltunnelsyndrom surgeries
\n - The rates were xxx until the pandemic and have xxx not yet returned to 2019 levels
\n - The rates are approximately xxx higher for women than for men
;

%let no_discussion = 
Det utføres om lag xxx operasjoner for karpaltunnelsyndrom pr år. 
/*
Antall operasjoner pr år var økende i perioden før pandemien med en topp i 2019 hvor det ble utført nesten 6 000 operasjoner, 
i 2023 ble det utført 5 000 operasjoner.
\n\n 
Det er betydelig geografisk variasjon i operasjonsratene, opptaksområdene med høyest rate 
utfører om lag dobbelt så mange tonsilleoperasjoner pr 1 000 innbygger sammenliknet med opptaksområdene som utfører færrest operasjoner.
\n\n 
Kvinner opereres i større grad enn menn, og gjennomsnittsalderen er ca to år lavere for kvinner (26 år i 2023) enn menn (28 år i 2023)
ved operasjonstidspunktet. Gjennomsnittsalderen har falt i perioden, for både menn og kvinner. 
Reduksjonen i raten for opptaksområdet Bergen fra 2022 til 2023 skyldes sannsynligvis manglende innrapportering fra avtalespesialist i 2023.
*/
;

%let en_discussion = 
Approximately xxx karpaltunnelsyndrom operations are performed annually. 
/*
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
*/
;

%let no_title =
Karpaltunnelsyndrom
;

%let en_title =
Karpaltunnelsyndrom
;

%let no_description =
Antall operasoner av karpaltunnelsyndrom pr 1 000 innbyggere, 16 år og eldre
;

%let en_description =
Number of karpaltunnelsyndrom operations per 1 000 inhabitants, 16 years and older
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
/*Endometriose*/

%let no_utvalg=
Analysen er basert på aktivitetsdata fra Norsk pasientregister (NPR) for 
somatisk spesialisthelsetjeneste. Data inkluderer aktivitet i offentlige sykehus og 
private sykehus som leverer offentlig finansierte tjenester. 
Data fra avtalespesialister er ikke inkludert, fordi denne behandlingen kun gis på sykehus. 

\n\n
Utvalget består av kvinner i alderen 16-55 år med en eller flere av følgende hoved- eller bidiagnoser
N80, N941, N944, N945 eller N946 i kombinasjon med en eller fere av følgende prosedyrekoder 
LCD00, LCD30, LCD96, LCD10, LCD40, LCD01, LCD04, LCD11, LCD31, LCD97, LCC10, LCC11, LCC20, 
JAL21, JAL24, JAP00, JAP01, JAL20, JAL21, JAA10, JAA11, LAC00, LAC01, LAC10, LAC11, LAC20, LAC21, LCF00
LCF01, LAD00, LAD01, LAE10, LAE11, LAE20, LAE21, LAF00, LAF01, LAF10, LAF11, LAF20, LAF30, LBD00
LBD01, LBE00, LBE01, LCC00, LCC01, LCC05, LCC96, LCC97, LCF97 eller LCF96.


\n\n Hysterektomi er definert ved en eller flere av følgende prosedyrekodener
LCD00, LCD30, LCD96, LCD10, LCD40, LCD01, LCD04, LCD11, LCD31, LCD97, LCC10, LCC11 eller LCC20,
og de resterende prosedyrekodene blir definert som andre inngrep. 

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
The sample consists of women aged 16-55 years registered with a primary or secondary diagnosis of 
N80, N941, N944, N945 or N946 in combination with one or more of the following procedure codes 
LCD00, LCD30, LCD96, LCD10, LCD40, LCD01, LCD04, LCD11, LCD31, LCD97, LCC10, LCC11, LCC20, 
JAL21, JAL24, JAP00, JAP01, JAL20, JAL21, JAA10, JAA11, LAC00, LAC01, LAC10, LAC11, LAC20, LAC21, LCF00
LCF01, LAD00, LAD01, LAE10, LAE11, LAE20, LAE21, LAF00, LAF01, LAF10, LAF11, LAF20, LAF30, LBD00
LBD01, LBE00, LBE01, LCC00, LCC01, LCC05, LCC96, LCC97, LCF97 or LCF96.

\n\n Hysterectomy is defined by one or more of the following procedure codes: 
LCD00, LCD30, LCD96, LCD10, LCD40, LCD01, LCD04, LCD11, LCD31, LCD97, LCC10, LCC11, or LCC20, 
and the remaining procedure codes are defined as other interventions

\n\n The place of treatment is divided into three categories:
\n - Local public, treated at one of the hospitals in the catchment area
\n - Other public, treated at a public hospital outside the catchment area
\n - Private, treated by a private hospital
;

%let no_summary = 
- Det er stor geografisk variasjon i operasjoner for endometriose
\n - Antall operasjoner pr år har holdt seg forholdsvis stabil i perioden (bortsett fra pandemien)
\n - Andelen operasjoner med tonsillotomi har økt fra under 10 % i 2015 til over 40 % i 2023
;

%let en_summary = 
- There is significant geographical variation in surgery for endometriosis
\n - lorem ipsum
\n - lorem ipsum 10 % in 2015 to more than 40 % in 2023
;

%let no_discussion = 
Lorem ipsum 5 
;

%let en_discussion = 
Lorem ipsum 8
;

%let no_title =
Kirurgiske inngrep for endometriose
;

%let en_title =
Surgical procedures for endometriosis
;

%let no_description =
Antall inngrep pr 1 000 kvinner, 16-55 år
;

%let en_description =
Number of procedures per 1 000 women, 16-55 years
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
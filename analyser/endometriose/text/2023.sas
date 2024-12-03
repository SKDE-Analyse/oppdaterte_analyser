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

/* \n\n Tverrfaglig kirurgi er definert ved en eller flere av prosedyrekodene for:
\n - Tarmkirurgi (JGB01, JGB97, JGA97, JGW97)
\n - Urinveier (KBH51, KBH21, KCH01, KCD97)
\n - Diafragma (JBA21, JBA11) */

\n\n Hvor pasienten er behandlet er delt inn i tre kategorier:
\n - Eget HF, behandlet ved et av sykehusene i opptaksområdet
\n - Annet HF, behandlet ved et sykehus utenfor opptaksområdet
\n - Privat, behandlet ved et privat sykehus 

\n\n
For å kunne sammenligne opptaksområdene og mellom år, er ratene kjønns- og aldersjustert. Justeringen er gjort ved direkte metode med landets befolkning i 2023 som referansepopulasjon.
\n\n
Fraskrivelse: SKDE er eneansvarlig for tolkning og presentasjon av de utleverte data fra NPR. FHI/NPR har ikke ansvar for analyser eller tolkninger basert på dataene.

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

/* \n\n Multidisciplinary surgery is defined by one or more of the procedure codes for:
\n - Bowel surgery (JGB01, JGB97, JGA97, JGW97)
\n - Urinary tract (KBH51, KBH21, KCH01, KCD97)
\n - Diaphragm (JBA21, JBA11) */

\n\n The place of treatment is divided into three categories:
\n - Local public, treated at one of the hospitals in the catchment area
\n - Other public, treated at a public hospital outside the catchment area
\n - Private, treated by a private hospital

\n\n
In order to compare the catchment areas and between years, the rates have been adjusted for gender and age. 
The adjustment was done using the direct method with the population in 2023 as the reference population.
\n\n
SKDE is solely responsible for the interpretation and presentation of the data provided by NPR. 
FHI/NPR is not responsible for analyses or interpretations based on the data.

;

%let no_summary = 
- Det er stor geografisk variasjon i operasjoner for endometriose, og variasjonen vurderes som uberettiget
\n - Antall operasjoner har økt med 70 % i perioden 2015-2023
\n - Andelen operasjoner med hystrektomi har økt fra 34 % i 2015 til over 42 % i 2023
/* \n - Andelen operasjoner med tverrfaglig kirurgi har økt fra 3 % i 2015 til 9 % i 2023 */
;

%let en_summary = 
- There is significant geographical variation in surgeries for endometriosis, and the variation is considered as unwarranted
\n - The number of surgeries has increased by 70% in the period from 2015 to 2023.
\n - The proportion of surgeries involving hysterectomy has increased from 34% in 2015 to over 42% in 2023.
/* \n - The proportion of surgeries involving multidisciplinary surgery has increased from 3% in 2015 to 9% in 2023. */
;

%let no_discussion = 
Antall operasjoner for endometriose økte fra 1 272 i 2015 til 2 154 i 2023.
Det er stor geografisk variasjon i operasjoner for endometriose, området med høyest rate har mer enn 3 
ganger så mange operasjoner som området med lavest rate. Opptaksområdet for Vestfold HF har gjennomgående høy rate i perioden og høyest rate fra og med 2019. 
Opptaksområdene for Førde og Nord-Trøndelag HF har gjennomgående lave rater i perioden.

\n\n Andelen operasjoner med hystrektomi har økt fra 34 % i 2015 til over 42 % i 2023. I 2023 ble det utført hystrektomi i mer enn 
halvparten av operasjonene for endometriose i opptaksområdene for Helgeland (69 %), Telemark (58 %), Østfold (57 %), Vestfold (53 %), 
Møre og Romsdal (52 %) og UNN HF (51 %). I opptaksområdene for Lovisenberg (19 %), Diakonhjemmet (23 %), OUS HF (23 %) 
var andelen hystrektomi betydelig lavere i 2023.

\n\n Andelen som blir behandlet i eget helseforetak har vært stabilt rundt 60 % for landet totalt i perioden. 
Median alder for kvinner som opreres for endometriose har falt fra 38 år til 36 år fra 2015 til 2023, og 
gjennomsnittsalderen for de som får utført hystrektomi har falt fra nesten 43 år til 41,5 år i perioden.

;

%let en_discussion = 
The number of surgeries for endometriosis increased from 1,272 in 2015 to 2,154 in 2023. There is significant geographical variation in 
surgeries for endometriosis, with the area with the highest rate having more than three times as many surgeries as the area with the lowest 
rate. The catchment area for Vestfold HF consistently had a high rate during the period and the highest rate from 2019 onwards. 
The catchment areas for Førde and Nord-Trøndelag HF consistently had low rates during the period.

The proportion of surgeries involving hysterectomy increased from 34 % in 2015 to over 42 % in 2023. In 2023, hysterectomy was performed 
in more than half of the surgeries for endometriosis in the catchment areas for Helgeland (69 %), Telemark (58 %), Østfold (57 %), 
Vestfold (53 %), Møre og Romsdal (52 %), and UNN HF (51 %). In the catchment areas for Lovisenberg (19 %), Diakonhjemmet (23 %), and 
OUS HF (23 %), the proportion of hysterectomies was significantly lower in 2023.

The proportion of patients treated within their own health trust has remained stable at around 60% for the country as a whole 
during the period. The average age of women undergoing surgery for endometriosis has decreased from just over 37 years to 
just under 36 years from 2015 to 2023, and the average age of those undergoing hysterectomy has decreased from almost 43 years 
to 41.5 years during the period.
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
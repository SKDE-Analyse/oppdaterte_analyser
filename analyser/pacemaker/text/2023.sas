/*Pacemaker*/
/* Ønsker å skille på pacemaker og hjertestarter ( ICD eller CRT) */

/* 
Gamle NCSP-koder 2015:
FPE00	Implantasjon av pacemaker med transvenøs ventrikkelelektrode ** FPK10A
FPE10	Implantasjon av pacemaker med transvenøs atrieelektrode ** FPK13A
FPE20	Impl av pacemaker m/transvenøs atrie- & ventrikkelelektrode ** FPK16A
FPE26	Implant transvenøs pacemaker med biventrikulære elektroder ** FPK20A
FPF00	Implantasjon av pacemaker med epikardial ventrikkelelektrode
FPF10	Implantasjon av pacemaker med epikardial atrieelektrode
FPF20	Impl av pacemaker m/epikardial atrie- & ventrikkelelektrode
FPG10	Impl cardioverter-defibrill m/generator & epikard elektrode
FPG20	Impl cardioverter-def m/gener & epikard elektr v/hjertekir
FPG30	Impl cardioverter-def m/ gener & transvenøs ventrikkelelektr
FPG33	Impl cardioverter-def m/ gener & trsv atrie-& ventrelektrode ** FPK30A
FPG36	Impl cardiov-defibrill m generator & transven biventr elektr ** FPK36A

Ny koder fra 2016:
** FPF Implantasjon og utskifting av permanent epikardialt pacemakersystem
FPF00 Implantasjon av pacemaker med epikardial ventrikkelelektrode
FPF10 Implantasjon av pacemaker med epikardial atrieelektrode
FPF20 Implantasjon av pacemaker med epikardial atrie- og ventrikkelelektrode

** FPG Implantasjon av permanent cardioverter-defibrillator
FPG10 Implantasjon av cardioverter-defibrillator med generator og epikardial elektrode
FPG20 Implantasjon av cardioverter-defibrillator med generator og epikardial elektrode ved åpen hjertekirurgi

** FPXB Bildeveiledede intervensjoner ved arytmier og ledningsforstyrrelser
FPK00A Temporær transvenøs pacemaker
FPK10A Implantasjon av pacemaker med transvenøs ventrikkelelektrode
FPK13A Implantasjon av pacemaker med transvenøs atrieelektrode
FPK16A Implantasjon av pacemaker med transvenøs atrie- og ventrikkelelektrode
FPK20A Implantasjon av transvenøs pacemaker med biventrikulære elektroder
FPK23A Implantasjon av transvenøs pacemaker med atrie-, ventrikkel- og koronarveneelektrode (biventrikulær pacemaker)
FPK30A Implantasjon av cardioverter-defibrillator med generator og transvenøs ventrikkelelektrode
FPK33A Implantasjon av cardioverter-defibrillator med generator og transvenøs atrie- og ventrikkelelektrode
FPK36A Implantasjon av cardioverter-defibrillator med generator og transvenøs biventrikulær elektrode
FPK40A Implantasjon av cardioverter-defibrillator med generator og transvenøs atrie-, ventrikkel- og koronarveneelektrode
FPK50A Implantasjon av transvenøs pacemakerelektrode
FPK53A Implantasjon av transvenøs elektrode til cardioverter-defibrillator
*/

%let no_utvalg=
Analysen er basert på aktivitetsdata fra Norsk pasientregister (NPR) for 
somatisk spesialisthelsetjeneste. Data inkluderer aktivitet i offentlige sykehus, 
private sykehus som leverer offentlig finansierte tjenester. 
\n\n

Utvalget består av inngrep med prosedyrekode FPE00, FPE10, FPE20, FPE26, FPG30, FPG33 eller FPG36 
på sykehus. Prosedyrene FPE26 og FPG36 angir hjertesviktbehandling ved
henholdsvis pacemaker og hjertestarter (CRT, cardiac resynchronization therapy).
\n
Skifting og fjerning av pacemakere, batteri eller elektroder er ikke inkludert i denne analysen.

\n\n Hvor pasienten er behandlet er delt inn i tre kategorier:
\n - Eget HF, behandlet ved et av sykehusene i opptaksområdet
\n - Annet HF, behandlet ved et sykehus utenfor opptaksområdet
\n - Privat, behandlet ved et privat sykehus eller hos avtalespesialist 

\n\n
For å kunne sammenligne opptaksområdene og mellom år, er ratene kjønns- og aldersjustert. Justeringen er gjort ved direkte metode med landets befolkning i 2023 som referansepopulasjon.
\n\n
Fraskrivelse: SKDE er eneansvarlig for tolkning og presentasjon av de utleverte data fra NPR. FHI/NPR har ikke ansvar for analyser eller tolkninger basert på dataene.

;

%let en_utvalg=
The analysis is based on data from the Norwegian Patient Registry (NPR) for  
specialist healthcare services. The data includes activity in public hospitals, publicly funded 
private hospitals, and specialists in private practice under public funding contacts.

\n\n
The sample consists of patients with a primary or secondary diagnosis of 
M20.1, M20.2, M20.3, M20.4, M20.5, or M20.6 
in combination with: 
\n - procedure code NHG09, NHG44, NHG46, NHG49, NHK17, NHK18, NHK57, or NHK58 in hospitals or 
\n - fee code 134a, 134b, or 140d with a specialist 

\n\n The place of treatment is divided into three categories:
\n - Local public, treated at one of the hospitals in the catchment area
\n - Other public, treated at a public hospital outside the catchment area
\n - Private, treated by a private hospital or a private specialist

\n\n
In order to compare the catchment areas and between years, the rates have been adjusted for gender and age. 
The adjustment was done using the direct method with the population in 2023 as the reference population.
\n\n
SKDE is solely responsible for the interpretation and presentation of the data provided by NPR. FHI/NPR is not responsible for analyses or interpretations based on the data.

;

%let no_summary = 
- Det er stor geografisk variasjon i operasjoner av Hallux valgus og Hammertå
\n - Antall operasjoner har blitt redusert med 43 % fra 2015 til 2023
\n - 80 % av operasjoene utføres på kvinner
;

%let en_summary = 
- There is significant geographical variation in surgeries for Hallux valgus and Hammertoe.
\n - The number of surgeries has decreased by 43 % from 2015 to 2023.
\n - 80 % of the surgeries are performed on women.
;

%let no_discussion = 
Antall operasjoner har falt gjennom hele perioden, fra 5 400 i 2015 til 3 100 i 2023. 
Kvinnelige pasienter stod i 2023 for omlag 80 % av operasjonene, og fallet i antall operasjoner i perioden 
skyldes hovedsakelig færre operasjoner på kvinner. 
\n\n 
Det er betydelig geografisk variasjon i operasjonsratene, opptaksområdene med høyest rate 
utfører om lag tre ganger så mange operasjoner pr 1 000 innbygger sammenliknet med opptaksområdene som utfører færrest operasjoner,
variasjonen klassifiseres derfor som uberettiget. 
Opptaksområdene for Stavanger og Bergen HF har gjennomgående lave rater, 
mens opptaksområdene for Finnmark og UNN HF har gjennomgående høye rater.
\n\n 
Mer enn halvparten av operasjonene utføres i eget helseforetak og omtrent 20 % utføres hos private for landet som helhet, 
men her er det store forskjeller mellom opptaksområdene. I 2023 ble omlag halvparten av operasjonene utført hos private 
i opptaksområdene for Nord-Trøndelag og St.Olav HF, mens ingen operasjoner ble utført privat i opptaksområdene for Vestre Viken og Telemark HF.
;

%let en_discussion = 
The number of surgeries has decreased throughout the period, from 5,400 in 2015 to 3,100 in 2023. 
Women accounted for approximately 80 % of the surgeries in 2023, and the decline in the number of 
surgeries during the period is mainly due to fewer surgeries on women.
\n\n 
There is significant geographical variation in surgery rates. The catchment areas with the highest 
rates perform about three times as many surgeries per 1,000 inhabitants compared to the catchment 
areas with the fewest surgeries, classifying the variation as unwarranted. The catchment areas for 
Stavanger and Bergen HF have consistently low rates, while the catchment areas for Finnmark and 
UNN HF have consistently high rates.
\n\n 
More than half of the surgeries are performed in their own health trusts, and about 20 % are 
performed privately for the country as a whole, but there are significant differences 
between catchment areas. In 2023, about half of the surgeries were performed privately in 
the catchment areas for Finnmark and St. Olav HF, while no surgeries were performed privately 
in the catchment areas for Vestre Viken and Telemark HF.
;

%let no_title =
Innsetting av pacemaker
;

%let en_title =
Surgery for Hallux valgus and Hammertoe
;

%let no_description =
Antall inngrep med innsetting av pacemaker pr 1 000 innbyggere
;

%let en_description =
Number of surgeries for Hallux valgus and Hammertoe per 1,000 inhabitants
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
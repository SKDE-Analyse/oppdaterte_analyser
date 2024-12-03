/*Øredren*/

%let no_utvalg=
Analysen er basert på aktivitetsdata fra Norsk pasientregister (NPR) for 
somatisk spesialisthelsetjeneste. Data inkluderer aktivitet i offentlige sykehus, 
private sykehus som leverer offentlig finansierte tjenester og avtalespesialister
som har avtaler om offentlig finansiering.

\n\n
Utvalget består av alle kontakter (innleggelser, polikliniske konsultasjoner og dagbehandling) 
med inngrepet for innsetting av ventilasjonsrør i trommehinnen, for barn (0-16 år) i somatisk spesialisthelsetjeneste,
inkludert private avtalespesialister. Inngrepet er definert ved prosedyrekoden
(NCSP) DCA20 for ISF-finansierte sykehus, og takstene K02c, K02d, K02e eller K02g
for private avtalespesialister. Taksten 317b (Paracentese med ventilasjonsrør) 
hos avtalespesialister er ikke inkludert da dette inngrepet i hovedsak utføres på voksne.

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
The sample consists of all contacts (admissions, outpatient consultations, and day treatments) involving 
the insertion of ear tubes for children in somatic specialist health services, including private contract specialists. 
The insertion of ear tubes is defined by the procedure code (NCSP) DCA20 for DRG-financed hospitals, 
and the tariffs K02c, K02d, K02e, or K02g for private contract specialists. The tariff 317b (Paracentesis with ventilation tube) 
for contract specialists is not included as this procedure is mainly performed on adults.

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
- Det er stor geografisk variasjon i innsetting av ventilasjonsrør i trommehinnen hos barn
\n - Nord-Trøndelag har høyest rate i hele perioden, og Oslo-området har lavest rate
\n - Omtrent 60 % av inngrepene utføres på gutter
;

%let en_summary = 
- There is significant geographical variation in the insertion of ventilation tubes in the eardrum among children.
\n - Nord-Trøndelag has the highest rate throughout the period, while the Oslo area has the lowest rate.
\n -Approximately 60% of the procedures are performed on boys.
;

%let no_discussion = 
Det utføres omlag 5 000 inngrep med innsetting av ventilasjonsrør i trommehinnen pr år på barn i alderen 0-16 år. 
Antall inngrep falt i perioden 2015 til 2019, og antall inngrep falt markant under pandemien. I 2023 var antall inngrep på 2019-nivå.
\n\n
Det er stor geografisk variasjon i antall inngrep. 
Opptaksområdet for Nord-Trøndelag HF har gjennomgående høyest rate i hele perioden, og opptaksområdene i Oslo 
(OUS, Lovisenberg og Diakonhjemmet HF) har gjennomgående lave rater i perioden. 
Inngrepet utføres mer enn tre ganger så hyppig på barn i opptaksområdet for Nord-Trøndelag HF som i Oslo-området i alle år i perioden.
Dette tyder på at fagmiljøene ikke er enige om hva som er riktig indikasjon for å
behandle med ventilasjonsrør. Det medisinske behovet antas å være omtrent likt uavhengig
av hvor i Norge man bor, og variasjonen vurderes derfor som uberettiget.
\n\n 
Inngrepet utføres i større grad på gutter enn jenter, 60 % av inngrepene utføres på gutter. 
Gjennomsnittsalderen ved inngrepet var fem år, og inngrepet utføres hyppigst på treåringer.
\n\n 
Barna behandles hovedsakelig i eget HF, men her er det store forskjeller mellom opptaksområdene. 
I 2023 ble 75 % av inngrepene utført i eget HF, 8 % i annet HF og 16 % utført hos private for landet som helhet. 
I opptaksområdene for St. Olav og Diakonhjemmet HF ble mer en halvparten av inngrepene i 2023 utført hos private.
;

%let en_discussion = 
Approximately 5,000 procedures involving the insertion of ventilation tubes in the eardrum are performed annually on 
children aged 0-16 years. The number of procedures decreased from 2015 to 2019, and there was a significant drop during 
the pandemic. In 2023, the number of procedures returned to the 2019 level.
\n\n
There is significant geographical variation in the number of procedures. The catchment area for Nord-Trøndelag HF 
consistently has the highest rate throughout the period, while the catchment areas in Oslo (OUS, Lovisenberg, 
and Diakonhjemmet HF) consistently have low rates. The procedure is performed more than three times as frequently 
on children in the catchment area for Nord-Trøndelag HF compared to the Oslo area in all years of the period. 
This suggests that there is a lack of consensus among medical experts regarding the appropriate indications for using ventilation tubes. 
The medical need is assumed to be approximately the same regardless of where in Norway one lives, 
and the variation therefore is considered as unwarranted.
\n\n 
The procedure is performed more frequently on boys than girls, with 60 % of the procedures performed on boys. 
The average age at the time of the procedure was five years, and the procedure is most commonly performed on three-year-olds.
\n\n 
Children are mainly treated in their own HF, but there are significant differences between catchment areas. 
In 2023, 75 % of the procedures were performed in their own HF, 8 % in another HF, and 16 % were performed privately for the 
country as a whole. In the catchment areas for St. Olav and Diakonhjemmet HF, more than half of the procedures in 
2023 were performed privately.
;

%let no_title =
Ventilasjonsrør i trommehinnen (0-16 år)
;

%let en_title =
Ventilation tubes in the eardrum (0-16 years)
;

%let no_description =
Antall inngrep med ventilasjonsrør i trommehinnen pr 1 000 barn, 0-16 år
;

%let en_description =
Number of procedures with ventilation tubes in the eardrum per 1,000 children, 0-16 years
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

%let no_summary = 
   - I underkant av 4 000 kvinner mottar IVF-behandling hvert år på offentlige sykehus
\n - Det var et fall i raten kvinner som får offentlig IVF-behandling i 2020, og den er fortsatt lavere enn pre-korona nivå i 2023
\n - Det er geografisk variasjon i andelen kvinner i IVF-behandling som er 39 år eller eldre
;
%let en_summary = 
   - Almost 4,000 women receive IVF treatment each year in public hospitals
\n - There was a drop in the rate of women receiving public IVF treatment in 2020, and the rate is still lower than pre-COVID levels in 2023
\n - There is geographical variation in the proportion of women undergoing IVF treatment who are 39 years or older
;


%let no_discussion = %str(
In vitro fertilisering (IVF), også kalt prøverørsbehandling, er den vanligste formen for assistert befruktning, hvor kvinnens egg blir
befruktet utenfor kroppen og tilbakeført når celledelingen har startet. I Norge er det i underkant av 4 000 kvinner som mottar
denne behandlingen hvert år, noe som tilsvarer mer enn 4 pr 1 000 kvinner i alderen 18-46 år. Disse tallene inkluderer bare kvinner som
har fått overført embryo til uterus og er derfor noe lavere enn det faktiske antallet kvinner i IVF-behandling.
\n\n
Det var en tydelig nedgang i IVF-behandlinger i koronaåret 2020, og raten har i ettertid delvis hentet seg inn til hva den var før korona.
Det var opptaksområdene med høyest rate som falt mest i 2020, noe som bidro til å utgjevne den geografiske variasjonen.
\n\n
Det er geografisk variasjon i andelen pasienter som er 39 år eller eldre. I 2023 var 8,7 % av kvinner i opptaksområdet Fonna som mottok
IVF-behandling 39 år eller eldre; i Lovisenberg lå denne andelen på 34 %. Disse variablene er aldersjusterte, så variasjonen skyldes
ikke demografiske forskjeller mellom opptaksområdene.
\n\n
Denne analysen supplementerer statistikken om assistert befruktning på [Helsedirektoratets sider](https://www.helsedirektoratet.no/statistikk/assistert-befruktning).
);

%let en_discussion = %str(
In vitro fertilization (IVF) is the most common form of assisted reproduction, where the woman%'s egg is fertilized outside the body and returned
when cell division has started. In Norway, just under 4,000 women receive this treatment each year, which corresponds to more than 4 per 1,000
women aged 18-46 years. These numbers only include women who have received transfer of an embryo to the uterus, and are therefore somewhat lower
than the actual number of women in IVF treatment.
\n\n
There was a clear decline in IVF treatments in the corona year 2020, and the rate has since partially recovered to what it was before corona.
The catchment areas with the highest rates were the ones with the greatest decline in 2020, something that has contributed to reducing the
geographical variation.
\n\n
There is geographical variation in the proportion of patients who are 39 years or older. In 2023, 8.7% of women in the Fonna catchment area
who received IVF treatment were 39 years or older; in Lovisenberg, this proportion was 34%. These variables are age-adjusted, so the
variation is not due to demographic differences between the catchment areas.
\n\n
This analysis complements the statistics on assisted fertilization on [the pages of the Directorate of Health](https://www.helsedirektoratet.no/statistikk/assistert-befruktning).
);


%let no_description = Antall kvinner som mottar embryo-overføringer pr 1 000 kvinner i alderen 18-46 år;
%let en_description = Number of women who receive embryo transfers per 1,000 women, 18 to 46 years old;


%let no_info=
Analysen er basert på aktivitetsdata fra Norsk pasientregister (NPR) for 
somatisk spesialisthelsetjeneste. Denne analysen inkluderer kun data fra offentlige sykehus.
\n\n
Utvalget består kvinner i alderen 18-46 år som har hatt kontakter med prosedyrekode LCA30, LCW30K eller LCW31K
(overføring av egg eller embryo til uterus).

\n\n Hvor pasienten er behandlet er delt inn i to kategorier:
\n - Eget HF, behandlet ved et av sykehusene i opptaksområdet
\n - Annet HF, behandlet ved et sykehus utenfor opptaksområdet
\n\n
For å kunne sammenligne opptaksområdene og mellom år, er ratene kjønns- og aldersjustert.
Justeringen er gjort ved direkte metode med landets befolkning i 2023 som referansepopulasjon.
\n\n
SKDE er eneansvarlig for tolkning og presentasjon av de utleverte data fra NPR.
FHI/NPR har ikke ansvar for analyser eller tolkninger basert på dataene.
;

%let en_info=
The analysis is based on activity data from the Norsk pasientregister (NPR) for somatic specialist health services.
This analysis includes only data from public hospitals.
\n\n
The sample consists of women aged 18-46 years with contacts coded with procedure code LCA30, LCW30K or LCW31K
(transfer of egg or embryo to the uterus).

\n\nWhere the patient is treated is divided into two categories:
\n - Own health trust, treated at one of the hospitals in the catchment area
\n - Other health trust, treated at a hospital outside the catchment area
\n\n
In order to compare the catchment areas and between years, the rates have been adjusted for gender and age. 
The adjustment was done using the direct method with the countrys population in 2023 as the reference population.
\n\n
SKDE is solely responsible for the interpretation and presentation of the data provided by NPR.
FHI/NPR is not responsible for analyses or interpretations based on the data.
;

/*NB! Ikke endre noe under her*/
%let no_info = %superq(no_info);
%let en_info = %superq(en_info);
%let no_summary = %superq(no_summary);
%let en_summary = %superq(en_summary);
%let no_discussion = %superq(no_discussion);
%let en_discussion = %superq(en_discussion);
%let no_description = %superq(no_description);
%let en_description = %superq(en_description);

%let settinn_txt =
   description=%nrstr(no := &no_description. || en := &en_description.),
   info =%nrstr(no := &no_info. || en := &en_info.),
   summary=%nrstr(no := &no_summary. || en := &en_summary.),
   discussion=%nrstr(no := &no_discussion. || en := &en_discussion.);
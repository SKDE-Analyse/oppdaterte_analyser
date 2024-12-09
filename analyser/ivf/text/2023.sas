
%let no_summary = 
   - I underkant av 4 000 kvinner mottar IVF-behandling hvert år på offentlige sykehus
\n - Det var et tydelig fall i raten kvinner som får offentlig IVF-behandling i 2020, og raten har fortsatt ikke hentet seg inn til pre-korona nivå i 2023
\n - Det er stor geografisk variasjon i andelen kvinner i IVF-behandling som er 39 år eller eldre
;
%let en_summary = 
   - Almost 4,000 women receive IVF treatment each year in public hospitals
\n - There was a significant drop in the rate of women receiving public IVF treatment in 2020, and the rate has still not recovered to pre-COVID levels in 2023
\n - There is considerable geographical variation in the proportion of women undergoing IVF treatment who are 39 years or older
;


%let no_discussion = %str(
In vitro fertilisering (IVF), også kalt prøverørsbehandling, er den vanligste formen for assistert befruktning, hvor kvinnens egg blir
befruktet utenfor kroppen og tilbakeført når celledelingen har startet. I Norge er det i underkant av 4 000 kvinner som mottar
denne behandlingen hvert år, noe som tilsvarer mer enn 4 pr 1 000 kvinner i alderen 18-46 år.
\n\n
Det var en tydelig nedgang i IVF-behandlinger i koronaåret 2020, og raten har i ettertid delvis hentet seg inn til hva den var før korona.
Helse Nord ble i liten grad påvirket av korona, men hadde en lignende økning i årene etterpå. I og med Helse Nord skilte
seg ut fra de andre regionene med en lavere rate i årene før 2020 har dette redusert den geografiske variasjonen, spesielt på RHF-nivå.
\n\n
Det er stor geografisk variasjon i andelen pasienter som er 39 år
eller eldre. I 2023 var 8,5 % av kvinner i opptaksområdet Fonna som mottok IVF-behandling 39 år eller eldre; i Lovisenberg
lå denne andelen på 34 %. Disse variablene er aldersjusterte, så variasjonen skyldes ikke demografiske forskjeller mellom opptaksområdene.
);

%let en_discussion = %str(
In vitro fertilization (IVF) is the most common form of assisted reproduction, where the woman%'s egg is fertilized outside the body and returned
when cell division has started. In Norway, just under 4,000 women receive this treatment each year, which corresponds to more than 4 per 1,000
women aged 18-46 years.
\n\n
There was a clear decline in IVF treatments in the corona year 2020, and the rate has since partially recovered to what it was before corona.
Helse Nord was minimally affected by corona but saw a similar increase in the years afterward. Since Helse Nord stood out from
the other regions with a lower rate in the years before 2020, this has reduced the geographical variation, especially at the RHF level.
\n\n
There is a large geographical variation in the proportion of
patients who are 39 years or older. In 2023, 8.5% of women in the Fonna catchment area who received IVF
treatment were 39 years or older; in Lovisenberg, this proportion was 34%. These variables are age-adjusted, so the variation is not due to
demographic differences between the catchment areas.
);


%let no_description = Antall kvinner som mottar embryo-overføringer pr 1 000 kvinner i alderen 18-46 år;
%let en_description = Number of women who receive embryo transfers per 1 000 women, 18 to 46 years old;


%let no_utvalg=
Analysen er basert på aktivitetsdata fra Norsk pasientregister (NPR) for 
somatisk spesialisthelsetjeneste. Denne analysen inkluderer kun data fra offentlige sykehus.
\n\n
Utvalget består kvinner i alderen 18-46 år som har hatt kontakter med prosedyrekode LCA30 eller LCW30K
(overføring av egg eller embryo til uterus).

\n\n Hvor pasienten er behandlet er delt inn i to kategorier:
\n - Eget HF, behandlet ved et av sykehusene i opptaksområdet
\n - Annet HF, behandlet ved et sykehus utenfor opptaksområdet
;

%let en_utvalg=
The analysis is based on activity data from the Norsk pasientregister (NPR) for somatic specialist health services.
This analysis includes only data from public hospitals.
\n\n
The sample consists of women aged 18-46 years with contacts coded with procedure code LCA30 or LCW30K
(transfer of egg or embryo to the uterus).

\n\nWhere the patient is treated is divided into two categories:
\n - Own health trust, treated at one of the hospitals in the catchment area
\n - Other health trust, treated at a hospital outside the catchment area
;

/*NB! Ikke endre noe under her*/
%let no_utvalg = %superq(no_utvalg);
%let en_utvalg = %superq(en_utvalg);
%let no_summary = %superq(no_summary);
%let en_summary = %superq(en_summary);
%let no_discussion = %superq(no_discussion);
%let en_discussion = %superq(en_discussion);
%let no_description = %superq(no_description);
%let en_description = %superq(en_description);

%let settinn_txt =
   description=%nrstr(no := &no_description. || en := &en_description.),
   info =%nrstr(no := &no_utvalg. || en := &en_utvalg.),
   summary=%nrstr(no := &no_summary. || en := &en_summary.),
   discussion=%nrstr(no := &no_discussion. || en := &en_discussion.);
%let no_utvalg=
Analysen er basert på aktivitetsdata fra Norsk pasientregister (NPR) for 
somatisk spesialisthelsetjeneste. Denne analysen inkluderer kun data fra offentlige sykehus.
\n\n
Utvalget består av kontakter med kvinner i alderen 18-46 år med prosedyrekode LCA30 eller LCW30K
(overføring av egg eller embryo til uterus).

\n\n Hvor pasienten er behandlet er delt inn i to kategorier:
\n - Eget HF, behandlet ved et av sykehusene i opptaksområdet
\n - Annet HF, behandlet ved et sykehus utenfor opptaksområdet
;

%let en_utvalg=
The analysis is based on activity data from the Norsk pasientregister (NPR) for somatic specialist health services.
This analysis includes only data from public hospitals.
\n\n
The sample consists of contacts with women aged 18-46 years with procedure code LCA30 or LCW30K (transfer of egg or embryo to the uterus).

\n\nWhere the patient is treated is divided into two categories:
\n - Own health trust, treated at one of the hospitals in the catchment area
\n - Other health trust, treated at a hospital outside the catchment area
;

%let no_summary = 
- Det er geografisk variasjon
;

%let en_summary = There is geographical variation;

%let no_discussion = 
Dette er en diskusjon, blabla;

%let en_discussion = This is a discussion, blabla;

%let no_title = In vitro fertilisering;
%let en_title = In vitro fertilization;

%let no_description = Antall embryo-overføringer pr 1 000 kvinner i alderen 18-46 år;
%let en_description = Number of embryo transfers per 1 000 women, 18 to 46 years old;

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
   title=%nrstr(no := &no_title. || en := &en_title.),
   description=%nrstr(no := &no_description. || en := &en_description.),
   info =%nrstr(no := &no_utvalg. || en := &en_utvalg.),
   summary=%nrstr(no := &no_summary. || en := &en_summary.),
   discussion=%nrstr(no := &no_discussion. || en := &en_discussion.);
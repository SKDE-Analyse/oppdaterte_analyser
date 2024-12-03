/*Injeksjon kontakter*/

%let no_utvalg=
Analysen er basert på aktivitetsdata fra Norsk pasientregister (NPR) for 
somatisk spesialisthelsetjeneste. Data inkluderer aktivitet i offentlige sykehus og 
private sykehus som leverer offentlig finansierte tjenester. 
Data fra avtalespesialister er ikke inkludert, fordi denne behandlingen kun gis på sykehus. 
\n \n 
Utvalget består av kontakter for pasienter i alderen 50 år eller eldre registrert med hoved- eller bidiagnose 
aldersrelatert makuladegenerasjon, AMD (H35.3), 
veneokklusjon (H34.8 eller H34.9) eller diabetisk retinopati (H36.0, E10.3 eller E11.3) 
i kombinasjon med prosedyrekode CKD05. 
\n \n
Legemiddelet aflibercept er identifisert ved hjelp av særkode (1LA05 eller S01LA05). 
\n \n
Når en kontakt er registrert med flere av de aktuelle diagnosekodene 
(f.eks AMD som hovedtilstand og veneokklusjon som bitilstand) er hoveddiagnose valgt.

\n\n Hvor pasienten er behandlet er delt inn i tre kategorier:\n
- Eget HF, behandlet ved et av sykehusene i opptaksområdet
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
\n \n
The sample consists of contacts for patients aged 50 years or older registered with a primary or secondary diagnosis of 
age-related macular degeneration, AMD (H35.3), venous occlusion (H34.8 or H34.9), 
or diabetic retinopathy (H36.0, E10.3, or E11.3) 
in combination with procedure code CKD05. 
\n \n
The drug aflibercept is identified using a special code (1LA05 or S01LA05). 
\n \n
When a contact is registered with two or more of the relevant diagnosis codes 
(e.g., AMD as the primary condition and venous occlusion as the secondary condition), 
the primary diagnosis is chosen.
\n \n
The place of treatment is divided into three categories:\n
- Local public, treated at one of the hospitals in the catchment area
\n - Other public, treated at a public hospital outside the catchment area
\n - Private, treated by a private hospital

\n\n
In order to compare the catchment areas and between years, the rates have been adjusted for gender and age. The adjustment was done using the direct method with the population in 2023 as the reference population.
\n\n
SKDE is solely responsible for the interpretation and presentation of the data provided by NPR. FHI/NPR is not responsible for analyses or interpretations based on the data.
;

%let no_summary=
- Fra 2015 til 2023 ble antall pasienter i behandling doblet mens antall kontakter ble mer enn doblet.
\n - Det er betydelig geografisk variasjon i bruk av det dyreste legemidlet, aflibercept
\n - Injeksjonsbehandling gis nesten utelukkende ved offentlige sykehus
;

%let en_summary=
- From 2015 to 2023 the number fo patients in treatment was doubled while the number of contacts was more than doubled. 
\n - There is significant geographical variation in the use of the most expensive drug, aflibercept
\n - Injection treatment is given almost exclusively at public hospitals
;

%let no_discussion=
Nasjonalt økte antall kontakter pr år fra 61 000 i 2015 til omlag 138 000 i 2023. 
Antall kontakter ble altså mer enn doblet fra 2015 til 2023 
mens antall pasienter i behandling ble doblet i samme periode. 
Antall kontakter pr pasient økte dermed fra 5,5 i 2015 til 6,3 i 2023. 
Dette er i tråd med funnene til [Husum et al. 2023](https://onlinelibrary.wiley.com/doi/10.1111/aos.16598) 
som undersøkte bruk av injeksjonsbehandling i perioden 2011 - 2021. 
\n \n
Injeksjonsbehandling i øyet er aktuelt for pasienter med aldersrelatert makuladegererasjon (AMD), 
diabetisk retinopati og veneokklusjon. Nasjonalt sank andelen kontakter med diagnose AMD fra 
omlag 78 % i 2015 til 73 % i 2023. I enkelte opptaksområder har imidlertid andelen økt i perioden. 
I opptaksområdene Bergen og Førde var andelen kontakter med diagnose diabetisk retinopati 
eller veneokklusjon svært lav i 2023. 
\n \n
De to mest brukte legemidlene er bevacizumab og aflibercept. Bevacizumab har betydelig lavere kostnad 
og er førstevalg de fleste steder ([Husum et al. 2023](https://onlinelibrary.wiley.com/doi/10.1111/aos.16598)).
Nasjonalt økte andelen kontakter med legemiddelet aflibercept fra 46 % i 2015 til 56 % i 2020, 
og sank deretter til 50 % i 2023. Andelen kontakter med aflibercept var i 2023 høyest i opptaksområdet 
Sørlandet (67,5 % av kontaktene) og lavest i opptaksområdet Stavanger (38 % av kontaktene). 
;

%let en_discussion=
Nationally, the number of contacts per year increased from 61,000 in 2015 to approximately 138,000 in 2023. 
The number of contacts was more than doubled from 2015 to 2023 while the 
number of patients in treatment was doubled in the same period. 
This means that the number of contacts per patient increased from 5.5 in 2015 to 6.3 in 2023. 
This is in accordance with the findings of [Husum et al. 2023](https://onlinelibrary.wiley.com/doi/10.1111/aos.16598), 
who examined the use of injection treatment from 2011 to 2021. 
\n \n
Injection treatment is relevant for patients with age-related macular degeneration (AMD), diabetic retinopathy, and vein occlusion.
Nationally, the proportion of contacts with the diagnosis AMD decreased from about 78 % in 2015 to 73 % in 2023. 
However, in some referral areas, the proportion of contacts with the diagnosis AMD has increased during the period. 
In the catchment areas of Bergen and Stavanger, the proportion of contacts with a diagnosis of diabetic retinopathy or vein occlusion was very low in 2023.
\n \n
The two most used drugs are bevacizumab and aflibercept. Bevacizumab has significantly lower costs 
and is the first choice in most places ([Husum et al. 2023](https://onlinelibrary.wiley.com/doi/10.1111/aos.16598)).
Nationally, the proportion of contacts with the drug aflibercept increased from 46 % in 2015 to 56 % in 2020, 
and then decreased to 50 % in 2023. The proportion of contacts with aflibercept was highest in the Sørlandet referral area 
(67.5 % of contacts) and lowest in the Stavanger referral area (38 % of contacts) in 2023.
;

%let no_title =
Injeksjonsbehandling (Antall kontakter, 50 år+)
;

%let en_title =
Injection treatment (Number of contacts, 50 yrs+)
;

%let no_description =
Antall kontakter pr 1000 innbyggere, 50 år eller eldre
;

%let en_description =
Number of contacts pr 1000 inhabitants, 50 years or older
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
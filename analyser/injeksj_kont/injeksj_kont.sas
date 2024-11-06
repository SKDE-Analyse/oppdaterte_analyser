%let oppdatering_filbane=/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser;
%let filbane=/sas_smb/skde_analyse/Data/SAS/felleskoder/main;

%include "&oppdatering_filbane/makroer/setup.sas";
%include "&filbane/makroer/beh_eget_annet_priv.sas";

%include "&filbane/stiler/anno_logo_kilde_npr_ssb.sas";
%let bildesti =/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser/Figurer/injeksjon/injeksjon_kont;

%let no_utvalg=
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
\n - Privat, behandlet ved et privat sykehus (med offentlig avtale) eller hos avtalespesialist 
;

%let en_utvalg=
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
\n - Private, treated by a private hospital or a private specialist under public funding contract
;

%let no_summary=
- Årlig antall kontakter økte mer enn årlig antall pasienter i perioden 2015-2023
\n - Det er betydelig geografisk variasjon i bruk av det dyreste legemidlet, aflibercept
\n - Injeksjonsbehandling gis nesten utelukkende ved offentlige sykehus
;

%let en_summary=
- The yearly number of contacts increased more than the yearly number of patients in the period 2015-2023
\n - There is significant geographical variation in the use of the most expensive drug, aflibercept
\n - Injection treatment is given almost exclusively at public hospitals
;

%let no_discussion=
Antall kontakter pr. år økte med en faktor på 2,25 fra ca 61 000 i 2015 til omlag 138 000 i 2023. 
Antall pasienter i behandling økte med en faktor på ca 2 i samme periode. Dette er i tråd med funnene 
til [Husum et al. 2023](https://onlinelibrary.wiley.com/doi/10.1111/aos.16598) som undersøkte bruk av 
injeksjonsbehandling i perioden 2011 - 2021. 
\n \n
Injeksjonsbehandling i øyet er aktuelt for pasienter med aldersrelatert makuladegererasjon (AMD), 
diabetisk retinopati og veneokklusjon. Nasjonalt sank andelen kontakter med diagnose AMD fra 
omlag 78% i 2015 til 73% i 2023. I enkelte opptaksområder har imidlertid andelen økt i perioden. 
I opptaksområdene Bergen og Førde var andelen kontakter med diagnose diabetisk retinopati 
eller veneokklusjon svært lav i 2023. 
\n \n
De to mest brukte legemidlene er bevacizumab og aflibercept. Bevacizumab har betydelig lavere kostnad 
og er førstevalg de fleste steder ([Husum et al. 2023](https://onlinelibrary.wiley.com/doi/10.1111/aos.16598)).
Nasjonalt økte andelen kontakter med legemiddelet aflibercept fra 46% i 2015 til 56% i 2020, 
og sank deretter til 50% i 2023. Andelen kontakter med aflibercept var i 2023 høyest i opptaksområdet 
Sørlandet (67,5% av kontaktene) og lavest i opptaksområdet Stavanger (38% av kontaktene). 
;

%let en_discussion=
The number of contacts per year increased by a factor of 2.25 from approximately 61,000 in 2015 to around 138,000 in 2023. 
The number of patients in treatment increased by a factor of about 2 in the same period. This is in line with the findings of 
[Husum et al. 2023](https://onlinelibrary.wiley.com/doi/10.1111/aos.16598), who examined the use of injection treatment from 2011 to 2021. 
\n \n
Injection treatment is relevant for patients with age-related macular degeneration (AMD), diabetic retinopathy, and vein occlusion.
Nationally, the proportion of contacts with the diagnosis AMD decreased from about 78% in 2015 to 73% in 2023. 
However, in some referral areas, the proportion of contacts with the diagnosis AMD has increased during the period. 
In the catchment areas of Bergen and Stavanger, the proportion of contacts with a diagnosis of diabetic retinopathy or vein occlusion was very low in 2023.
\n \n
The two most used drugs are bevacizumab and aflibercept. Bevacizumab has significantly lower costs 
and is the first choice in most places ([Husum et al. 2023](https://onlinelibrary.wiley.com/doi/10.1111/aos.16598)).
Nationally, the proportion of contacts with the drug aflibercept increased from 46% in 2015 to 56% in 2020, 
and then decreased to 50% in 2023. The proportion of contacts with aflibercept was highest in the Sørlandet referral area 
(67.5% of contacts) and lowest in the Stavanger referral area (38% of contacts) in 2023.
;

%let no_utvalg = %superq(no_utvalg);
%let en_utvalg = %superq(en_utvalg);
%let no_summary = %superq(no_summary);
%let en_summary = %superq(en_summary);
%let no_discussion = %superq(no_discussion);
%let en_discussion = %superq(en_discussion);

data injeksj_kont_utv;
  %NPR(avd,
    periode=2015-2023,
	 in_diag=H353 H360 E103 E113 H348 H349, /*AMD, blodpropp i netthinne, diabetisk retinopati*/
	 in_pros=CKD05,
	 where=alder in (50:105)
  );
  injeksjon = 1;	/*alle*/

  array diagnose {*} Hdiag: Bdiag:;
	do i=1 to dim(diagnose);
		if diagnose{i} in ('H353', 'H360', 'E103', 'E113', 'H348','H349')  then Injeksjon_d=1;
		if diagnose{i} eq 'H353'  then Injeksjon_AMD=1;
		if diagnose{i} in ('H348', 'H349')  then Injeksjon_RVO=1;
		if diagnose{i} in ('H360', 'E103', 'E113')  then Injeksjon_diab=1;
	end;

	array legem {*} NC: ATC:;
		do j=1 to dim(diagnose);
			if legem{j} in ('1XC07','L01XC07')  then bevac=1;
			if legem{j} in ('1LA05','S01LA05')  then afliber=1;
			if legem{j} in ('1LA04', 'S01LA04', '1BA01', 'S01BA01', '1XX02')  then andre_legem=1;
		end;

	/*Deler etter diagnose vha hdiag*/
	if hdiag eq 'H353'  then amd=1;
	if hdiag in ('H348', 'H349')  then rvo=1;
	if hdiag in ('H360', 'E103', 'E113')  then diab=1;
	if hdiag in ('H353', 'H360', 'E103', 'E113', 'H348','H349') then hdiag_sjekk=1;
	/*hvis ikke hdiag er en av disse blir det rangering 1. amd 2. diabetes 3. rvo*/
	if hdiag_sjekk ne 1 then do;
		if injeksjon_AMD eq 1 then amd=1;
		else if injeksjon_AMD ne 1 and injeksjon_diab eq 1 then diab=1;
		else if injeksjon_AMD ne 1 and injeksjon_diab ne 1 then rvo=1;
	end;

	if afliber eq 1 then afl=1; 
	else andre=1;

run;

/*Kjøre makro for å lage tredeling kn. til behandlingssted*/
%beh_eget_annet_priv(inndata=injeksj_kont_utv, utdata=injeksj_kont, as_data=0);


%oppdater(injeksj_kont,
   total=injeksjon,
   variables=amd diab rvo afl andre eget annet privat,
   force_update=true
);

%publiser_rate(injeksj_kont,
   total=injeksjon,
   custom_views=
	%define_view(
        name=diagnose, 
        variables=amd diab rvo,
        title=%str(no := Enkeltår, diagnose
                || en := Single year, diagnosis),
        label_1=no := AMD || en := nAMD,
        label_2=no := Diabetes || en := Diabetes,
        label_3=no := Karokklusjon || en := Vein Occlusion)
	%define_view(
        name=legemiddel, 
        variables=afl andre,
        title=%str(no := Enkeltår, legemiddel
                || en := Single year, drug),
        label_1=no := Aflibercept || en := Aflibercept,
        label_2=no := Annet || en := Other)
	%define_view(
        name=behandler, 
        variables=eget annet privat,
        title=%str(no := Enkeltår, behandler
                || en := Single year, public/private),
        label_1=no := Eget HF || en := Local public,
        label_2=no := Annet HF || en := Other public,
        label_3=no := Privat || en := Private),
   title=
      no := Injeksjonsbehandling (kontaktrate, 50 år+)
   || en := Injection treatment (contact rate, 50 yrs+),
   description=
      no := %str(Antall kontakter pr 1000 innbyggere, 50 år eller eldre)
   || en := %str(Number of contacts pr 1000 inhabitants, 50 years or older),
   info =
   no :=%nrstr(&no_utvalg)
|| en :=%nrstr(&en_utvalg),
   summary =
   no :=%nrstr(&no_summary)
|| en :=%nrstr(&en_summary),
   discussion=
   no := %nrstr(&no_discussion)   
|| en := %nrstr(&en_discussion),
   tags=eldre oye, 
   min_age=50, max_age=105
);

/*FIGURER TIL STØTTE I SKRIVINGEN UNDER HER:*/


data injeksjon;
set injeksj_kont;
run;

%let tema=injeksjon;
%let bildesti =/sas_smb/skde_analyse/helseatlas/oppdaterte_analyser/Figurer/injeksjon/injeksjon_kont;

/*Figurer og tabeller*/
%include "/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser/figurmakroer/panelfig.sas";
%panelfigur(tema=injeksjon);
%include "/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser/figurmakroer/panel_ny.sas";
%panelfigur_ny(tema=injeksjon, dim1=amd, dim2=diab, dim3=rvo, dimensjon=diagnose);
%include "/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser/figurmakroer/panel_ny_todelt.sas";
%panelfigur_ny_todelt(tema=injeksjon, dim1=afl, dim2=andre, dimensjon=legemiddel);
%include "/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser/figurmakroer/panel_total.sas";
%panelfigur_tot(tema=injeksjon);


%include "&filbane/rateprogram/graf.sas";
data pub_sykehus_rate2;
set pub_sykehus_rate;

andel_afl2023=afl_rate2023/injeksjon_rate2023;


andel_amd2015=amd_rate2015/injeksjon_rate2015;
andel_amd2016=amd_rate2016/injeksjon_rate2016;
andel_amd2017=amd_rate2017/injeksjon_rate2017;
andel_amd2018=amd_rate2018/injeksjon_rate2018;
andel_amd2019=amd_rate2019/injeksjon_rate2019;
andel_amd2020=amd_rate2020/injeksjon_rate2020;
andel_amd2021=amd_rate2021/injeksjon_rate2021;
andel_amd2022=amd_rate2022/injeksjon_rate2022;
andel_amd2023=amd_rate2023/injeksjon_rate2023;

format andel_afl2023 andel_amd2023 nlpct8.1;

run;

%graf(bars=pub_sykehus_rate2/injeksjon_rate2023 , category=bohf/bohf_fmt.,
table=pub_sykehus_rate2/injeksjon_rate2023 #Rate,
description=Injeksjoner pr 1000 innbyggere i 2023,
save="&bildesti/rate2023.png");

%graf(bars=pub_sykehus_rate2/andel_afl2023 , category=bohf/bohf_fmt.,
table=pub_sykehus_rate2/andel_afl2023 #Andel,
description=Andel aflibercept i 2023,
save="&bildesti/andel_afl2023.png");

%graf(bars=pub_sykehus_rate2/andel_amd2023 , category=bohf/bohf_fmt.,
table=pub_sykehus_rate2/andel_amd2023 #Andel,
description=Andel AMD i 2023,
save="&bildesti/andel_amd2023.png");

%graf(bars=pub_sykehus_rate2/andel_amd2015 , category=bohf/bohf_fmt.,
table=pub_sykehus_rate2/andel_amd2015 #Andel,
description=Andel AMD i 2015,
save="&bildesti/andel_amd2015.png");



/*SLETTE ALLE DATASETT I WORK */
proc datasets nolist library=WORK kill;
   run; quit;
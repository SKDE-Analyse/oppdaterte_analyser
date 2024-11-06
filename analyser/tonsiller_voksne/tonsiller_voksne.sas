%let oppdatering_filbane=/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser;
%let filbane=/sas_smb/skde_analyse/Data/SAS/felleskoder/main;
%include "&oppdatering_filbane/makroer/setup.sas";
%include "&filbane/makroer/beh_eget_annet_priv.sas";
%include "&filbane/stiler/anno_logo_kilde_npr_ssb.sas";

%let bildesti =/sas_smb/skde_analyse/helseatlas/oppdaterte_analyser/Figurer/tonsiller/tonsiller_voksne;

%include "/sas_smb/skde_analyse/helseatlas/oppdaterte_analyser/figurmakroer/panelfig.sas";
%include "/sas_smb/skde_analyse/helseatlas/oppdaterte_analyser/figurmakroer/rate_alder_kjonn.sas";

%let tema=tonsiller_voksne;

%let no_utvalg=
Utvalget består av pasienter i alderen 16 år eller eldre registrert med hoved- eller bidiagnose 
J35.0, J35.1, J35.3, J35.8, J35.9, J36, J39.0, J03.0, J03.8, J03.9 eller G47.3 i 
kombinasjon med:
\n - prosedyrekode EMB10, EMB12, EMB15, EMB20, EMB99 eller ENC40 
på sykehus eller 
\n - med takstkode K02a, K02e, K02f, K02g hos avtalespesialist 

\n\n Hvor pasienten er behandlet er delt inn i tre kategorier:
\n - Eget HF, behandlet ved et av sykehusene i opptaksområdet
\n - Annet HF, behandlet ved et sykehus utenfor opptaksområdet
\n - Privat, behandlet ved et privat sykehus (med offentlig avtale) eller hos avtalespesialist 
;

%let en_utvalg=
The sample consists of patients aged 16 years or older registered with a primary or secondary diagnosis of 
J35.0, J35.1, J35.3, J35.8, J35.9, J36, J39.0, J03.0, J03.8, J03.9, or G47.3 
in combination with: 
\n - procedure code EMB10, EMB12, EMB15, EMB20, EMB99, or ENC40 in hospitals or 
\n - fee code K02a, K02e, K02f, K02g with a specialist 

\n\n The place of treatment is divided into three categories:
\n - Local public, treated at one of the hospitals in the catchment area
\n - Other public, treated at a public hospital outside the catchment area
\n - Private, treated by a private hospital or a private specialist under public funding contract
;

%let no_summary = 
- Det er stor geografisk variasjon i operasjoner av mandler (tonsilleoperasjoner)
\n - Ratene var økende frem til pandemien, og er ennå ikke tilbake på 2019-nivå
\n - Ratene er omlag 50% høyere for kvinner enn for menn
;

%let en_summary = 
- There is significant geographic variation in tonsil surgeries
\n - The rates were increasing until the pandemic and have not yet returned to 2019 levels
\n - The rates are approximately 50% higher for women than for men
;

%let no_discussion = 
Det utføres om lag 5?000 tonsilleoperasjoner per år på pasienter 16 år og eldre. 
Antall operasjoner per år var økende i perioden før pandemien med en topp i 2019 hvor det ble utført nesten 6?000 operasjoner, 
i 2023 ble det utført 5?000 operasjoner.
\n\n 
Det er betydelig geografisk variasjon i operasjonsratene, opptaksområdene med høyest rate 
utfører om lag dobbelt så mange tonsilleoperasjoner per 1?000 innbygger sammenliknet med opptaksområdene som utfører færrest operasjoner.
\n\n 
Kvinner opereres i større grad enn menn, og gjennomsnittsalderen er ca. to år lavere for kvinner (26 år i 2023) enn menn (28 år i 2023)
ved operasjonstidspunktet. Gjennomsnittsalderen har falt i perioden, for både menn og kvinner. 
Reduksjonen i raten for opptaksområdet Bergen fra 2022 til 2023 skyldes sannsynligvis manglende innrapportering fra avtalespesialist i 2023.
;

%let en_discussion = 
Approximately 5?000 tonsil operations are performed annually on patients aged 16 and older. 
The number of operations per year was increasing in the period before the pandemic, peaking in 
2019 with nearly 6?000 operations. In 2023, 5?000 operations were performed.
\n\n
There is significant geographical variation in operation rates, with the areas with the highest 
rates performing about twice as many tonsil operations per 1?000 inhabitants compared to the areas with the lowest rates.
\n\n
Women are operated on more frequently than men, and the average age at the time of surgery 
is about two years lower for women (26 years in 2023) than for men (28 years in 2023). 
The average age has decreased over the period for both men and women. The reduction in 
the rate for the Bergen catchment area from 2022 to 2023 is likely due to a lack of reporting from contracted specialists in 2023.
;

%let no_utvalg = %superq(no_utvalg);
%let en_utvalg = %superq(en_utvalg);
%let no_summary = %superq(no_summary);
%let en_summary = %superq(en_summary);
%let no_discussion = %superq(no_discussion);
%let en_discussion = %superq(en_discussion);

data &tema._1;
  %NPR(avd,
  	 periode=2015-2023,
	 in_pros=EMB10 EMB12 EMB15 EMB20 EMB99 ENC40,
	 in_diag=J350 J351 J353 J358 J359 J36 J390 J030 J038 J039 G473,
	 where = alder in (16:105)	 
  );
  &tema. = 1;
run;

data &tema._2;
  %NPR(aspes,
     periode=2015-2023,
	 normaltariff=K02a K02e K02f K02g k02a k02e k02f k02g,
	 in_diag=J350 J351 J353 J358 J359 J36 J390 J030 J038 J039 G473,
	 where = alder in (16:105)
	   );
  &tema. = 1;
run;

data &tema._3;
  %NPR(aspes,
     periode=2015-2023,
	 in_pros=EMB10 EMB12 EMB15 EMB20 EMB99 ENC40,
	 in_diag=J350 J351 J353 J358 J359 J36 J390 J030 J038 J039 G473,
	 where = alder in (16:105)
	   );
  &tema. = 1;
run;

proc sort data=&tema._2;
by pid inndato utdato inntid uttid;
run;

proc sort data=&tema._3;
by pid inndato utdato inntid uttid;
run;

data &tema.23;
merge &tema._2(in=a) &tema._3(in=b);
by pid inndato utdato inntid uttid;
if a or b;
run;

data &tema._4;
set &tema._1 &tema.23;
run;

/*Hel vs delvis fjerning - Tonsillektomi vs Tonsillotomi*/
data &tema._4;
set &tema._4;
hel=0; del=0;
array Pros {*} NC:;
    do j=1 to dim(Pros); 
	if Pros{j} in ('EMB10', 'EMB20', 'ENC40') then hel=1;
	if Pros{j} in ('EMB12', 'EMB15', 'EMB99') then del=1;
end;
array normalt {*} normaltariff:;
    do i=1 to dim(normalt); 
	if normalt{i} in ('K02a', 'K02b', 'K02d', 'K02e', 'K02f', 'K02g', 'k02a', 'k02b', 'k02d', 'k02e', 'k02f', 'k02g') then hel=1;
end;
if hel=1 then del=0;
if hel=0 and del=0 then hel=1;
run;

proc sql;
select 
    sum(case when hel = 1 then 1 else 0 end) as hel,
    sum(case when del = 1 then 1 else 0 end) as del,
    sum(case when hel = 1 and del = 1 then 1 else 0 end) as begge,
    sum(case when hel = 0 and del = 0 then 1 else 0 end) as ingen,
	count(*) as alle
from &tema._4;
quit;


/*Kjøre makro for å lage tredeling kn. til behandlingssted*/
%beh_eget_annet_priv(inndata=&tema._4, utdata=&tema._3delt, as_data=1);

data &tema.;
set &tema._3delt;
run;

%oppdater(&tema.,
   total=&tema.,
	variables=eget annet privat hel del,
   force_update=true
);

%publiser_rate(&tema.,
   total=&tema.,
   custom_views=
     %define_view(
        name=behandler, 
        variables=eget annet privat,
        title=%str(no := Enkeltår, behandlingssted
                || en := Single year, public/private),
        label_1=no := Eget HF || en := Local public,
        label_2=no := Annet HF || en := Other public,
        label_3=no := Privat || en := Private)
		%define_view(
        name=metode, 
        variables=hel del,
        title=%str(no := Enkeltår, type inngrep
                || en := Single year, public/private),
        label_1=no := Tonsillektomi || en := Tonsillectomy,
        label_2=no := Tonsillotomi || en := Tonsillotomy),
   title=
      no := Operasjon av mandler (16 år og eldre)
   || en := Tonsil surgery (16 years and older),
	info =
   no :=%nrstr(&no_utvalg)
|| en :=%nrstr(&en_utvalg),
   summary=
      no := &no_summary. || en := &en_summary. ,
   discussion=%nrstr(
      no := &no_discussion. || en := &en_discussion. ),
   tags=voksne tonsillektomi ore-nese-hals
);

/*Figurer og tabeller*/
%panelfigur(tema=tonsiller_voksne);

%include "&filbane/rateprogram/graf.sas";
%graf(bars=Pub_sykehus_rate/&tema._Rate2023,
      category=bohf/bohf_fmt.,
	  save="&bildesti/&tema._2023rate.png")

data Pub_sykehus_rate;
set pub_sykehus_rate;
/*eget, annet, privat*/
eget_pct=(eget_Rate2023/&tema._Rate2023)*100;
annet_pct=(annet_Rate2023/&tema._Rate2023)*100;
privat_pct=(privat_Rate2023/&tema._Rate2023)*100;
eget_s_pct=(eget_Ratesnitt/&tema._Ratesnitt)*100;
annet_s_pct=(annet_Ratesnitt/&tema._Ratesnitt)*100;
privat_s_pct=(privat_Ratesnitt/&tema._Ratesnitt)*100;
/*Type: hel og del*/
hel_pct=(hel_Rate2023/&tema._Rate2023)*100;
del_pct=(del_Rate2023/&tema._Rate2023)*100;
hel_s_pct=(hel_Ratesnitt/&tema._Ratesnitt)*100;
del_s_pct=(del_Ratesnitt/&tema._Ratesnitt)*100;
run;

%graf(bars=Pub_sykehus_rate/eget_Rate2023 annet_rate2023 privat_rate2023,
table=Pub_sykehus_rate/&tema._Rate2023 eget_pct annet_pct privat_pct/8.1 8.1 8.1 8.1,
      category=bohf/bohf_fmt.,
	  save="&bildesti/&tema._Beh_andel2023rate.png")

%graf(bars=Pub_sykehus_rate/eget_Ratesnitt annet_ratesnitt privat_ratesnitt,
table=Pub_sykehus_rate/&tema._Ratesnitt eget_s_pct annet_pct privat_s_pct/8.1 8.1 8.1 8.1,
      category=bohf/bohf_fmt.,
	  save="&bildesti/&tema._Beh_andelsnittrate.png")

%graf(bars=Pub_sykehus_rate/hel_Rate2023 del_rate2023,
	table=Pub_sykehus_rate/&tema._Rate2023 hel_pct del_pct/8.1 8.1 8.1,
      category=bohf/bohf_fmt.,
	  save="&bildesti/&tema._type_andel2023rate.png")

%graf(bars=Pub_sykehus_rate/hel_Ratesnitt del_ratesnitt,
	table=Pub_sykehus_rate/&tema._Ratesnitt hel_s_pct del_s_pct/8.1 8.1 8.1,
      category=bohf/bohf_fmt.,
	  save="&bildesti/&tema._type_andelsnittrate.png")


%rate_alder_kjonn(aarmin=2015,aarmax=2023,aldermin=16,aldermax=105,kjonn=);


/*Panelfigur - hel og del*/
proc sql;
create table &tema._tab as
select a.*, 
b.hel_ant as hel_ant_n,
b.hel_rate as hel_rate_n,
b.del_ant as del_ant_n,
b.del_rate as del_rate_n
from &tema._tab as a
left join pub_sykehus_rate_long as b
on a.aar=b.aar
where b.bohf eq 8888 and a.bohf ne 8888;
quit;

/*hel-figur*/
ODS Graphics ON /reset=All imagename="&tema._panel_hel" imagefmt=png border=off height=800px width=1200px ;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgpanel data=&tema._tab noautolegend sganno=anno pad=(Bottom=5%);
PANELBY bohf / columns=7 rows=3 novarname spacing=2 HEADERATTRS=(Color=black Family=Arial Size=7);
vbarparm category= aar  response=hel_rate /fillattrs=(color=CX95BDE6);
series x=aar y=hel_rate_n /lineattrs=(color=black pattern=1 thickness=2) name="norge" legendlabel="Norge";
keylegend "norge" / noborder position=bottom;
colaxis label="&tema., Tonsillektomier (hel), rate pr 1 000 innbyggere" valueattrs=(size=5) labelattrs=(size=8 weight=bold);
rowaxis label=" ";
where aar ne 9999;
RUN; 
ods listing close; ods graphics off;

/*del-figur*/
ODS Graphics ON /reset=All imagename="&tema._panel_del" imagefmt=png border=off height=800px width=1200px ;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgpanel data=&tema._tab noautolegend sganno=anno pad=(Bottom=5%);
PANELBY bohf / columns=7 rows=3 novarname spacing=2 HEADERATTRS=(Color=black Family=Arial Size=7);
vbarparm category= aar  response=del_rate /fillattrs=(color=CX95BDE6);
series x=aar y=del_rate_n /lineattrs=(color=black pattern=1 thickness=2) name="norge" legendlabel="Norge";
keylegend "norge" / noborder position=bottom;
colaxis label="&tema., Tonsillotomier (delvis), rate pr 1 000 innbyggere" valueattrs=(size=5) labelattrs=(size=8 weight=bold);
rowaxis label=" ";
where aar ne 9999;
RUN; 
ods listing close; ods graphics off;

/*Hel og del - tidstrend*/
proc sql;
create table &tema._totant_type as
select distinct
aar, 
sum(case when del=1 then &tema. else 0 end) as del,
sum(case when hel=1 then &tema. else 0 end) as hel,
sum(&tema.) as total
from &tema._dsn
group by aar;
run; 

data &tema._totant_type;
set &tema._totant_type;
andel = (hel/total)*100;
format andel 8.1;
run;

ODS Graphics ON /reset=All imagename="&tema._antall_type" imagefmt=png border=off height=500px;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgplot data=&tema._totant_type noautolegend noborder;
    vline aar / response=hel stat=sum name="Hel" legendlabel="Hel";
	vline aar / response=del stat=sum name="Del" legendlabel="Delvis";
    keylegend "Hel" "Del" / location=inside position=top noborder title='' across=3;
    xaxis fitpolicy=thin offsetmin=0.035 label='År';
    xaxistable hel / label="Hel";  
    xaxistable del / label="Delvis";
	xaxistable total / label="Totalt";
	xaxistable andel / label="Andel hel"; 
    yaxis label="&tema., Antall pr. år i perioden (2015-2023)" 
          labelpos=top LABELATTRS=(Weight=Bold) min=0;
    format ermann ermann_fmt.;
    styleattrs datalinepatterns=(solid) datacontrastcolors=(darkred darkblue green);
run;
ods listing close;
ods graphics off;


/*kjører rate på nytt uten hel og del*/
%publiser_rate(&tema.,
   total=&tema.,
   custom_views=
     %define_view(
        name=behandler, 
        variables=eget annet privat,
        title=%str(no := Enkeltår, behandlingssted
                || en := Single year, public/private),
        label_1=no := Eget HF || en := Local public,
        label_2=no := Annet HF || en := Other public,
        label_3=no := Privat || en := Private),
   title=
      no := Operasjon av mandler (16 år og eldre)
   || en := Tonsil surgery (16 years and older),
   description=%str(
      no := Antall tonsilleoperasjoner pr 1?000 innbyggere, 16 år og eldre || en := Number of tonsil operations pr 1?000 inhabitants, 16 years and older),
   info =
   no :=%nrstr(&no_utvalg) || en :=%nrstr(&en_utvalg),
   summary=
      no := &no_summary. || en := &en_summary. ,
   discussion=%nrstr(
      no := &no_discussion. || en := &en_discussion. ),
   tags=voksne tonsillektomi ore-nese-hals
);






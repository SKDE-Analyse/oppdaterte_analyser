/*Utvalgsdefinisjon 
Type inngrep - tas ikke med 
Lapraskopi
JAA11 JAL21 JAL24 JAP01 LAC01 LAC11 LAC21 LAD01 LAE11 LAE21 LAF01 LAF11 LBD01 LBE01 LCD01 LCD04 LCD31 LCD97 LCF01 LCF97 LCC01 LCC11 LCC97
Åpen
JAA10 JAL20 JAP00 LAC00 LAC10 LAC20 LAD00 LAE10 LAE20 LAF00 LAF10 LBD00 LBE00 LCD00 LCD30 LCD96 LCF00 LCF96 LCC00 LCC10 LCC96
Vaginal
LAF20 LAF30 LCD10 LCD11 LCD40 LCC05 LCC20

Tverrfaglig kirurgi - tarm, blære og diafragma
Tarmkirurgi - JFF
Blære - KC
Diafragma - GX
*/



%let oppdatering_filbane=/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser;
%let filbane=/sas_smb/skde_analyse/Data/SAS/felleskoder/main;
%include "&oppdatering_filbane/makroer/setup.sas";
%include "&filbane/makroer/beh_eget_annet_priv.sas";
%include "&filbane/stiler/anno_logo_kilde_npr_ssb.sas";

%let bildesti =/sas_smb/skde_analyse/helseatlas/oppdaterte_analyser/Figurer/endometriose;

%include "/sas_smb/skde_analyse/helseatlas/oppdaterte_analyser/figurmakroer/panelfig.sas";
%include "/sas_smb/skde_analyse/helseatlas/oppdaterte_analyser/figurmakroer/rate_alder_kjonn.sas";

%let tema=endometriose;

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
The sample consists of patients aged 0-15 years registered with a primary or secondary diagnosis of 
J35.0, J35.1, J35.3, J35.8, J35.9, J36, J39.0, J03.0, J03.8, J03.9, or G47.3 
in combination with: 
\n - procedure code EMB10, EMB12, EMB15, EMB20, EMB99, or ENC40 in hospitals or 
\n - fee code K02a, K02e, K02f, K02g with a specialist 

\n\n Tonsil operations with only the procedure codes EMB12 or EMB15 and at the same time none of the 
other procedure codes or fee codes are defined as tonsillotomy. All other tonsil operations are defined as tonsillectomy. 
Tonsillotomies are also performed by specialists, but since the fee codes K02f and K02g are tonsillectomy/tonsillotomy, 
it is not possible to distinguish between tonsillectomy and tonsillotomy using the fee codes. K02a and K02e are tonsillectomy.

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
- There is significant geographical variation in tonsil operations
\n - The number of patients undergoing surgery per year has remained relatively stable over the period (except during the pandemic)
\n - The proportion procedures with tonsillotomy has increased from less than 10 % in 2015 to more than 40 % in 2023
;

/*1 000 000*/
/*0 000*/


%let no_discussion = 
Lorem ipsum  
;

%let en_discussion = 
Lorem ipsum
;

%let no_utvalg = %superq(no_utvalg);
%let en_utvalg = %superq(en_utvalg);
%let no_summary = %superq(no_summary);
%let en_summary = %superq(en_summary);
%let no_discussion = %superq(no_discussion);
%let en_discussion = %superq(en_discussion);

/*Endometriose
1. Skille på Hysterektomi og andre prosedyrer
2. Skille på åpne, vaginale og lapraskopiske
*/

data endo_1;
  %NPR(avd,
  	 periode=2015-2023,
	 in_diag=N80 N941 N944 N945 N946,
	 in_pros=LCD00 LCD30 LCD96 LCD10 LCD40 LCD01 LCD04 LCD11 LCD31 LCD97 LCC10 LCC11 LCC20 
		JAL21 JAL24 JAP00 JAP01 JAL20 JAL21 JAA10 JAA11 LAC00 LAC01 LAC10 LAC11 LAC20 LAC21 LCF00
		LCF01 LAD00 LAD01 LAE10 LAE11 LAE20 LAE21 LAF00 LAF01 LAF10 LAF11 LAF20 LAF30 LBD00
		LBD01 LBE00 LBE01 LCC00 LCC01 LCC05 LCC96 LCC97 LCF97 LCF96,
	where = alder in (16:55) and ermann=0 
  );
  endometriose = 1;
run;

/*Hystrektomi*/
data endo_2;
  %NPR(avd,
  	 periode=2015-2023,
	 in_diag=N80 N941 N944 N945 N946,
	 in_pros=LCD00 LCD30 LCD96 LCD10 LCD40 LCD01 LCD04 LCD11 LCD31 LCD97 LCC10 LCC11 LCC20,
	where = alder in (16:55) and ermann=0  
  );
  endo_hyst = 1;
run;

/*Andre pros*/
data endo_3;
  %NPR(avd,
  	 periode=2015-2023,
	 in_diag=N80 N941 N944 N945 N946,
	 in_pros=JAL21 JAL24 JAP00 JAP01 JAL20 JAL21 JAA10 JAA11 LAC00 LAC01 LAC10 LAC11 LAC20 LAC21 
		LCF00 LCF01 LAD00 LAD01 LAE10 LAE11 LAE20 LAE21 LAF00 LAF01 LAF10 LAF11 LAF20 LAF30 
		LBD00 LBD01 LBE00 LBE01 LCC00 LCC01 LCC05 LCC96 LCC97 LCF97 LCF96,
	where = alder in (16:55) and ermann=0  
  );
  endo_andre = 1;
run;

/*Tverrfaglig kirurgi*/
data endo_4;
  %NPR(avd,
  	 periode=2015-2023,
	 in_diag=N80 N941 N944 N945 N946,
	 in_pros=JF KC GX,
	where = alder in (16:55) and ermann=0 
  );
  tverr = 1;
run;

/*
Lapraskopi
JAA11 JAL21 JAL24 JAP01 LAC01 LAC11 LAC21 LAD01 LAE11 LAE21 LAF01 LAF11 LBD01 LBE01 LCD01 LCD04 LCD31 LCD97 LCF01 LCF97 LCC01 LCC11 LCC97

Åpen
JAA10 JAL20 JAP00 LAC00 LAC10 LAC20 LAD00 LAE10 LAE20 LAF00 LAF10 LBD00 LBE00 LCD00 LCD30 LCD96 LCF00 LCF96 LCC00 LCC10 LCC96

Vaginal
LAF20 LAF30 LCD10 LCD11 LCD40 LCC05 LCC20
*/

/*Lap*/
data endo_5;
  %NPR(avd,
  	 periode=2015-2023,
	 in_diag=N80 N941 N944 N945 N946,
	 in_pros=JAA11 JAL21 JAL24 JAP01 LAC01 LAC11 LAC21 LAD01 LAE11 LAE21 LAF01 LAF11 LBD01 LBE01 LCD01 LCD04 LCD31 LCD97 LCF01 LCF97 LCC01 LCC11 LCC97,
	where = alder in (16:55) and ermann=0 
  );
  lap = 1;
run;

/*Åpen*/
data endo_6;
  %NPR(avd,
  	 periode=2015-2023,
	 in_diag=N80 N941 N944 N945 N946,
	 in_pros=JAA10 JAL20 JAP00 LAC00 LAC10 LAC20 LAD00 LAE10 LAE20 LAF00 LAF10 LBD00 LBE00 LCD00 LCD30 LCD96 LCF00 LCF96 LCC00 LCC10 LCC96,
	where = alder in (16:55) and ermann=0  
  );
  apen = 1;
run;

/*Vaginal*/
data endo_7;
  %NPR(avd,
  	 periode=2015-2023,
	 in_diag=N80 N941 N944 N945 N946,
	 in_pros=LAF20 LAF30 LCD10 LCD11 LCD40 LCC05 LCC20,
	where = alder in (16:55) and ermann=0  
  );
  vaginal = 1;
run;

proc sort data=endo_1; by pid inndato utdato inntid uttid; run;
proc sort data=endo_2; by pid inndato utdato inntid uttid; run;
proc sort data=endo_3; by pid inndato utdato inntid uttid; run;
proc sort data=endo_4; by pid inndato utdato inntid uttid; run;
proc sort data=endo_5; by pid inndato utdato inntid uttid; run;
proc sort data=endo_6; by pid inndato utdato inntid uttid; run;
proc sort data=endo_7; by pid inndato utdato inntid uttid; run;

data endo;
    merge endo_1 (in=a)
          endo_2 (in=b)
          endo_3 (in=c)
		  endo_4 (in=d)
          endo_5 (in=e)
		  endo_6 (in=f)
          endo_7 (in=g);
    by pid inndato utdato inntid uttid;
    if a;
run;

proc sql;
   create table endo1 as
   select 
       a.*, 
       b.endo_hyst, 
       c.endo_andre
   from endo_1 as a
   left join endo_2 as b
   on a.pid = b.pid
   and a.inndato = b.inndato
   and a.utdato = b.utdato
   and a.inntid = b.inntid
   and a.uttid = b.uttid
   left join endo_3 as c
   on a.pid = c.pid
   and a.inndato = c.inndato
   and a.utdato = c.utdato
   and a.inntid = c.inntid
   and a.uttid = c.uttid;
quit;

data endo;
set endo;
if endo_hyst=1 then endo_andre=.;
if endo_hyst=. then endo_hyst=0;
if endo_andre=. then endo_andre=0;
if tverr=. then tverr=0;
ikke_tverr=1;
if tverr=1 then ikke_tverr=0;
run;

/*Kjøre makro for å lage tredeling kn. til behandlingssted*/
%beh_eget_annet_priv(inndata=endo, utdata=&tema._3delt, as_data=0);

data &tema.;
set &tema._3delt;
run;

%oppdater(&tema.,
   total=&tema.,
	variables=endo_hyst endo_andre eget annet privat ikke_tverr tverr,
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
        variables=endo_hyst endo_andre,
        title=%str(no := Enkeltår, type inngrep
                || en := Single year, procedure type),
        label_1=no := Hysterektomi || en := Hysterectomy,
        label_2=no := Andre inngrep || en := Other)
		%define_view(
        name=type, 
        variables=ikke_tverr tverr,
        title=%str(no := Enkeltår, type inngrep
                || en := Single year, procedure type),
        label_1=no := Ikke tverr || en := Hysterectomy,
        label_2=no := tverr || en := Other)
,
   title=
      no := Kirurgiske inngrep for endometriose
   || en := Tonsil surgery (0-15 years),
   description=%str(
      no := Antall inngrep pr 1000 kvinner, 16-55 år || en := Number of procedures per 1000 women, 16-55 years),
   info =
   no :=%nrstr(&no_utvalg)
|| en :=%nrstr(&en_utvalg),
   summary=
      no := &no_summary. || en := &en_summary. ,
   discussion=%nrstr(
      no := &no_discussion. || en := &en_discussion. ),
   tags=kvinner endometriose
);

/*Figurer og tabeller*/
%panelfigur(tema=endometriose);

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
hyst_pct=(endo_hyst_Rate2023/&tema._Rate2023)*100;
andre_pct=(endo_andre_Rate2023/&tema._Rate2023)*100;
hyst_s_pct=(endo_hyst_Ratesnitt/&tema._Ratesnitt)*100;
andre_s_pct=(endo_andre_Ratesnitt/&tema._Ratesnitt)*100;
run;

%graf(bars=Pub_sykehus_rate/eget_Rate2023 annet_rate2023 privat_rate2023,
table=Pub_sykehus_rate/&tema._Rate2023 eget_pct annet_pct privat_pct/8.1 8.1 8.1 8.1,
      category=bohf/bohf_fmt.,
	  save="&bildesti/&tema._Beh_andel2023rate.png")

%graf(bars=Pub_sykehus_rate/eget_Ratesnitt annet_ratesnitt privat_ratesnitt,
table=Pub_sykehus_rate/&tema._Ratesnitt eget_s_pct annet_pct privat_s_pct/8.1 8.1 8.1 8.1,
      category=bohf/bohf_fmt.,
	  save="&bildesti/&tema._Beh_andelsnittrate.png")

%graf(bars=Pub_sykehus_rate/endo_hyst_Rate2023 endo_andre_rate2023,
	table=Pub_sykehus_rate/&tema._Rate2023 hyst_pct andre_pct/8.1 8.1 8.1,
      category=bohf/bohf_fmt.,
	  save="&bildesti/&tema._type_andel2023rate.png")

%graf(bars=Pub_sykehus_rate/endo_hyst_Ratesnitt endo_andre_ratesnitt,
	table=Pub_sykehus_rate/&tema._Ratesnitt hyst_s_pct andre_s_pct/8.1 8.1 8.1,
      category=bohf/bohf_fmt.,
	  save="&bildesti/&tema._type_andelsnittrate.png")


%rate_alder_kjonn(aarmin=2015,aarmax=2023,aldermin=16,aldermax=55,kjonn=0);

/*Panelfigur - hel og del*/
proc sql;
create table &tema._tab as
select a.*, 
b.endo_hyst_ant as hyst_ant_n,
b.endo_hyst_rate as hyst_rate_n,
b.endo_andre_ant as andre_ant_n,
b.endo_andre_rate as andre_rate_n
from &tema._tab as a
left join pub_sykehus_rate_long as b
on a.aar=b.aar
where b.bohf eq 8888 and a.bohf ne 8888;
quit;


/*hel-figur*/
ODS Graphics ON /reset=All imagename="&tema._panel_hyst" imagefmt=png border=off height=800px width=1200px ;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgpanel data=&tema._tab noautolegend sganno=anno pad=(Bottom=5%);
PANELBY bohf / columns=7 rows=3 novarname spacing=2 HEADERATTRS=(Color=black Family=Arial Size=7);
vbarparm category= aar  response=endo_hyst_rate /fillattrs=(color=CX95BDE6);
series x=aar y=hyst_rate_n /lineattrs=(color=black pattern=1 thickness=2) name="norge" legendlabel="Norge";
keylegend "norge" / noborder position=bottom;
colaxis label="&tema., Hystrektomier, rate pr 1 000 innbyggere" valueattrs=(size=5) labelattrs=(size=8 weight=bold);
rowaxis label=" ";
where aar ne 9999;
RUN; 
ods listing close; ods graphics off;

/*del-figur*/
ODS Graphics ON /reset=All imagename="&tema._panel_andre" imagefmt=png border=off height=800px width=1200px ;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgpanel data=&tema._tab noautolegend sganno=anno pad=(Bottom=5%);
PANELBY bohf / columns=7 rows=3 novarname spacing=2 HEADERATTRS=(Color=black Family=Arial Size=7);
vbarparm category= aar  response=endo_andre_rate /fillattrs=(color=CX95BDE6);
series x=aar y=andre_rate_n /lineattrs=(color=black pattern=1 thickness=2) name="norge" legendlabel="Norge";
keylegend "norge" / noborder position=bottom;
colaxis label="&tema., andre, rate pr 1 000 innbyggere" valueattrs=(size=5) labelattrs=(size=8 weight=bold);
rowaxis label=" ";
where aar ne 9999;
RUN; 
ods listing close; ods graphics off;

/*Hel og del - tidstrend*/
proc sql;
create table &tema._totant_type as
select distinct
aar, 
sum(case when endo_hyst=1 then &tema. else 0 end) as hyst,
sum(case when endo_andre=1 then &tema. else 0 end) as andre,
sum(&tema.) as total
from &tema._dsn
group by aar;
run; 

data &tema._totant_type;
set &tema._totant_type;
andel = (hyst/total)*100;
format andel 8.1;
run;

ODS Graphics ON /reset=All imagename="&tema._antall_type" imagefmt=png border=off height=500px;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgplot data=&tema._totant_type noautolegend noborder;
    vline aar / response=hyst stat=sum name="Hystrektomi" legendlabel="Hystrektomi";
	vline aar / response=andre stat=sum name="Andre" legendlabel="Andre";
    keylegend "Hystrektomi" "Andre" / location=inside position=top noborder title='' across=3;
    xaxis fitpolicy=thin offsetmin=0.035 label='År';
    xaxistable hyst / label="Hystrektomi";  
    xaxistable andre / label="Andre";
	xaxistable total / label="Totalt";
	xaxistable andel / label="Andel hystrektomi"; 
    yaxis label="&tema., Antall pr år i perioden (2015-2023)" 
          labelpos=top LABELATTRS=(Weight=Bold) min=0;
    format ermann ermann_fmt.;
    styleattrs datalinepatterns=(solid) datacontrastcolors=(darkred darkblue green);
run;
ods listing close;
ods graphics off;


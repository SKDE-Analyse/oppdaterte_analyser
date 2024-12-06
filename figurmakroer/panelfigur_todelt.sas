%macro panelfigur_todelt(dim1=,dim2=,dimensjon=);
        
/*!
Dokumentasjon av makroen panelfigur_todelt
Opprettet 21.november 2024 av Frank Olsen

dim1 og dim2 er variabelene man ønsker å se spesifikt på
dimensjon er hva dim1 og dim2 viser

Makroen brukes i oppdaterte analyser.
Makroen lager 6 figurer:
- Panelfigur, rater dim1: &tema._panel_&dim1
- Panelfigur, rater dim2: &tema._panel_&dim2
- Todelt søylediagram første år: &tema._&dimensjon._andel&startaar.rate
- Todelt søylediagram siste år: &tema._&dimensjon._andel&sluttaar.rate
- Todelt søylediagram snitt i perioden: &tema._&dimensjon._andel_snitt_rate
- Antall over tid pr dim: &tema._antall_&dimensjon
*/

/***Panelfigurer***/
data &tema._tabn;
set pub_sykehus_rate_long;
where bohf=8888;
run;

proc sql;
create table &tema._tab as
select a.*, 
b.&tema._ant as ant_n,
b.&tema._rate as rate_n,
b.&dim1._ant as dim1_ant_n,
b.&dim1._rate as dim1_rate_n,
b.&dim2._ant as dim2_ant_n,
b.&dim2._rate as dim2_rate_n
from pub_sykehus_rate_long as a
left join pub_sykehus_rate_long as b
on a.aar=b.aar
where b.bohf eq 8888 and a.bohf ne 8888;
quit;

/*&dim1-figur*/
ODS Graphics ON /reset=All imagename="&tema._panel_&dim1" imagefmt=png border=off height=800px width=1200px ;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgpanel data=&tema._tab noautolegend sganno=anno pad=(Bottom=5%);
PANELBY bohf / columns=7 rows=3 novarname spacing=2 HEADERATTRS=(Color=black Family=Arial Size=7);
vbarparm category= aar  response=&dim1._rate /fillattrs=(color=CX95BDE6);
series x=aar y=dim1_rate_n /lineattrs=(color=black pattern=1 thickness=2) name="norge" legendlabel="Norge";
keylegend "norge" / noborder position=bottom;
colaxis label="&tema., &dim1 , rate pr 1 000 innbyggere" valueattrs=(size=5) labelattrs=(size=8 weight=bold);
rowaxis label=" ";
where aar ne 9999 and bohf ne 8888;
RUN; 
ods listing close; ods graphics off;

/*&dim2-figur*/
ODS Graphics ON /reset=All imagename="&tema._panel_&dim2" imagefmt=png border=off height=800px width=1200px ;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgpanel data=&tema._tab noautolegend sganno=anno pad=(Bottom=5%);
PANELBY bohf / columns=7 rows=3 novarname spacing=2 HEADERATTRS=(Color=black Family=Arial Size=7);
vbarparm category= aar  response=&dim2._rate /fillattrs=(color=CX95BDE6);
series x=aar y=dim2_rate_n /lineattrs=(color=black pattern=1 thickness=2) name="norge" legendlabel="Norge";
keylegend "norge" / noborder position=bottom;
colaxis label="&tema., &dim2 , rate pr 1 000 innbyggere" valueattrs=(size=5) labelattrs=(size=8 weight=bold);
rowaxis label=" ";
where aar ne 9999 and bohf ne 8888;
RUN; 
ods listing close; ods graphics off;

data &tema._tab2;
set &tema._tab &tema._tabn;
run;

data &tema._tab2;
set &tema._tab2;
&dim1._pct=(&dim1._Rate/&tema._Rate)*100;
&dim2._pct=(&dim2._Rate/&tema._Rate)*100;
run;

data &tema._tab_&startaar;
set &tema._tab2;
where aar=&startaar;
run;

data &tema._tab_&sluttaar;
set &tema._tab2;
where aar=&sluttaar;
run;

data &tema._tab_snitt;
set &tema._tab2;
where aar=9999;
run;

%graf(bars=&tema._tab_&startaar/&dim1._Rate &dim2._rate,
	table=&tema._tab_&startaar/&tema._Rate &dim1._pct &dim2._pct/8.1 8.1 8.1,
      category=bohf/bohf_fmt.,
      description="Rate pr &startaar",
	  save="&bildesti/&tema._&dimensjon._andel&startaar.rate.png")

%graf(bars=&tema._tab_&sluttaar/&dim1._Rate &dim2._rate,
	table=&tema._tab_&sluttaar/&tema._Rate &dim1._pct &dim2._pct/8.1 8.1 8.1,
      category=bohf/bohf_fmt.,
      description="Rate pr &sluttaar",
	  save="&bildesti/&tema._&dimensjon._andel&sluttaar.rate.png")

%graf(bars=&tema._tab_snitt/&dim1._Rate &dim2._rate,
	table=&tema._tab_snitt/&tema._Rate &dim1._pct &dim2._pct/8.1 8.1 8.1,
      category=bohf/bohf_fmt.,
      description="Rate snitt i perioden",
	  save="&bildesti/&tema._&dimensjon._andel_snitt_rate.png")

/***Aldersfigur***/
proc format;
value ermann_fmt 
0 = "Kvinner"
1 = "Menn";
run;

data &tema._dsn;
set &tema.;
where borhf in (1:4);
format ermann ermann_fmt.;
run;

proc sql;
create table &tema._totant as
select distinct
aar, 
sum(case when ermann=0 then &tema. else 0 end) as kvinner,
sum(case when ermann=1 then &tema. else 0 end) as menn,
sum(&tema.) as total,
sum(case when &dim1=1 then &tema. else 0 end) as dim1,
sum(case when &dim2=1 then &tema. else 0 end) as dim2,
(calculated dim1 / calculated total) * 100 as andel_dim1,
(calculated dim2 / calculated total) * 100 as andel_dim2
from &tema._dsn
group by aar;
run; 

ODS Graphics ON /reset=All imagename="&tema._antall_&dimensjon" imagefmt=png border=off height=500px;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgplot data=&tema._totant noautolegend noborder;
    vline aar / response=dim1 stat=sum name="&dim1" legendlabel="&dim1";
    vline aar / response=dim2 stat=sum name="&dim2" legendlabel="&dim2";
    keylegend "&dim1" "&dim2"/ location=inside position=top noborder title='' across=3;
    xaxis fitpolicy=thin offsetmin=0.035 label='År';
    xaxistable dim1 / label="&dim1";  
    xaxistable dim2 / label="&dim2";
    xaxistable total / label="Totalt"; 
    xaxistable andel_dim1 / label="% &dim1";
    xaxistable andel_dim2 / label="% &dim2";
    yaxis label="&tema., Antall pr. år i perioden (&startaar.-&sluttaar.)" 
            labelpos=top LABELATTRS=(Weight=Bold) min=0;
    format ermann ermann_fmt. andel_dim1 andel_dim2 8.1;
    styleattrs datalinepatterns=(solid) datacontrastcolors=(darkred darkblue green);
run;
ods listing close;
ods graphics off;

/*PDF tabell*/
proc format;
value dim_fmt
1 = "&dim1"
2 = "&dim2";
    picture pctfmt (round)
        low-high = '009.9%' (mult=10);
run;

data &tema._dsn;
set &tema._dsn;
if &dim1 = 1 then dimm=1;
if &dim2 = 1 then dimm=2;
format dimm dim_fmt.;
run;

ODS PDF FILE = "&bildesti./tabeller_&dimensjon._&tema..pdf" notoc startpage=no;
/*Tabell dimmensjon*/
PROC TABULATE DATA=&tema._dsn;	
VAR &tema.;
CLASS aar dimm / ORDER=UNFORMATTED MISSING;
TABLE 
dimm={LABEL=""} ALL={LABEL="Totalt"},
Sum={LABEL=""}*&tema.={LABEL="&tema., antall"}*F=BEST8.*(aar={LABEL=""} ALL={LABEL="Totalt"});
RUN;

/*tabell %*/
PROC TABULATE DATA=&tema._dsn;	
VAR &tema.;
CLASS aar dimm / ORDER=UNFORMATTED MISSING;
TABLE 
dimm={LABEL=""},
ColPctSum={LABEL=""}*F=pctfmt.*&tema.={LABEL="&tema., prosent"}*(aar={LABEL=""} ALL={LABEL="Totalt"});
RUN;
ODS PDF CLOSE;

proc datasets library=work nolist;
    delete &tema._totant &tema._dsn &tema._tab: _SGSRT2_;
quit;

%mend panelfigur_todelt;
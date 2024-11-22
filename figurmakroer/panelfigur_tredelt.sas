%macro panelfigur_tredelt(dim1=,dim2=,dim3=,dimensjon=);

/*!
Dokumentasjon av makroen panelfigur_tredelt
Opprettet 21.november 2024 av Frank Olsen

dim1, dim2 og dim3 er variabelene man ønsker å se spesifikt på
dimensjon er hva dim1-3

Makroen brukes i oppdaterte analyser.
Makroen lager 7 figurer:
- Panelfigur, rater dim1: &tema._panel_&dim1
- Panelfigur, rater dim2: &tema._panel_&dim2
- Panelfigur, rater dim3: &tema._panel_&dim3
- Tredelt søylediagram første år: &tema._&dimensjon._andel&startaar.rate
- Tredelt søylediagram siste år: &tema._&dimensjon._andel&sluttaar.rate
- Tredelt søylediagram snitt i perioden: &tema._&dimensjon._andel_snitt_rate
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
b.&dim1._ant as &dim1._ant_n,
b.&dim1._rate as &dim1._rate_n,
b.&dim2._ant as &dim2._ant_n,
b.&dim2._rate as &dim2._rate_n,
b.&dim3._ant as &dim3._ant_n,
b.&dim3._rate as &dim3._rate_n
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
series x=aar y=&dim1._rate_n /lineattrs=(color=black pattern=1 thickness=2) name="norge" legendlabel="Norge";
keylegend "norge" / noborder position=bottom;
colaxis label="&tema., &dim1 , rate pr 1 000 innbyggere" valueattrs=(size=5) labelattrs=(size=8 weight=bold);
rowaxis label=" ";
where aar ne 9999;
RUN; 
ods listing close; ods graphics off;

/*&dim2-figur*/
ODS Graphics ON /reset=All imagename="&tema._panel_&dim2" imagefmt=png border=off height=800px width=1200px ;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgpanel data=&tema._tab noautolegend sganno=anno pad=(Bottom=5%);
PANELBY bohf / columns=7 rows=3 novarname spacing=2 HEADERATTRS=(Color=black Family=Arial Size=7);
vbarparm category= aar  response=&dim2._rate /fillattrs=(color=CX95BDE6);
series x=aar y=&dim2._rate_n /lineattrs=(color=black pattern=1 thickness=2) name="norge" legendlabel="Norge";
keylegend "norge" / noborder position=bottom;
colaxis label="&tema., &dim2 , rate pr 1 000 innbyggere" valueattrs=(size=5) labelattrs=(size=8 weight=bold);
rowaxis label=" ";
where aar ne 9999;
RUN; 
ods listing close; ods graphics off;

/*&dim3-figur*/
ODS Graphics ON /reset=All imagename="&tema._panel_&dim3" imagefmt=png border=off height=800px width=1200px ;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgpanel data=&tema._tab noautolegend sganno=anno pad=(Bottom=5%);
PANELBY bohf / columns=7 rows=3 novarname spacing=2 HEADERATTRS=(Color=black Family=Arial Size=7);
vbarparm category= aar  response=&dim3._rate /fillattrs=(color=CX95BDE6);
series x=aar y=&dim3._rate_n /lineattrs=(color=black pattern=1 thickness=2) name="norge" legendlabel="Norge";
keylegend "norge" / noborder position=bottom;
colaxis label="&tema., &dim3, rate pr 1 000 innbyggere" valueattrs=(size=5) labelattrs=(size=8 weight=bold);
rowaxis label=" ";
where aar ne 9999;
RUN; 
ods listing close; ods graphics off;

data &tema._tab2;
set &tema._tab &tema._tabn;
run;

data &tema._tab2;
set &tema._tab2;
&dim1._pct=(&dim1._Rate/&tema._Rate)*100;
&dim2._pct=(&dim2._Rate/&tema._Rate)*100;
&dim3._pct=(&dim3._Rate/&tema._Rate)*100;
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

%graf(bars=&tema._tab_&startaar/&dim1._Rate &dim2._rate &dim3._rate,
	table=&tema._tab_&startaar/&tema._Rate &dim1._pct &dim2._pct &dim3._pct/8.1 8.1 8.1 8.1,
      category=bohf/bohf_fmt.,
      description="Rate pr &startaar",
	  save="&bildesti/&tema._&dimensjon._andel&startaar.rate.png")

%graf(bars=&tema._tab_&sluttaar/&dim1._Rate &dim2._rate &dim3._rate,
	table=&tema._tab_&sluttaar/&tema._Rate &dim1._pct &dim2._pct &dim3._pct/8.1 8.1 8.1 8.1,
      category=bohf/bohf_fmt.,
      description="Rate pr &sluttaar",
	  save="&bildesti/&tema._&dimensjon._andel&sluttaar.rate.png")

%graf(bars=&tema._tab_snitt/&dim1._Rate &dim2._rate &dim3._rate,
	table=&tema._tab_snitt/&tema._Rate &dim1._pct &dim2._pct &dim3._pct/8.1 8.1 8.1 8.1,
      category=bohf/bohf_fmt.,
      description="Rate snitt i perioden",
	  save="&bildesti/&tema._&dimensjon._andel_snitt_rate.png")

/***Aldersfigur***/
data &tema._dsn;
set &tema.;
where borhf in (1:4);
run;

proc format;
value ermann_fmt 
0 = "Kvinner"
1 = "Menn";
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
sum(case when &dim3=1 then &tema. else 0 end) as dim3,
(calculated dim1 / calculated total) * 100 as andel_dim1,
(calculated dim2 / calculated total) * 100 as andel_dim2,
(calculated dim3 / calculated total) * 100 as andel_dim3
from &tema._dsn
group by aar;
run; 

ODS Graphics ON /reset=All imagename="&tema._antall_&dimensjon" imagefmt=png border=off height=500px;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgplot data=&tema._totant noautolegend noborder;
    vline aar / response=dim1 stat=sum name="&dim1" legendlabel="&dim1";
    vline aar / response=dim2 stat=sum name="&dim2" legendlabel="&dim2";
    vline aar / response=dim3 stat=sum name="&dim3" legendlabel="&dim3";
    keylegend "&dim1" "&dim2" "&dim3"/ location=inside position=top noborder title='' across=3;
    xaxis fitpolicy=thin offsetmin=0.035 label='År';
    xaxistable dim1 / label="&dim1";  
    xaxistable dim2 / label="&dim2";
    xaxistable dim3 / label="&dim3";
    xaxistable total / label="Totalt";
    xaxistable andel_dim1 / label="% &dim1";
    xaxistable andel_dim2 / label="% &dim2";
    xaxistable andel_dim3 / label="% &dim3";
    yaxis label="&tema., Antall pr. år i perioden (&startaar.-&sluttaar.)" 
            labelpos=top LABELATTRS=(Weight=Bold) min=0;
    format ermann ermann_fmt. andel_dim1 andel_dim2 andel_dim2 8.1;
    styleattrs datalinepatterns=(solid) datacontrastcolors=(darkred darkblue green);
run;
ods listing close;
ods graphics off;

proc datasets library=work nolist;
    delete &tema._totant &tema._dsn &tema._tab: _SGSRT2_;
quit;

%mend panelfigur_tredelt;
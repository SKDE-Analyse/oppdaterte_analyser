
%macro total_figurer;

/*!
Dokumentasjon av makroen total_figurer
Opprettet 20.november 2024 av Frank Olsen

Makroen brukes i oppdaterte analyser.
Makroen lager 6 figurer:
- Panelfigur, rater totalt: &tema._panel_total
- Panelfigur, aldersprofil pr år: &tema._aldersprofil_aar
- Aldersprofil pr kjønn: &tema._aldersprofil
- Snittalder over tid pr kjønn: &tema._snittalder
- Antall over tid pr kjønn: &tema._antall_kjonn
- Forholdstall: &tema._forholdstall
*/

/***Panelfigur***/
data &tema._tabn;
set pub_sykehus_rate_long;
where bohf=8888;
run;

proc sql;
create table &tema._tab as
select a.*, 
b.&tema._ant as ant_n,
b.&tema._rate as rate_n
from pub_sykehus_rate_long as a
left join pub_sykehus_rate_long as b
on a.aar=b.aar
where b.bohf eq 8888 and a.bohf ne 8888;
quit;

/*Total-figur*/
ODS Graphics ON /reset=All imagename="&tema._panel_total" imagefmt=png border=off height=800px width=1200px ;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgpanel data=&tema._tab noautolegend sganno=anno pad=(Bottom=5%);
PANELBY bohf / columns=7 rows=3 novarname spacing=2 HEADERATTRS=(Color=black Family=Arial Size=7);
vbarparm category= aar  response=&tema._rate /fillattrs=(color=CX95BDE6);
series x=aar y=rate_n /lineattrs=(color=black pattern=1 thickness=2) name="norge" legendlabel="Norge";
keylegend "norge" / noborder position=bottom;
colaxis label="&tema., rate pr 1 000 innbyggere" valueattrs=(size=5) labelattrs=(size=8 weight=bold);
rowaxis label=" ";
where aar ne 9999;
RUN; 
ods listing close; ods graphics off;


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
create table &tema._aldtab_aar as
select distinct
alder, aar, 
sum(case when ermann=0 then &tema. else 0 end) as kvinner,
sum(case when ermann=1 then &tema. else 0 end) as menn,
sum(&tema.) as total
from &tema._dsn
group by alder, aar;
run; 

ODS Graphics ON /reset=All imagename="&tema._aldersprofil_aar" imagefmt=png border=off height=500px;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgpanel data=&tema._aldtab_aar noautolegend /*sganno=anno pad=(Bottom=5%)*/;
PANELBY aar / columns=3 rows=3 novarname spacing=2 HEADERATTRS=(Color=black Family=Arial Size=7);
vline alder / response=kvinner stat=sum name="Kvinner" legendlabel="Kvinner";
vline alder / response=menn stat=sum name="Menn" legendlabel="Menn";
/*keylegend "norge" / noborder position=bottom;*/
rowaxis label="Antall, &tema.";
colaxis label="Alder, Kvinner(rød), Menn (blå)" valueshint;
styleattrs datalinepatterns=(solid) datacontrastcolors=(darkred darkblue);
where aar ne 9999;
run;
ods listing close; ods graphics off;

proc sql;
create table &tema._aldtab as
select distinct
alder, 
sum(case when ermann=0 then &tema. else 0 end) as kvinner,
sum(case when ermann=1 then &tema. else 0 end) as menn,
sum(&tema.) as total
from &tema._dsn
group by alder;
run; 

ODS Graphics ON /reset=All imagename="&tema._aldersprofil" imagefmt=png border=off height=500px;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgplot data=&tema._aldtab noautolegend noborder /*sganno=anno pad=(Bottom=5%)*/;
vline alder / response=kvinner stat=sum name="Kvinner" legendlabel="Kvinner";
vline alder / response=menn stat=sum name="Menn" legendlabel="Menn";
keylegend / location=inside position=topright noborder title='' across=1;
xaxis fitpolicy=thin offsetmin=0.035  label='Alder' ;
xaxistable kvinner / label="Kvinner";  
xaxistable menn / label="Menn";
xaxistable total / label="Totalt"; 
yaxis label="&tema., Antall totalt i perioden (&startaar.-&sluttaar.)" labelpos=top LABELATTRS=(Weight=Bold);
format ermann ermann_fmt.;
styleattrs datalinepatterns=(solid) datacontrastcolors=(darkred darkblue);
run;
ods listing close; ods graphics off;

proc sql;
create table &tema._aldtab_aar2 as
select distinct aar,
sum(kvinner) as kvinner,
sum(menn) as menn,
sum(total) as total,
sum(kvinner)/sum(total) as andel_kvinner format=percent8.0,
sum(menn)/sum(total) as andel_menn format=percent8.0
from &tema._aldtab_aar
group by aar;
quit;

ODS Graphics ON /reset=All imagename="&tema._antall_kjonn" imagefmt=png border=off height=500px;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgplot data=&tema._aldtab_aar2 noautolegend noborder /*sganno=anno pad=(Bottom=5%)*/;
vline aar / response=kvinner stat=sum name="Kvinner" legendlabel="Kvinner";
vline aar / response=menn stat=sum name="Menn" legendlabel="Menn";
keylegend / location=inside position=topright noborder title='' across=1;
xaxis fitpolicy=thin offsetmin=0.035  label='År' ;
xaxistable kvinner / label="Kvinner";  
xaxistable menn / label="Menn";
xaxistable total / label="Totalt"; 
xaxistable andel_kvinner / label="% Kvinner";  
xaxistable andel_menn / label="% Menn";
yaxis label="&tema., Antall pr. år i perioden (&startaar.-&sluttaar.)" 
          labelpos=top LABELATTRS=(Weight=Bold) min=0;
format ermann ermann_fmt.;
styleattrs datalinepatterns=(solid) datacontrastcolors=(darkred darkblue);
run;
ods listing close; ods graphics off;

proc sql;
create table &tema._snittalder as
select 
    aar,
    avg(case when ermann=0 then alder end) as kvinner,
    avg(case when ermann=1 then alder end) as menn,
    avg(alder) as alle,
    median(case when ermann=0 then alder end) as med_kvinner,
    median(case when ermann=1 then alder end) as med_menn,
    median(alder) as med_alle
from &tema._dsn
group by aar;
quit;

ODS Graphics ON /reset=All imagename="&tema._snittalder" imagefmt=png border=off height=500px;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgplot data=&tema._snittalder noautolegend noborder /*sganno=anno pad=(Bottom=5%)*/;
vline aar / response=kvinner stat=sum name="Kvinner" legendlabel="Kvinner";
vline aar / response=menn stat=sum name="Menn" legendlabel="Menn";
keylegend / location=inside position=topright noborder title='' across=1;
xaxis fitpolicy=thin offsetmin=0.035  label='År';
xaxistable kvinner / label="Kvinner";  
xaxistable menn / label="Menn";
xaxistable alle / label="Alle";
xaxistable med_kvinner / label="Median kv.";  
xaxistable med_menn / label="Median menn";
xaxistable med_alle / label="Median alle";
yaxis label="&tema., snittalder i perioden (&startaar.-&sluttaar.)" labelpos=top LABELATTRS=(Weight=Bold);
format ermann ermann_fmt. kvinner menn alle 8.1;
styleattrs datalinepatterns=(solid) datacontrastcolors=(darkred darkblue);
run;
ods listing close; ods graphics off;

proc sql;
create table &tema._totant as
select distinct
aar, 
sum(case when ermann=0 then &tema. else 0 end) as kvinner,
sum(case when ermann=1 then &tema. else 0 end) as menn,
sum(&tema.) as total
from &tema._dsn
group by aar;
run; 

/* ODS Graphics ON /reset=All imagename="&tema._antall_kjonn" imagefmt=png border=off height=500px;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgplot data=&tema._totant noautolegend noborder;
    vline aar / response=kvinner stat=sum name="Kvinner" legendlabel="Kvinner";
	vline aar / response=menn stat=sum name="Menn" legendlabel="Menn";
    keylegend "Kvinner" "Menn" / location=inside position=bottomleft noborder title='' across=1;
    xaxis fitpolicy=thin offsetmin=0.035 label='År';
    xaxistable kvinner / label="Kvinner";  
    xaxistable menn / label="Menn";
	xaxistable total / label="Totalt";   
    yaxis label="&tema., Antall pr. år i perioden (&startaar.-&sluttaar.)" 
          labelpos=top LABELATTRS=(Weight=Bold) min=0;
    format ermann ermann_fmt.;
    styleattrs datalinepatterns=(solid) datacontrastcolors=(darkred darkblue);
run;
ods listing close;
ods graphics off; */

/*Forholdstall*/
/* Step 1: Rank the rates within each year */
proc rank data=&tema._tab out=ranked_&tema._tab ties=low descending;
    by aar;
    var &tema._rate;
    ranks rank_rate;
run;

/* Step 2: Rank the rates within each year in ascending order */
proc rank data=&tema._tab out=ranked_asc_&tema._tab ties=low;
    by aar;
    var &tema._rate;
    ranks rank_rate_asc;
run;

/* Step 3: Combine the ranked datasets and calculate the required values */
proc sql;
create table &tema._ft as
select 
    a.aar,
    max(a.&tema._rate) as maksrate,
    min(a.&tema._rate) as minrate,
    put((select bohf from &tema._tab as b where b.aar = a.aar and b.&tema._rate = (select max(&tema._rate) from &tema._tab where aar = a.aar)), bohf_fmt.) as maxbohf,
    put((select bohf from &tema._tab as c where c.aar = a.aar and c.&tema._rate = (select min(&tema._rate) from &tema._tab where aar = a.aar)), bohf_fmt.) as minbohf,
    max(a.&tema._rate)/min(a.&tema._rate) as forholdstall,
    b.&tema._rate as max2rate,
    c.&tema._rate as min2rate,
    put(b.bohf, bohf_fmt.) as max2bohf,
    put(c.bohf, bohf_fmt.) as min2bohf,
    b.&tema._rate / c.&tema._rate as forholdstall2
from &tema._tab as a
left join ranked_&tema._tab as b on a.aar = b.aar and b.rank_rate = 2
left join ranked_asc_&tema._tab as c on a.aar = c.aar and c.rank_rate_asc = 2
group by a.aar;
quit;

proc sql;
create table &tema._ft as
select distinct *
from &tema._ft;
quit;

ODS Graphics ON /reset=All imagename="&tema._forholdstall" imagefmt=png border=off height=500px;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgplot data=&tema._ft noautolegend noborder;
    vline aar / response=maksrate stat=sum lineattrs=(pattern=dash) name='Maksimum';
    vline aar / response=minrate stat=sum lineattrs=(pattern=dash) name='Minimum';
    vline aar / response=forholdstall stat=sum y2axis lineattrs=(pattern=solid) name='Forholdstall';    
    keylegend 'antall' / location=inside position=topright noborder title='' across=1;    
    xaxis fitpolicy=thin offsetmin=0.035 label="År, &tema";
    yaxis label="Rate, maksimum (rød) og minimum (blå), (stiplet)" labelpos=top labelattrs=(weight=bold) min=0;
    y2axis label="Forholdstall (svart)" labelpos=top labelattrs=(weight=bold) min=0;    
    format ermann ermann_fmt.;
    styleattrs datalinepatterns=(solid dash) datacontrastcolors=(darkred darkblue black);    
    where aar ne 9999;    
    xaxistable maksrate / label="Maksimum";
    xaxistable minrate / label="Minimum";
    xaxistable forholdstall / label="Forholdstall";
    xaxistable maxbohf / label="Maksbo";
    xaxistable minbohf / label="Minbo";    
    xaxistable max2rate / label="Maksimum2";
    xaxistable min2rate / label="Minimum2";
    xaxistable forholdstall2 / label="Forholdstall2";
    xaxistable max2bohf / label="Maksbo2";
    xaxistable min2bohf / label="Minbo2";  
    format maksrate minrate forholdstall max2rate min2rate forholdstall2 8.1;
run;
ods listing close; ods graphics off;

/* proc datasets library=work nolist;
    delete &tema._ft &tema._tab ranked_: &tema._totant &tema._dsn &tema._snittalder
    &tema._aldtab &tema._aldtab_aar &tema._tab: _SGSRT2_;
quit; */

%mend total_figurer;
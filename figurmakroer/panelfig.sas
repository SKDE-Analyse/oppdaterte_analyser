
%macro panelfigur(tema=);

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
b.eget_ant as eget_ant_n,
b.eget_rate as eget_rate_n,
b.annet_ant as annet_ant_n,
b.annet_rate as annet_rate_n,
b.privat_ant as privat_ant_n,
b.privat_rate as privat_rate_n
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

/*Eget-figur*/
ODS Graphics ON /reset=All imagename="&tema._panel_eget" imagefmt=png border=off height=800px width=1200px ;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgpanel data=&tema._tab noautolegend sganno=anno pad=(Bottom=5%);
PANELBY bohf / columns=7 rows=3 novarname spacing=2 HEADERATTRS=(Color=black Family=Arial Size=7);
vbarparm category= aar  response=eget_rate /fillattrs=(color=CX95BDE6);
series x=aar y=eget_rate_n /lineattrs=(color=black pattern=1 thickness=2) name="norge" legendlabel="Norge";
keylegend "norge" / noborder position=bottom;
colaxis label="&tema., behandlet i eget HF, rate pr 1 000 innbyggere" valueattrs=(size=5) labelattrs=(size=8 weight=bold);
rowaxis label=" ";
where aar ne 9999;
RUN; 
ods listing close; ods graphics off;

/*Annet-figur*/
ODS Graphics ON /reset=All imagename="&tema._panel_annet" imagefmt=png border=off height=800px width=1200px ;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgpanel data=&tema._tab noautolegend sganno=anno pad=(Bottom=5%);
PANELBY bohf / columns=7 rows=3 novarname spacing=2 HEADERATTRS=(Color=black Family=Arial Size=7);
vbarparm category= aar  response=annet_rate /fillattrs=(color=CX95BDE6);
series x=aar y=annet_rate_n /lineattrs=(color=black pattern=1 thickness=2) name="norge" legendlabel="Norge";
keylegend "norge" / noborder position=bottom;
colaxis label="&tema., behandlet i annet HF, rate pr 1 000 innbyggere" valueattrs=(size=5) labelattrs=(size=8 weight=bold);
rowaxis label=" ";
where aar ne 9999;
RUN; 
ods listing close; ods graphics off;

/*Privat-figur*/
ODS Graphics ON /reset=All imagename="&tema._panel_privat" imagefmt=png border=off height=800px width=1200px ;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgpanel data=&tema._tab noautolegend sganno=anno pad=(Bottom=5%);
PANELBY bohf / columns=7 rows=3 novarname spacing=2 HEADERATTRS=(Color=black Family=Arial Size=7);
vbarparm category= aar  response=privat_rate /fillattrs=(color=CX95BDE6);
series x=aar y=privat_rate_n /lineattrs=(color=black pattern=1 thickness=2) name="norge" legendlabel="Norge";
keylegend "norge" / noborder position=bottom;
colaxis label="&tema., behandlet Privat, rate pr 1 000 innbyggere" valueattrs=(size=5) labelattrs=(size=8 weight=bold);
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
yaxis label="&tema., Antall totalt i perioden (2015-2023)" labelpos=top LABELATTRS=(Weight=Bold);
format ermann ermann_fmt.;
styleattrs datalinepatterns=(solid) datacontrastcolors=(darkred darkblue);
run;
ods listing close; ods graphics off;

proc sql;
create table &tema._snittalder as
select distinct
aar,
avg(case when ermann=0 then alder end) as kvinner,
avg(case when ermann=1 then alder end) as menn,
avg(alder) as alle
from &tema._dsn
group by aar;
run;

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
yaxis label="&tema., snittalder i perioden (2015-2023)" labelpos=top LABELATTRS=(Weight=Bold);
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
sum(&tema.) as total,
sum(case when eget=1 then &tema. else 0 end) as eget,
sum(case when annet=1 then &tema. else 0 end) as annet,
sum(case when privat=1 then &tema. else 0 end) as privat
from &tema._dsn
group by aar;
run; 

ODS Graphics ON /reset=All imagename="&tema._antall_kjonn" imagefmt=png border=off height=500px;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgplot data=&tema._totant noautolegend noborder;
    vline aar / response=kvinner stat=sum name="Kvinner" legendlabel="Kvinner";
	vline aar / response=menn stat=sum name="Menn" legendlabel="Menn";
    keylegend "Kvinner" "Menn" / location=inside position=bottomleft noborder title='' across=1;
    xaxis fitpolicy=thin offsetmin=0.035 label='År';
    xaxistable kvinner / label="Kvinner";  
    xaxistable menn / label="Menn";
	xaxistable total / label="Totalt";   
    yaxis label="&tema., Antall pr. år i perioden (2015-2023)" 
          labelpos=top LABELATTRS=(Weight=Bold) min=0;
    format ermann ermann_fmt.;
    styleattrs datalinepatterns=(solid) datacontrastcolors=(darkred darkblue);
run;
ods listing close;
ods graphics off;


ODS Graphics ON /reset=All imagename="&tema._antall_beh" imagefmt=png border=off height=500px;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgplot data=&tema._totant noautolegend noborder;
    vline aar / response=eget stat=sum name="Eget" legendlabel="Eget HF";
	vline aar / response=annet stat=sum name="Annet" legendlabel="Annet HF";
	vline aar / response=privat stat=sum name="Privat" legendlabel="Privat";
    keylegend "Eget" "Annet" "Privat"/ location=inside position=top noborder title='' across=3;
    xaxis fitpolicy=thin offsetmin=0.035 label='År';
    xaxistable eget / label="Eget HF";  
    xaxistable annet / label="Annet HF";
	xaxistable privat / label="Privat";
	xaxistable total / label="Totalt";   
    yaxis label="&tema., Antall pr. år i perioden (2015-2023)" 
          labelpos=top LABELATTRS=(Weight=Bold) min=0;
    format ermann ermann_fmt.;
    styleattrs datalinepatterns=(solid) datacontrastcolors=(darkred darkblue green);
run;
ods listing close;
ods graphics off;

/*Forholdstall*/
proc sql;
create table &tema._ft as
select 
    aar,
    max(&tema._rate) as maksrate,
    min(&tema._rate) as minrate,
    put((select bohf from &tema._tab as b where b.aar = a.aar and b.&tema._rate = (select max(&tema._rate) from &tema._tab where aar = a.aar)), bohf_fmt.) as maxbohf,
    put((select bohf from &tema._tab as c where c.aar = a.aar and c.&tema._rate = (select min(&tema._rate) from &tema._tab where aar = a.aar)), bohf_fmt.) as minbohf,
    max(&tema._rate)/min(&tema._rate) as forholdstall
from &tema._tab as a
group by aar;
quit;

ODS Graphics ON /reset=All imagename="&tema._forholdstall" imagefmt=png border=off height=500px;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgplot data=&tema._ft noautolegend noborder;
    vline aar / response=maksrate stat=sum lineattrs=(pattern=dash) name='Maksimum';
    vline aar / response=minrate stat=sum  lineattrs=(pattern=dash) name='Minimum';  
	vline aar / response=forholdstall stat=sum  y2axis 
                  lineattrs=(pattern=solid) name='Forholdstall';  
    keylegend 'antall' / location=inside position=topright noborder title='' across=1;    
    xaxis fitpolicy=thin offsetmin=0.035 label="År, &tema"; 
    yaxis label="Rate, maksimum (rød) og minimum (blå), (stiplet)" 
          labelpos=top labelattrs=(weight=bold) min=0;    
    y2axis label="Forholdstall (svart)" 
           labelpos=top labelattrs=(weight=bold) min=0;
    format ermann ermann_fmt.;     
    styleattrs datalinepatterns=(solid dash) datacontrastcolors=(darkred darkblue black);
	where aar ne 9999;
	xaxistable maksrate / label="Maksimum";  
	xaxistable minrate / label="Minimum";
	xaxistable forholdstall / label="Forholdstall";
    xaxistable maxbohf / label="Maksbo";  
	xaxistable minbohf / label="Minbo";
	format maksrate minrate forholdstall 8.1;
run;
ods listing close; ods graphics off;

%mend panelfigur;
%macro dim_rate_alder_kjonn(dim=,aarmin=,aarmax=,aldermin=,aldermax=,kjonn=);

/*Rate pr ettårig-alder*/
proc sql;
create table &tema._ant as
select distinct
aar, alder, ermann,
sum(&dim) as ant
from pub_assembled
where aar in (&aarmin:&aarmax) 
and alder in (&aldermin:&aldermax)
%if &kjonn = 1 %then %do;
    and ermann in (&kjonn)
%end;
%if &kjonn = 0 %then %do;
    and ermann in (&kjonn)
%end;
%if &kjonn = . %then %do;
    and ermann in (0,1)
%end;
group by aar, alder, ermann;
run;

proc sql;
create table pop_ant as
select distinct
aar, alder, ermann,
sum(innbyggere) as pop
from innbygg.innb_skde_bydel
where aar in (&aarmin:&aarmax) 
and alder in (&aldermin:&aldermax)
%if &kjonn = 1 %then %do;
    and ermann in (&kjonn)
%end;
%if &kjonn = 0 %then %do;
    and ermann in (&kjonn)
%end;
%if &kjonn = . %then %do;
    and ermann in (0,1)
%end;
group by aar, alder, ermann;
run;

proc sql;
create table ant_pop as
select a.*, b.ant
from pop_ant as a
left join
&tema._ant as b
on a.aar=b.aar and a.alder=b.alder and a.ermann=b.ermann;
run;

data ant_pop;
set ant_pop;
if ant=. then ant=0;
run;

proc sql;
create table ant_pop_tot as
select distinct
alder, ermann,
sum(ant) as antall,
(sum(ant) / sum(pop))*1000 as rate
from ant_pop
group by alder, ermann;
run;

proc sql;
create table ant_pop_aar as
select distinct
aar, ermann,
sum(ant) as antall,
(sum(ant) / sum(pop))*1000 as rate
from ant_pop
group by aar, ermann;
run;

proc format;
value ermann_fmt 
0 = "Kvinner"
1 = "Menn";
run;

ODS Graphics ON /reset=All imagename="&tema._&dim._rate_alder_kjonn" imagefmt=png border=off height=500px;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgplot data=ant_pop_tot noautolegend noborder /*sganno=anno pad=(Bottom=5%)*/;
vline alder / response=rate stat=sum group=ermann;
keylegend / location=inside position=topright noborder title='' across=1;
xaxis fitpolicy=thin offsetmin=0.035 label='Alder';
yaxis label="&tema. &dim., Rate pr. 1 000 innbyggere, totalt for perioden (&aarmin.-&aarmax)" 
labelpos=top LABELATTRS=(Weight=Bold) min=0;
format ermann ermann_fmt.;
styleattrs datalinepatterns=(solid) datacontrastcolors=(darkred darkblue);
run;
ods listing close;
ods graphics off;

/* figur med antall på y2-aksen over alder*/
ODS Graphics ON /reset=All imagename="&tema._&dim._rate_alder_kjonn2" imagefmt=png border=off height=500px;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgplot data=ant_pop_tot noautolegend noborder;
    vline alder / response=antall stat=sum group=ermann 
                  lineattrs=(pattern=solid) name='antall';
    vline alder / response=rate stat=sum group=ermann y2axis 
                  lineattrs=(pattern=dash) name='rate';    
    keylegend 'antall' / location=inside position=topright noborder title='' across=1;    
    xaxis fitpolicy=thin offsetmin=0.035 label="Alder, &tema, &dim"; 
    yaxis label="Antall, totalt for perioden (&aarmin.-&aarmax)" 
          labelpos=top labelattrs=(weight=bold) min=0;    
    y2axis label="Rate pr. 1 000 innbyggere (stiplet)" 
           labelpos=top labelattrs=(weight=bold) min=0;
    format ermann ermann_fmt.;     
    styleattrs datalinepatterns=(solid dash) datacontrastcolors=(darkred darkblue);
run;
ods listing close;
ods graphics off;

/* figur med antall på y2-aksen over år */
ODS Graphics ON /reset=All imagename="&tema._&dim._rate_aar_kjonn2" imagefmt=png border=off height=500px;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgplot data=ant_pop_aar noautolegend noborder;
    vline aar / response=antall stat=sum group=ermann 
                  lineattrs=(pattern=solid) name='antall';
    vline aar / response=rate stat=sum group=ermann y2axis 
                  lineattrs=(pattern=dash) name='rate';    
    keylegend 'antall' / location=inside position=topright noborder title='' across=1;    
    xaxis fitpolicy=thin offsetmin=0.035 label="År, &tema, &dim"; 
    yaxis label="Antall, totalt for perioden (&aarmin.-&aarmax)" 
          labelpos=top labelattrs=(weight=bold) min=0;    
    y2axis label="Rate pr. 1 000 innbyggere (stiplet)" 
           labelpos=top labelattrs=(weight=bold) min=0;
    format ermann ermann_fmt.;     
    styleattrs datalinepatterns=(solid dash) datacontrastcolors=(darkred darkblue);
run;
ods listing close;
ods graphics off;

proc sql;
create table &dim._snittalder as
select distinct
aar,
avg(case when ermann=0 then alder end) as kvinner,
avg(case when ermann=1 then alder end) as menn,
avg(alder) as alle
from &tema._ant
group by aar;
run;

ODS Graphics ON /reset=All imagename="&tema._&dim._snittalder" imagefmt=png border=off height=500px;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgplot data=&dim._snittalder noautolegend noborder /*sganno=anno pad=(Bottom=5%)*/;
vline aar / response=kvinner stat=sum name="Kvinner" legendlabel="Kvinner";
vline aar / response=menn stat=sum name="Menn" legendlabel="Menn";
keylegend / location=inside position=topright noborder title='' across=1;
xaxis fitpolicy=thin offsetmin=0.035  label='År';
xaxistable kvinner / label="Kvinner";  
xaxistable menn / label="Menn";
xaxistable alle / label="Alle";
yaxis label="&tema., &dim., snittalder i perioden (2015-2023)" labelpos=top LABELATTRS=(Weight=Bold);
format ermann ermann_fmt. kvinner menn alle 8.1;
styleattrs datalinepatterns=(solid) datacontrastcolors=(darkred darkblue);
run;
ods listing close; ods graphics off;

%mend dim_rate_alder_kjonn;
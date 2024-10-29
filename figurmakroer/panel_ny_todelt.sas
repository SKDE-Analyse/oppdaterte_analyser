%macro panelfigur_ny_todelt(
    tema=,
    dim1=,
    dim2=,
    dimensjon=);

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
    b.&dim2._rate as &dim2._rate_n
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
    RUN; 
    ods listing close; ods graphics off;
    
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
    create table &tema._totant as
    select distinct
    aar, 
    sum(case when ermann=0 then &tema. else 0 end) as kvinner,
    sum(case when ermann=1 then &tema. else 0 end) as menn,
    sum(&tema.) as total,
    sum(case when &dim1=1 then &tema. else 0 end) as &dim1,
    sum(case when &dim2=1 then &tema. else 0 end) as &dim2
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
    
    
    ODS Graphics ON /reset=All imagename="&tema._antall_&dimensjon" imagefmt=png border=off height=500px;
    ODS Listing Image_dpi=300 GPATH="&bildesti";
    proc sgplot data=&tema._totant noautolegend noborder;
        vline aar / response=&dim1 stat=sum name="&dim1" legendlabel="&dim1";
        vline aar / response=&dim2 stat=sum name="&dim2" legendlabel="&dim2";
        keylegend "&dim1" "&dim2"/ location=inside position=top noborder title='' across=3;
        xaxis fitpolicy=thin offsetmin=0.035 label='År';
        xaxistable &dim1 / label="&dim1";  
        xaxistable &dim2 / label="&dim2";
        xaxistable total / label="Totalt";   
        yaxis label="&tema., Antall pr. år i perioden (2015-2023)" 
              labelpos=top LABELATTRS=(Weight=Bold) min=0;
        format ermann ermann_fmt.;
        styleattrs datalinepatterns=(solid) datacontrastcolors=(darkred darkblue green);
    run;
    ods listing close;
    ods graphics off;
    
    %mend panelfigur_ny_todelt;
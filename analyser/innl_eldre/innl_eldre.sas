/*!
###Dokumentasjon
Opprettet 25.november 2024 av Hanne Sigrun Byhring
Sist kjørt dato av hvem
Endringer hva, hvem og når
*/
/*options locale=NB_no;*/
/*Options spool symbolgen mlogic mprint;*/
/*Options compress=yes  errors=2;*/

/*************************************
 GJØR ENDRINGER I DENNE LILLE BOLKEN
*************************************/
%let tema=innl_eldre;
%let startaar=2015;
%let sluttaar=2023;
/****************************************
 OG TILPASS MAKROER ETTER PUBLISER_RATE
*****************************************/

%let oppdatering_filbane=/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser_kloner/oppd_ana_HSB;
/*Makroer for å lage data til analyse*/
%include "&oppdatering_filbane/makroer/setup.sas";
/*Makroer og stier for figurer*/
%include "&oppdatering_filbane/figurmakroer/oppsett.sas";
%include "&oppdatering_filbane/makroer/npr.sas";

/*** Utvalg og analyse ***/

data innl_eldre1;
  %NPR(sho, /*Velger sykehusopphold*/
    periode=2015-2023,
	 where= alder ge 75
  )
/*Her får vi alle kontakter. Må kjøre sykehusoppholdsmakro og velge ut innleggelser*/ 
&tema = 1;	/*alle kontaker*/
run;

/*Kjører sykehusoppholdsmakro*/ 
%include "/sas_smb/skde_analyse/Data/SAS/felleskoder/main/makroer/sykehusopphold.sas";
%sykehusopphold(dsn=innl_eldre1, overforing_tid=28800, forste_hastegrad=1, behold_datotid=0, nulle_liggedogn=0, minaar=0);

/*Velger kun innleggelser*/ 
data innl_eldre2;
set innl_eldre1;
where SHO_aktivitetskategori3 = 1;
run;

/*Sorterer vekk duplikater - velger siste opphold*/
data innl_eldre;
set innl_eldre2;
where SHO_Intern_nr eq SHO_Antall_i_SHO;

if SHO_hastegrad in (4,5) then elek=1;
if SHO_hastegrad eq 1 then akutt=1;

ukp_dager_ny=SHO_utdato-utskrklardato;

if utskrklardato ne . then do;
	if SHO_inndato gt utskrklardato then ekskluder=1;
end;

run;

data liggedogn_eldre;
set innl_eldre;
where ekskluder ne 1;
run;

%include "/sas_smb/skde_analyse/Data/SAS/felleskoder/main/rateprogram/standard_rate.sas";
%standard_rate(liggedogn_eldre/SHO_liggetid ukp_dager_ny, region= bohf, out=rate_liggetid, min_age=75);

/*Tror vi må gå for liggetid pr. innleggelse og ukpdager pr innleggelse
Deler liggedøgnsraten på oppholdsraten, samme for ukp-dagsraten*/
%standard_rate(liggedogn_eldre/innl_eldre, region= bohf, out=rate_opphold, min_age=75);

%let bo=bohf;
proc sql;
create table rateinfo as
select a.&bo, a.aar, a.SHO_liggetid_rate as LT_rate,
		a.ukp_dager_ny_rate as UKP_rate, 
		b.innl_eldre_rate as OPPH_rate, 	
		LT_rate / OPPH_rate as LT_pr_OPPH,
		UKP_rate / OPPH_rate as UKP_pr_OPPH
from rate_liggetid_long as a 
	left join rate_opphold_long as b 
	on a.&bo=b.&bo and a.aar=b.aar;
quit;

data rateinfo_n;
set rateinfo;
where bohf=8888;
rename LT_pr_OPPH=LT_pr_OPPH_N;
rename UKP_pr_OPPH=UKP_pr_OPPH_N;

drop bohf LT_rate UKP_rate OPPH_rate;
run;

proc sql;
create table rateinfo2 as
select a.*, 
		b.LT_pr_OPPH_N,
		b.UKP_pr_OPPH_N
from rateinfo as a 
	left join rateinfo_n as b 
	on a.aar=b.aar;
quit;


/*Total-figur LT pr OPPH*/
ODS Graphics ON /reset=All imagename="LT_pr_OPPH_panel" imagefmt=png border=off height=800px width=1200px ;
ODS Listing Image_dpi=300 GPATH="&bildesti";
proc sgpanel data=rateinfo2 noautolegend sganno=anno pad=(Bottom=5%);
PANELBY bohf / columns=7 rows=3 novarname spacing=2 HEADERATTRS=(Color=black Family=Arial Size=7);
vbarparm category= aar  response=LT_pr_OPPH /fillattrs=(color=CX95BDE6);
vbarparm category= aar  response=UKP_pr_OPPH /fillattrs=(color=grey);
series x=aar y=LT_pr_OPPH_n /lineattrs=(color=black pattern=1 thickness=2) name="norge" legendlabel="Norge";
keylegend "norge" / noborder position=bottom;
colaxis label="Liggetid pr opphold (kjønns- og aldersjustert)" valueattrs=(size=5) labelattrs=(size=8 weight=bold);
rowaxis label=" ";
where aar ne 9999 and bohf ne 8888;
RUN; 
ods listing close; ods graphics off;

%oppdater(&tema,
   total=&tema,
   variables=eget_hf annet_hf privat elek akutt,
   force_update=true
);

%publiser_rate(&tema,
   total=&tema,
   custom_views=
	%define_view(
        name=behandler, 
        variables=eget_hf annet_hf privat,
        title=%str(no := Enkeltår, behandlingssted
                || en := Single year, public/private),
        label_1=no := Eget HF || en := Local public,
        label_2=no := Annet HF || en := Other public,
        label_3=no := Privat || en := Private)
	%define_view(
        name=hastegrad, 
        variables=akutt elek,
        title=%str(no := Enkeltår, hastegrad
                || en := Single year, acute vs planned),
        label_1=no := Akutt || en := Acute,
        label_2=no := Planlagt || en := Planned)
	,
        &settinn_txt.
        tags=eldre
);

/*FIGURER TIL STØTTE I SKRIVINGEN UNDER HER:*/
/*Figurer og tabeller*/
%total_figurer;

%panelfigur_tredelt(dim1=eget_hf,dim2=annet_hf,dim3=privat,dimensjon=beh);
%panelfigur_todelt(dim1=akutt,dim2=elek,dimensjon=hast);

%rate_alder_kjonn(aarmin=&startaar,aarmax=&sluttaar,aldermin=75,aldermax=105);

/*Se på liggedøgn og utskrivningsklar dager*/



/*SLETTE ALLE DATASETT I WORK */
proc datasets nolist library=WORK kill;
   run; quit;


%include "&oppdatering_filbane/makroer/analyser_parse_dataspecifier.sas";

%macro oppdater(dataspecifier, force_update=false);

%analyser_parse_dataspecifier(&dataspecifier, ds_var=oppd_dataset, varlist_var=oppd_varlist);

%put "DS-navn: " &oppd_dataset;
%put "Variable list: " &oppd_varlist;

proc sql noprint;
create table &oppd_dataset._aggregert as
   select aar, month(utdato) as maaned, komnr, bydel, alder, ermann, count(*) as n_obs
   %do oppd_i=1 %to %sysfunc(countw(&oppd_varlist));
      , sum(%scan(&oppd_varlist, &oppd_i)) as %scan(&oppd_varlist, &oppd_i)
   %end;
   from &oppd_dataset
   group by aar, calculated maaned, komnr, bydel, alder, ermann;
quit;

proc sql noprint;
select min(aar), max(aar)
   into :oppd_min_year, :oppd_max_year
   from &oppd_dataset._aggregert;
quit;

data %do oppd_aar=&oppd_min_year %to &oppd_max_year; %do oppd_maaned=1 %to 12;
      &oppd_dataset._&oppd_aar._&oppd_maaned._tmp
   %end; %end; ;
   set &oppd_dataset._aggregert;
   
   %do oppd_aar=&oppd_min_year %to &oppd_max_year; %do oppd_maaned=1 %to 12;
      if aar=&oppd_aar and maaned=&oppd_maaned then
         output &oppd_dataset._&oppd_aar._&oppd_maaned._tmp;
   %end; %end;
run;

%do oppd_aar=&oppd_min_year %to &oppd_max_year;
   %do oppd_maaned=1 %to 12;
      %let oppd_partial_ds = &oppd_dataset._&oppd_aar._&oppd_maaned;
      %if %sysfunc(exist(&oppd_partial_ds)) and &force_update = false %then %do;
	     %put Datasettet for denne måneden finnes allerede, og blir derfor ikke oppdatert: "&oppd_partial_ds";
	  %end;
	  %else %do;
	     %put Datasettet for denne måneden finnes ikke, og blir derfor oppdatert: "&oppd_partial_ds";
		 data &oppd_partial_ds;
		    set &oppd_dataset._&oppd_aar._&oppd_maaned._tmp;
         run;
	  %end;
   %end;
%end;

%mend oppdater;
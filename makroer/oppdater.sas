

%include "&oppdatering_filbane/makroer/analyser_parse_dataspecifier.sas";

%macro oppdater(name, total=, variables=, force_update=false);

%let all_variables = &total &variables;

%put "DS-navn: " &name;
%put "Variable list: " &all_variables;

proc sql noprint;
create table &name._aggregert as
   select aar, month(utdato) as maaned, komnr, bydel, alder, ermann, count(*) as n_obs
   %do oppd_i=1 %to %sysfunc(countw(&all_variables));
      , sum(%scan(&all_variables, &oppd_i)) as %scan(&all_variables, &oppd_i)
   %end;
   from &name
   group by aar, calculated maaned, komnr, bydel, alder, ermann;
quit;

proc sql noprint;
select min(aar), max(aar)
   into :oppd_min_year, :oppd_max_year
   from &name._aggregert;
quit;

data %do oppd_aar=&oppd_min_year %to &oppd_max_year; %do oppd_maaned=1 %to 12;
      &name._&oppd_aar._&oppd_maaned._tmp
   %end; %end; ;
   set &name._aggregert;
   
   %do oppd_aar=&oppd_min_year %to &oppd_max_year; %do oppd_maaned=1 %to 12;
      if aar=&oppd_aar and maaned=&oppd_maaned then
         output &name._&oppd_aar._&oppd_maaned._tmp;
   %end; %end;
run;

%do oppd_aar=&oppd_min_year %to &oppd_max_year;
   %do oppd_maaned=1 %to 12;
      %let oppd_partial_ds = &name._&oppd_aar._&oppd_maaned;
      %if %sysfunc(exist(&oppd_partial_ds)) and &force_update = false %then %do;
	     %put Datasettet for denne måneden finnes allerede, og blir derfor ikke oppdatert: "&oppd_partial_ds";
	  %end;
	  %else %do;
	     %put Datasettet for denne måneden finnes ikke, og blir derfor oppdatert: "&oppd_partial_ds";
		 data &oppd_partial_ds;
		    set &name._&oppd_aar._&oppd_maaned._tmp;
         run;
	  %end;
   %end;
%end;

%mend oppdater;
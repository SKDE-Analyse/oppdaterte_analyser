%include "/sas_smb/skde_analyse/Data/SAS/felleskoder/main/makroer/boomraader.sas";

%macro assemble(base_name, out=);

%let library=work;

proc sql;
select distinct memname as name
   into :all_datasets separated by " "
   from dictionary.columns
   where libname=upcase("&library")
     and prxmatch("/^&base_name._\d{4}_\d{1,2}\s*$/i", memname);
quit;


proc sql;
select distinct name
   into :assemble_varnames separated by " "
   from dictionary.columns
   where libname=upcase("&library")
     and memname="%scan(&all_datasets, 1)"
	 and lower(name) not in ("aar" "maaned" "komnr" "bydel" "alder" "ermann" "n_obs");
quit;

data deleteme_all_of_them;
   set &all_datasets;
run;

%boomraader(inndata=deleteme_all_of_them);


%put &=assemble_varnames;


proc sql;
create table &out as
   select aar, borhf, bohf, alder, ermann, sum(n_obs) as n_obs
   %do assemble_i=1 %to %sysfunc(countw(&assemble_varnames));
      , sum(%scan(&assemble_varnames, &assemble_i)) as %scan(&assemble_varnames, &assemble_i)
   %end;
   from deleteme_all_of_them
   where borhf <= 4
   group by aar, borhf, bohf, alder, ermann;
quit;

proc datasets library=work;
   delete deleteme_all_of_them;
run;

%mend assemble;
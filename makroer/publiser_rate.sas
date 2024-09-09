

%include "&oppdatering_filbane/makroer/assemble.sas";
%include "&oppdatering_filbane/makroer/analyser_parse_dataspecifier.sas";
%include "&filbane/rateprogram/standard_rate.sas";

%macro publiser_rate(
   dataspecifier,
   description=,
   description_en=,
   variables=,
   tags=
);

%analyser_parse_dataspecifier(&dataspecifier, ds_var=name, varlist_var=analyse_varlist);

%assemble(&name, out=pub_assembled)

%standard_rate(
   pub_assembled/&analyse_varlist,
   region=bohf,
   out=pub_sykehus_rate
)

%standard_rate(
   pub_assembled/&analyse_varlist,
   region=borhf,
   out=pub_region_rate
)

proc sql noprint;
select min(year), max(year)
   into :pub_min_year, :pub_max_year
   from pub_sykehus_rate_yearly;
quit;

proc sql noprint;
select bohf format=4.
   into :pub_sykehus separated by " "
   from pub_sykehus_rate;
quit;

proc sql noprint;
select borhf format=4.
   into :pub_regioner separated by " "
   from pub_region_rate;
quit;


data _null_;
   set pub_sykehus_rate;
   %do pub_year=&pub_min_year %to &pub_max_year;
      %do pub_varnum=1 %to %sysfunc(countw(&analyse_varlist));
	     variable = cats("pub_syk_", bohf, "_&pub_year._&pub_varnum");
         call symput(cats("pub_syk_", bohf, "_&pub_year._&pub_varnum"),
                     %scan(&analyse_varlist, &pub_varnum)_rate&pub_year
         );
	  %end;
   %end;
run;

data _null_;
   set pub_region_rate;
   %do pub_year=&pub_min_year %to &pub_max_year;
      %do pub_varnum=1 %to %sysfunc(countw(&analyse_varlist));
	     variable = cats("pub_region_", borhf, "_&pub_year._&pub_varnum");
         call symput(cats("pub_region_", borhf, "_&pub_year._&pub_varnum"),
                     %scan(&analyse_varlist, &pub_varnum)_rate&pub_year
         );
	  %end;
   %end;
run;


data _null_;
   call symput("published",
      tzones2u(datetime(), "Europe/Oslo") * 1000 -
      "01jan1970 0:0:0"dt * 1000
	  /* Converting from SAS-time to UNIX-time. UNIX-time is used in Javascript. */
   );
run;

%let webdata = /sas_smb/skde_analyse/Brukere/Mattias/oppdaterte_analyser/webdata;
proc json out="&webdata/&name..json" pretty;

   write values "tags";
   write open array;
      %do pub_i=1 %to %sysfunc(countw(&tags, %str( )));
         write values "%scan(&tags, &pub_i, %str( ))";
      %end;
   write close;

   write values "name" "&name";
   write values "published" &published;

   write values "description";

   write open object;
      write values "no" %if &description ^=    %then &description;    %else "";;
      write values "en" %if &description_en ^= %then &description_en; %else "";;
   write close;

   write values "variables";
   write open array;
      %do pub_i=1 %to %sysfunc(countw(&analyse_varlist));
         write values "%scan(&analyse_varlist, &pub_i)";
      %end;
   write close;

   write values "data";
   write open object;
      write values "sykehus";
	  write open object;
	  %do pub_sykehus_i=1 %to %sysfunc(countw(&pub_sykehus));
         write values "%scan(&pub_sykehus, &pub_sykehus_i)";
         write open object;
         %do pub_year=&pub_min_year %to &pub_max_year;
            write values "&pub_year";
			write open array;
            %do pub_varnum=1 %to %sysfunc(countw(&analyse_varlist));
               %let pub_valuevar = pub_syk_%scan(&pub_sykehus, &pub_sykehus_i)_&pub_year._&pub_varnum;
		       write values &&&pub_valuevar;
            %end;
            write close;
         %end;
         write close;
	  %end;
      write close;

	  write values "region";
	  write open object;
	  %do pub_region_i=1 %to %sysfunc(countw(&pub_regioner));
         write values "%scan(&pub_regioner, &pub_region_i)";
         write open object;
         %do pub_year=&pub_min_year %to &pub_max_year;
            write values "&pub_year";
			write open array;
            %do pub_varnum=1 %to %sysfunc(countw(&analyse_varlist));
               %let pub_valuevar = pub_region_%scan(&pub_regioner, &pub_region_i)_&pub_year._&pub_varnum;
		       write values &&&pub_valuevar;
            %end;
            write close;
         %end;
         write close;
	  %end;
      write close;
   write close;
run;

%mend publiser_rate;

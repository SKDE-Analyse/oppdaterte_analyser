

%include "&oppdatering_filbane/makroer/assemble.sas";
%include "&oppdatering_filbane/makroer/analyser_parse_dataspecifier.sas";
%include "&filbane/rateprogram/standard_rate.sas";

%macro publiser_rate(
   name,
   total=,
   custom_views=,
   summary=,
   discussion=,
   utvalg=,
   description=,
   title=,
   tags=,
   min_age=,
   max_age=
);

%let __ignore = %define_view(
                   name=total,
                   variables=&total,
                   title= no := Enkeltår || en := Single year,
                   label_1= no := Total || en := Total);
%let all_views = total &custom_views;

%let analyse_varlist = &total;
%if &custom_views ^= %then %do;
   %do view_i=1 %to %sysfunc(countw(&custom_views));
      %let view = %scan(&custom_views, &view_i);
      %let analyse_varlist = &analyse_varlist &&view_&view._vars;
   %end;
%end;

%put &=analyse_varlist;
%put &=name;

%put &=summary;

%assemble(&name, out=pub_assembled)

%standard_rate(
   pub_assembled/&analyse_varlist,
   region=bohf,
   %if &min_age ^= %then min_age=&min_age, ;
   %if &max_age ^= %then max_age=&max_age, ;
   out=pub_sykehus_rate
)

%standard_rate(
   pub_assembled/&analyse_varlist,
   region=borhf,
   %if &min_age ^= %then min_age=&min_age, ;
   %if &max_age ^= %then max_age=&max_age, ;
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
      %do view_i=1 %to %sysfunc(countw(&all_views));
         %let view = %scan(&all_views, &view_i);
         %do pub_varnum=1 %to %sysfunc(countw(&&view_&view._vars));
            variable = cats("pub_syk_", bohf, "_&pub_year._&view_i._&pub_varnum");
            call symput(cats("pub_syk_", bohf, "_&pub_year._&view_i._&pub_varnum"),
                        %scan(&&view_&view._vars, &pub_varnum)_rate&pub_year
            );
         %end;
      %end;
   %end;
run;
data _null_;
   set pub_region_rate;
   %do pub_year=&pub_min_year %to &pub_max_year;
      %do view_i=1 %to %sysfunc(countw(&all_views));
         %let view = %scan(&all_views, &view_i);
         %do pub_varnum=1 %to %sysfunc(countw(&&view_&view._vars));
            variable = cats("pub_region_", borhf, "_&pub_year._&view_i._&pub_varnum");
            call symput(cats("pub_region_", borhf, "_&pub_year._&view_i._&pub_varnum"),
                        %scan(&&view_&view._vars, &pub_varnum)_rate&pub_year
            );
         %end;
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

%macro lang_object(string);
   write open object;
      write values "no" "%get_lang(no, &string)" / noscan;
      write values "en" "%get_lang(en, &string)" / noscan;
   write close;
%mend lang_object;

proc json out="&oppdatering_filbane/webdata/&name..json" pretty;

   write values "tags";
   write open array;
      %do pub_i=1 %to %sysfunc(countw(&tags, %str( )));
         write values "%scan(&tags, &pub_i, %str( ))";
      %end;
   write close;

   write values "name" "&name";
   write values "published" &published;

   write values "title";       %lang_object(&title)
   write values "summary";     %lang_object(&summary)
   write values "discussion";  %lang_object(&discussion)
   write values "utvalg";      %lang_object(&utvalg)
   write values "description"; %lang_object(&description)

   write values "views";
   write open array;
      %do view_i=1 %to %sysfunc(countw(&all_views));
         %let view = %scan(&all_views, &view_i);
         write open object;
            write values "name" "&view";
            write values "title"; %lang_object(&&view_&view._title)
            write values "variables";
            write open array;
               %do vars_i=1 %to %sysfunc(countw(&&view_&view._vars));
                  %lang_object(&&view_&view._label_&vars_i)
               %end;
            write close;
         write close;
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
                     %do view_i=1 %to %sysfunc(countw(&all_views));
                        %let view = %scan(&all_views, &view_i);
                        write open array;
                           %do pub_varnum=1 %to %sysfunc(countw(&&view_&view._vars));
                              %let pub_valuevar = pub_syk_%scan(&pub_sykehus, &pub_sykehus_i)_&pub_year._&view_i._&pub_varnum;
	                           write values &&&pub_valuevar;
                           %end;
                        write close;
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
                     %do view_i=1 %to %sysfunc(countw(&all_views));
                        %let view = %scan(&all_views, &view_i);
                        write open array;
                           %do pub_varnum=1 %to %sysfunc(countw(&&view_&view._vars));
                              %let pub_valuevar = pub_region_%scan(&pub_regioner, &pub_region_i)_&pub_year._&view_i._&pub_varnum;
                              write values &&&pub_valuevar;
                           %end;
                        write close;
                     %end;
                  write close;
               %end;
            write close;
         %end;
      write close;
   write close;
run;

%mend publiser_rate;

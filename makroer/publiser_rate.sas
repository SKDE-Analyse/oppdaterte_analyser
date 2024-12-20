﻿

%include "&oppdatering_filbane/makroer/assemble.sas";
%include "&oppdatering_filbane/makroer/analyser_parse_dataspecifier.sas";
%include "&filbane/rateprogram/standard_rate.sas";

%macro publiser_rate(
   name,
   total=,
   custom_views=,
   summary=,
   discussion=,
   info=,
   description=,
   title=,
   tags=,
   min_age=,
   max_age=,
   kjonn=begge
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

%do pub_level_i=1 %to 2;
   %let pub_level = %scan(sykehus region, &pub_level_i);
   %if &pub_level = sykehus
      %then %let region=bohf;
   %else    %let region=borhf;

   %standard_rate(
      pub_assembled/&analyse_varlist,
      region=&region,
      %if &min_age ^= %then min_age=&min_age, ;
      %if &max_age ^= %then max_age=&max_age, ;
      kjonn=&kjonn,
      out=pub_&pub_level._rate
   )

   proc sql noprint;
   select min(year), max(year)
      into :pub_min_year, :pub_max_year
      from pub_&pub_level._rate_yearly;
   quit;

   
   proc sql noprint;
   select &region format=4.
      into :pub_&pub_level separated by " "
      from pub_&pub_level._rate;
   quit;

   data _null_;
      set pub_&pub_level._rate;
      %do pub_year=&pub_min_year %to &pub_max_year;
         call symput(cats("pub_&pub_level._", &region, "_&pub_year._total_obs"),
                     &total._ant&pub_year
         );
         %do view_i=1 %to %sysfunc(countw(&all_views));
            %let view = %scan(&all_views, &view_i);
            %do pub_varnum=1 %to %sysfunc(countw(&&view_&view._vars));
               call symput(cats("pub_&pub_level._", &region, "_&pub_year._&view_i._&pub_varnum"),
                           %scan(&&view_&view._vars, &pub_varnum)_rate&pub_year
               );
            %end;
         %end;
      %end;
   run;
%end;

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
   write values "info";        %lang_object(&info)
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
      %do pub_level_i=1 %to 2;
         %let pub_level = %scan(sykehus region, &pub_level_i);
         write values "&pub_level";
         write open object;
            %do pub_i=1 %to %sysfunc(countw(&&&pub_&pub_level));
               write values "%scan(&&&pub_&pub_level, &pub_i)";
               write open object;
                  %do pub_year=&pub_min_year %to &pub_max_year;
                     write values "&pub_year";
                     write open array;
                        %do view_i=1 %to %sysfunc(countw(&all_views));
                           %let view = %scan(&all_views, &view_i);
                           write open array;
                              %do pub_varnum=1 %to %sysfunc(countw(&&view_&view._vars));
                                 %let pub_valuevar = pub_&pub_level._%scan(&&&pub_&pub_level, &pub_i)_&pub_year._&view_i._&pub_varnum;
	                              write values %sysfunc(round(&&&pub_valuevar, 0.001));
                                 %if &view_i=1 %then %do;
                                    %let pub_total_obs = pub_&pub_level._%scan(&&&pub_&pub_level, &pub_i)_&pub_year._total_obs;
                                    write values &&&pub_total_obs;
                                 %end;
                              %end;
                           write close;
                        %end;
                     write close;
                  %end;
               write close;
            %end;
         write close;
      %end;
   write close;
run;

%mend publiser_rate;

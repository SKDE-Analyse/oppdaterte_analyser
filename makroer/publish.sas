

%macro chart(type, specifier, category, description, description_en) / minoperator;
%global pub_data;

%let regex   = ^(\w*)\/([\w<>\s]*)$;
%let pub_dataset = %sysfunc(prxchange(s/&regex/$1/, 1, &specifier));
%let pub_varlist = %sysfunc(prxchange(s/&regex/$2/, 1, &specifier));

%if not %sysfunc(findw(&pub_data, &pub_dataset)) %then %do;
   %let pub_data = &pub_data &pub_dataset;
%end;


%let pub_data_n = 0;
%do %until(&pub_dataset = %scan(&pub_data, &pub_data_n));
   %let pub_data_n = %eval(&pub_data_n + 1);
%end;

%global pub_dsvarlist_&pub_data_n
        pub_categories_&pub_data_n;

%if not %sysfunc(findw(&&pub_categories_&pub_data_n, &category)) %then %do;
   %let pub_categories_&pub_data_n = &&pub_categories_&pub_data_n &category;
%end;


%do pub_i=1 %to %sysfunc(countw(&pub_varlist, %str( )));
   %if not %sysfunc(prxmatch(/\b%scan(&pub_varlist, &pub_i, %str( ))((?<=>)|\b)/, &&pub_dsvarlist_&pub_data_n))
   %then %do;
      %let pub_dsvarlist_&pub_data_n = &&pub_dsvarlist_&pub_data_n %scan(&pub_varlist, &pub_i, %str( ));
   %end;
%end;


   write open object;
      write values "type" "&type";
      write values "category" "&category";
	  write values "description";
      write open object;
         write values "no" %if &description ^=    %then &description;    %else "";;
         write values "en" %if &description_en ^= %then &description_en; %else "";;
	  write close;

      write values "variables";
      write open array;
         %do pub_i=1 %to %sysfunc(countw(&pub_varlist, %str( )));
            write values "%scan(&pub_varlist, &pub_i, %str( ))";
         %end;
      write close;
      write values "data_id" "&pub_dataset";
   write close;


%mend chart;

%macro barchart(specifier, category=bohf, description=, description_en=) / minoperator;
   %chart(barchart, &specifier, &category, &description, &description_en);
%mend barchart;

%macro linechart(specifier, category=bohf, description=, description_en=) / minoperator;
   %chart(linechart, &specifier, &category, &description, &description_en);
%mend linechart;


%macro publish(json_path, charts, tags=);

data _null_;
  unix_dt= "01jan1970 0:0:0"dt;
  *call symput("published", trim(left(put(round(datetime()*1000 - unix_dt*1000), 16.))));

  published = tzones2u(datetime(), "Europe/Oslo") * 1000 - unix_dt * 1000;
  call symput("published", published);
run;

%do pub_i=1 %to %sysfunc(countw(&pub_data));

   proc sql noprint;
   select distinct name
      into :pub_dsvarlist_expanded_&pub_i separated by " "
      from dictionary.columns
      where libname="WORK"
         and memname=upper("%scan(&pub_data, &pub_i)")
         and (0 %do pub_j=1 %to %sysfunc(countw(&&pub_dsvarlist_&pub_i, %str( )));
		    %let pub_var = %sysfunc(prxchange(s/<\w+>/\\d\+/, 1,
               %scan(&&pub_dsvarlist_&pub_i, &pub_j, %str( )) ));
            or prxmatch("/&pub_var/", name)
         %end;);
   quit;
%end;

proc json out=&json_path pretty;

   write values "tags";
   write open array;
      %if "&tags" ^= "" %then %do;
         %do pub_i=1 %to %sysfunc(countw(&tags, %str( )));
            write values "%scan(&tags, &pub_i, %str( ))";
         %end;
	  %end;
   write close;

   write values "name" %sysfunc(prxchange(s/^".*\/(\w+)\.json"$/$1/, 1, &json_path));

   write values "published" &published;

   write values "graphs";
   write open array;
      &charts
   write close;

   write values "data";
   write open object;
      %do pub_i=1 %to %sysfunc(countw(&pub_data));
         write values "%scan(&pub_data, &pub_i)";
   	     write open array;
            export %scan(&pub_data, &pub_i) (keep=&&pub_categories_&pub_i &&pub_dsvarlist_expanded_&pub_i) / keys nosastags fmtnumeric fmtcharacter;
         write close;
      %end;
   write close;
run;

%do pub_i=1 %to %sysfunc(countw(&pub_data));
   %symdel pub_categories_&pub_i
           pub_dsvarlist_&pub_i;
 
%end;
%symdel pub_data;

%mend publish;


%macro analyser_parse_dataspecifier(specifier, ds_var=, varlist_var=);
%global &ds_var &varlist_var;

%let regex   = ^(\w*)\/([\w ]*)$;
%let dataset = %sysfunc(prxchange(s/&regex/$1/, 1, &specifier));
%let varlist = %sysfunc(prxchange(s/&regex/$2/, 1, &specifier));

data _null_;
  call symput("&ds_var", "&dataset");
  call symput("&varlist_var", "&varlist");
run;

%mend analyser_parse_dataspecifier;
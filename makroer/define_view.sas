

%macro define_view(name=, variables=, title=, label_1=, label_2=, label_3=, label_4=, label_5=);
%global view_&name._vars
        view_&name._title
        view_&name._label_1
        view_&name._label_2
        view_&name._label_3
        view_&name._label_4
        view_&name._label_5;

%let view_&name._vars  = &variables;
%let view_&name._title = &title;
%let view_&name._label_1 = &label_1;
%let view_&name._label_2 = &label_2;
%let view_&name._label_3 = &label_3;
%let view_&name._label_4 = &label_4;
%let view_&name._label_5 = &label_5;

&name
%mend define_view;




%define_view(
  name=off_priv,
  variables=off priv,
  title=%str(no := Enkeltår, offentlig/privat
          || en := Single year, public/private),
  label_1=%str(no := Offentlig || en := Public),
  label_2=%str(no = Privat || en = Private)
)

%put &=view_off_priv_vars;
%put &=view_off_priv_title;
%put &=view_off_priv_label_1;
%put &=view_off_priv_label_2;

%macro get_lang(lang, string);
%do oppd_index=1 %to %sysfunc(countw(&string, ||));
   %let lang_string = %scan(&string, &oppd_index, ||);
   %let re = ^\s*([a-z]{2})\s*:=(.*);
   %if &lang = %sysfunc(prxchange(s/&re/$1/, -1, %quote(&lang_string))) %then %do;
      %sysfunc(prxchange(s/&re/$2/, -1, %quote(&lang_string)))
      %return;
   %end;
%end;
%mend get_lang;

%get_lang(no, &view_off_priv_label_1)


%macro npr_kodematch(koder, regexes);
   prxmatch("/\b(%sysfunc(prxchange(s/\s+/|/, -1, &regexes)))/", &koder)
%mend npr_kodematch;

%macro npr(datasets,
	periode=,
	in_diag=,
	ut_diag=,
	in_pros=,
	ut_pros=,
	aktivitetskategori3=1 2 3,
	where=1
) / minoperator;
   %let start = %sysfunc(prxchange(s/(\d+)-\d+/$1/, 1, &periode));
   %let end   = %sysfunc(prxchange(s/\d+-(\d+)/$1/, 1, &periode));
   %let dslist = ;

   %do current_year=&start %to &end;
      %if &current_year < 2017 %then %do;
         %let avd   = SKDE20.T20_AVD_&current_year     (drop=fagenhetKode oppholdstype where=(aktivitetskategori3 in (&aktivitetskategori3) and &where));
         %let aspes = SKDE20.T20_avtspes_&current_year (drop=sektor_org kontakt_org fag where=(&where));
      %end;
      %else %do;
         %let avd   = hnana.avd_&current_year._t3 (where=(aktivitetskategori3 in (&aktivitetskategori3) and &where));
         %let aspes = hnana.aspes_&current_year._t3 (where=(&where));
      %end;
   
      /*&avd*/
      %if avd   in (&datasets) %then %let dslist = &dslist &avd;
      %if aspes in (&datasets) %then %let dslist = &dslist &aspes;
   %end;

   set &dslist;

   all_diag = catx(" ", of Hdiag Hdiag2 bdiag:);
   %if &in_diag ^= %then if     %npr_kodematch(all_diag, &in_diag);;
   %if &ut_diag ^= %then if not %npr_kodematch(all_diag, &ut_diag);;

   all_pros = catx(" ", of ncmp: ncsp: ncrp:);
   %if &in_pros ^= %then if     %npr_kodematch(all_pros, &in_pros);;
   %if &ut_pros ^= %then if not %npr_kodematch(all_pros, &ut_pros);;


%mend npr;



%macro npr_kodematch(koder, regexes);
   prxmatch("/\b(%sysfunc(prxchange(s/\s+/|/, -1, &regexes)))/", &koder)
%mend npr_kodematch;

proc format;
   value ermann_fmt
      0 = 'Kvinne'
      1 = 'Mann';
   value beh_kat
      1 = 'Eget HF'
      2 = 'Annet HF'
      3 = 'Privat';
run;

/*

  Denne koden er for å lage et standard datasett med variablene %npr alltid skal ha, sånn
  at man ikke får problemer med å merge datasett laget på forskjellig måte med %npr.


%macro sas_is_dumb;
data helseatl.npr_macro_std_vars;
   retain pid aar alder ermann inndato inntid utdato uttid ermann aktivitetskategori3 borhf bohf komnr hdiag3tegn hdg beh_kat kontakttype
          inntilstand uttilstand fagomrade episodefag frasted nytilstand boshhn bodps behsh behhf behrhf institusjonid behandlingsstedkode
          drg drg_type bydel henvtype frittbehandlingsvalg omsorgsniva g_omsorgsniva henvtiltjeneste henvfratjeneste debitor niva;

   retain hdiag hdiag2;
   length bdiag1-bdiag19 $6
          ncmp1-ncmp20 $7
          ncrp1-ncrp20 $7
          ncsp1-ncsp20 $7;
   retain normaltariff1-normaltariff15 takst_1-takst_15;

   %do year=2015 %to 2023;
      %if &year < 2017 %then %do;
         set SKDE20.T20_AVD_&year (drop=fagenhetKode oppholdstype obs=0);
         set SKDE20.T20_avtspes_&year (drop=sektor_org kontakt_org fag obs=0);
      %end;
      %else %do;
         set hnana.avd_&year._t3 (obs=0);
         set hnana.aspes_&year._t3 (obs=0);
      %end;
   %end;
run;
%mend sas_is_dumb;
%sas_is_dumb

*/

%macro npr(datasets,
   periode=,
   normaltariff=,
   in_diag=,
   ut_diag=,
   in_hdiag=,
   ut_hdiag=,
   in_pros=,
   ut_pros=,
   aktivitetskategori3=1 2 3,
   where=1,
   format=no
) / minoperator;

   /* Fjerner ukjent og utenland borhf (24 og 99) */
   %let where = borhf < 5 and &where;

   %let start = %sysfunc(prxchange(s/(\d+)-\d+/$1/, 1, &periode));
   %let end   = %sysfunc(prxchange(s/\d+-(\d+)/$1/, 1, &periode));
   %let dslist = helseatl.npr_macro_std_vars ;

   %do current_year=&start %to &end;
      %if &current_year < 2017 %then %do;
         %let avd   = SKDE20.T20_AVD_&current_year     (drop=fagenhetKode oppholdstype where=(aktivitetskategori3 in (&aktivitetskategori3) and &where));
         %let sho   = SKDE20.T20_SHO_&current_year     (drop=fagenhetKode oppholdstype where=(aktivitetskategori3 in (&aktivitetskategori3) and &where));
         %let aspes = SKDE20.T20_avtspes_&current_year (drop=sektor_org kontakt_org fag  where=(&where));
      %end;
      %else %do;
         %let avd   = hnana.avd_&current_year._t3 (where=(aktivitetskategori3 in (&aktivitetskategori3) and &where));
         %let sho   = hnana.sho_&current_year._t3 (where=(aktivitetskategori3 in (&aktivitetskategori3) and &where));
         %let aspes = hnana.aspes_&current_year._t3 (where=(&where));
      %end;
   
      /*&avd*/
      %if avd   in (&datasets) %then %let dslist = &dslist &avd;
      %if sho   in (&datasets) %then %let dslist = &dslist &sho;
      %if aspes in (&datasets) %then %let dslist = &dslist &aspes;
   %end;

   set &dslist;

   length all_diag $200
          all_pros $600;

   %if &format=yes %then %do;
      format ermann ermann_fmt.       aktivitetskategori3 aktivitetskategori3f.
             borhf  borhf_fmt.        bohf   bohf_fmt.         komnr  komnr_fmt.        hdiag3tegn $hdiag3tegn.
             hdg hdg.                 beh_kat beh_kat.         kontakttype kontakttype. inntilstand inntilstand.
             uttilstand  uttilstand.  fagomrade $fagomrade.    episodefag $episodefag.  frasted frasted.
             nytilstand nytilstand.   boshhn boshhn_fmt.       bodps  bodps_fmt.        behsh  behsh_fmt.
             behhf  behhf_fmt.        behrhf behrhf_fmt.       institusjonid org_fmt.   behandlingsstedkode org_fmt.
             drg    $drg.             drg_type $drg_type.      bydel  bydel_fmt.        henvtype henvtype.
             frittbehandlingsvalg frittbehandlingsvalg.        omsorgsniva omsorgsniva. g_omsorgsniva g_omsorgsniva.
             henvtiltjeneste henvtiltjeneste.                  henvfratjeneste henvfratjeneste.
             debitor debitor.         niva $niva.              hdiag hdiag2 bdiag1-bdiag19 $icd10_fmt.
             ncmp1-ncmp20 $ncmp.      ncrp1-ncrp20 $ncrp.      ncsp1-ncsp20 $ncsp.;
      retain normaltariff1-normaltariff15 takst_1-takst_15;
   %end;

   if _N_ = 1 then do;
      declare hash behandler(dataset: "hnref.bo_beh_kat3");
      behandler.defineKey('boHF', 'BehHF');
      behandler.defineData('beh_kat');
      behandler.defineDone();
   end;


   %if &normaltariff ^= %then %do;
      if %npr_kodematch(catx(" ", of Normaltariff:), &normaltariff);
   %end;

   all_diag = catx(" ", of Hdiag Hdiag2 bdiag:);
   all_pros = catx(" ", of ncmp: ncsp: ncrp:);

   %if "&in_diag"  ^= "" %then if     %npr_kodematch(all_diag, &in_diag);;
   %if "&ut_diag"  ^= "" %then if not %npr_kodematch(all_diag, &ut_diag);;

   %if "&in_hdiag" ^= "" %then if     %npr_kodematch(Hdiag, &in_hdiag);;
   %if "&ut_hdiag" ^= "" %then if not %npr_kodematch(Hdiag, &ut_hdiag);;

   %if "&in_pros"  ^= "" %then if     %npr_kodematch(all_pros, &in_pros);;
   %if "&ut_pros"  ^= "" %then if not %npr_kodematch(all_pros, &ut_pros);;

   if AvtaleRHF or avtspes then behHF = 27;
   behandler.find(); /* Fills in the correct value in beh_kat */

   eget_hf   = beh_kat = 1;
   annet_hf  = beh_kat = 2;
   privat    = beh_kat = 3;
   offentlig = not privat;

%mend npr;


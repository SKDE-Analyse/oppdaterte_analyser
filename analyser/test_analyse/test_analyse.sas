%let oppdatering_filbane=/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser;
%let filbane=/sas_smb/skde_analyse/Data/SAS/felleskoder/main;

%include "&oppdatering_filbane/makroer/setup.sas";

data test_analyse;
   %NPR(avd aspes,
      periode=2015-2023,
	   in_diag=J45 J46, /* Astma + akutt astma */
	   where=alder < 18
   )
   astma = 1;
run;


%oppdater(test_analyse,
   total=astma,
   variables=offentlig privat,
   force_update=true
)


%publiser_rate(test_analyse,
   total=astma,
   custom_views=
     %define_view(
        name=off_priv, /* %define_view "returns" name (off_priv) */
        variables=offentlig privat,
        title=%str(no := Enkeltår, offentlig/privat
                || en := Single year, public/private),
        label_1=no := Offentlig || en := Public,
        label_2=no := Privat || en := Private),
   title=
      no := Astma hos barn
   || en := Asthma among children,
   summary =
   no := - Asthma-kontakter pr. 1 003 barn.
      \n - Andre ting.
|| en := - Asthma contacts pr. 1 000 children.
      \n - Other things.,
   info =
   no := - utvalg info blabla.
      \n - Andre ting.
|| en := - blabla in english.
      \n - Other things.,
   discussion=%str(
      no := Dette er en relativt kort diskussjon, på circa et par paragrafer.
            Diskusjonen skal ikke være for lang, fordi det vil gjøre det vanskeligere
            å oppdatere hvert år.
   || en := This is a rather short intruduction, of approximately two paragraphs. The
            discussion should not be too long, so that it%'s easier to update each
            year.),
   tags=barn astma
)
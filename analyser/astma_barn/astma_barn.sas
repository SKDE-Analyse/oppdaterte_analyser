%let oppdatering_filbane=/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser;
%let filbane=/sas_smb/skde_analyse/Data/SAS/felleskoder/main;

%include "&oppdatering_filbane/makroer/setup.sas";

data astma_barn;
  %NPR(avd aspes,
    periode=2020-2023,
	 in_diag=J45 J46, /* Astma + akutt astma */
	 where=alder < 18
  )
  astma = 1;
  priv = astma and not hf;
  off  = astma and hf;
run;

%standard_rate(astma_barn/priv off,
  region=bohf,
  out=astma_out
)



%oppdater(astma_barn,
   total=astma,
   variables=off priv,
   force_update=true
)


%publiser_rate(astma_barn,
   total=astma,
   custom_views=
     %define_view(
        name=off_priv, /* %define_view "returns" name (off_priv) */
        variables=off priv,
        title=%str(no := Enkeltår, offentlig/privat
                || en := Single year, public/private),
        label_1=no := Offentlig || en := Public,
        label_2=no := Privat || en := Private),
   title=
      no := Astma hos barn
   || en := Asthma among children,
   summary =
   no :=%nrbquote(
- Asthma-kontakter pr. 1 003 barn.
- Andre ting.)
|| en :=
- Asthma contacts pr. 1 000 children.
- Other things.,
   discussion=%str(
      no := Dette er en relativt kort diskussjon, på circa et par paragrafer.
            Diskusjonen skal ikke være for lang, fordi det vil gjøre det vanskeligere
            å oppdatere hvert år.
   || en := This is a rather short intruduction, of approximately two paragraphs. The
            discussion should not be too long, so that it%'s easier to update each
            year.),
   tags=barn astma
)

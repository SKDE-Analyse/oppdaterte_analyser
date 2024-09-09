%let oppdatering_filbane=/sas_smb/skde_analyse/Brukere/Mattias/oppdaterte_analyser;
%let filbane=/sas_smb/skde_analyse/Data/SAS/felleskoder/main;

%include "&oppdatering_filbane/makroer/setup.sas";



data astma_barn;
  %NPR(avd aspes,
     periode=2018-2020,
	 in_diag=J45 J46, /* Astma + akutt astma */
	 where=alder < 18
  )
  astma = 1;
  priv = astma and not hf;
  off  = astma and hf;
run;


/*

	Skille mellom privat/offentlig: aspes-filer har variabelen AvtaleRHF. Dette stemmer også for SKDE20

*/



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
        label_1=no := Offentligish || en := Publicish,
        label_2=no := Privatish || en := Privateish),
   title=
     no := Astma hos barn
  || en := Asthma among children,
   description=
	 no := Et eller annet pr. 1 000 innbyggere.
  || en := Something or other pr. 1 000 inhabitants.,
   tags=barn astma
)

%let oppdatering_filbane=/sas_smb/skde_analyse/Brukere/Mattias/oppdaterte_analyser;
%let filbane=/sas_smb/skde_analyse/Data/SAS/felleskoder/main;

%include "&oppdatering_filbane/makroer/npr.sas";
%include "&oppdatering_filbane/makroer/oppdater.sas";
%include "&oppdatering_filbane/makroer/assemble.sas";
%include "&oppdatering_filbane/makroer/publiser_rate.sas";
%include "&oppdatering_filbane/makroer/define_view.sas";
%include "&filbane/rateprogram/standard_rate.sas";
%include "&filbane/formater/bo.sas";

data astma_barn;
  %NPR(avd aspes,
     periode=2018-2020,
	 in_diag=J45 J46, /* Astma + akutt astma */
	 where=alder < 18
  )
  astma = 1;
run;

%oppdater(astma_barn/astma, force_update=true) /* Oppdater de månedene som det ikke allerede finnes data for */



%publiser_rate(
   astma_barn/astma,
   description="Ët eller annet pr. 10 000 innbyggere.",
   description_en="Something or other pr. 10 000 inhabitants.",
   tags=barn astma
)


/*

	Skille mellom privat/offentlig: aspes-filer har variabelen AvtaleRHF. Dette stemmer også for SKDE20

*/



%oppdater(astma_barn
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
                   en := Single year, public/private),
        label_1=%str(no := Offentligish
                     en := Publicish),
        label_2=%str(no := Privatish
                     en := Privateish))
     %define_view(
        name=off_priv2,
        variables=off2 priv2,
        title=%str(no := Enkeltår, offentlig/privat
                   en := Single year, public/private),
        label_1=%str(no := Offentligish
                     en := Publicish),
        label_2=%str(no := Privatish
                     en := Privateish)),
   title=
	 no := Astma hos barn
     en := Asthma among children,
   description=
	 no := Et eller annet pr. 1 000 innbyggere.
     en := Something or other pr. 1 000 inhabitants.,
   tags=barn astma
)

%let var = 11;
%let n_var_&var = hello;
%put &&n_var_&var;
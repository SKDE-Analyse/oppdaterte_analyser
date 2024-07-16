%let oppdatering_filbane=/sas_smb/skde_analyse/Brukere/Mattias/oppdaterte_analyser;
%let filbane=/sas_smb/skde_analyse/Data/SAS/felleskoder/main;

%include "&oppdatering_filbane/makroer/npr.sas";
%include "&oppdatering_filbane/makroer/oppdater.sas";
%include "&oppdatering_filbane/makroer/assemble.sas";
%include "&oppdatering_filbane/makroer/publish.sas";
%include "&filbane/rateprogram/standard_rate.sas";
%include "&filbane/formater/bo.sas";

data astma_barn;
  %NPR(avd aspes,
     periode=2018-2020,
	 in_diag=J45 J46, /* Astma + akutt astma */
	 ut_diag=,
	 in_pros=,
     ut_pros=, /*WG,  Allergitester */
	 where=alder < 18
  )

  astma = 1;
run;

%oppdater(astma_barn/astma, force_update=true) /* Oppdater de månedene som det ikke allerede finnes data for */

%assemble(
  /* Finner alle aggregerte data for astma_barn, og aggregerer på bohf-nivå (istedenfor komnr, bydel) */
  astma_barn,
  out=astma_barn_ut
)

%standard_rate( /* Lager rate på vanlig måte */
   astma_barn_ut/astma,
   region=bohf,
   out=astma_barn_rate
)

%standard_rate( /* Lager rate på vanlig måte */
   astma_barn_ut/astma,
   region=bohf,
   out=astma_barn_rate2
)


/*
   Her skal man kunne definere graf-typer med makroer, og SAS vil konvertere til .json
*/

%publish("&oppdatering_filbane/webdata/astma_barn.json",
   %barchart(astma_barn_rate/astma_rate<year>,
             description="Ët eller annet pr. 10 000 innbyggere.",
			 description_en="Something or other pr. 10 000 inhabitants.")
   %linechart(astma_barn_rate_yearly/astma_<bohf>, category=year),
   tags=barn astma 
)


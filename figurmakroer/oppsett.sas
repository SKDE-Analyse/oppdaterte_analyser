
/*Analysetekst*/
%include "&oppdatering_filbane/analyser/&tema./text/&sluttaar..sas";

/*Bildesti*/
%let bildesti =/sas_smb/skde_analyse/helseatlas/oppdaterte_analyser/Figurer/&sluttaar._figurer/&tema;

/*Figurmakroer*/
%include "&oppdatering_filbane/figurmakroer/total_figurer.sas";
%include "&oppdatering_filbane/figurmakroer/panelfigur_todelt.sas";
%include "&oppdatering_filbane/figurmakroer/panelfigur_tredelt.sas";
%include "&oppdatering_filbane/figurmakroer/rate_alder_kjonn.sas";
%include "&oppdatering_filbane/figurmakroer/dim_rate_alder_kjonn.sas";

/*Generelle makroer*/
%let filbane=/sas_smb/skde_analyse/Data/SAS/felleskoder/main;
%include "&filbane/makroer/beh_eget_annet_priv.sas";
%include "&filbane/stiler/anno_logo_kilde_npr_ssb.sas";
%include "&filbane/rateprogram/graf.sas";

%let filbane=/sas_smb/skde_analyse/Data/SAS/felleskoder/main;
%include "&oppdatering_filbane/makroer/npr.sas";
%include "&oppdatering_filbane/makroer/oppdater.sas";
%include "&oppdatering_filbane/makroer/assemble.sas";
%include "&oppdatering_filbane/makroer/publiser_rate.sas";
%include "&oppdatering_filbane/makroer/define_view.sas";

%include "&filbane/rateprogram/standard_rate.sas";
%include "&filbane/formater/bo.sas";


%let filbane=/sas_smb/skde_analyse/Data/SAS/felleskoder/main;
%include "&oppdatering_filbane/makroer/npr.sas";
%include "&oppdatering_filbane/makroer/oppdater.sas";
%include "&oppdatering_filbane/makroer/assemble.sas";
%include "&oppdatering_filbane/makroer/publiser_rate.sas";
%include "&oppdatering_filbane/makroer/define_view.sas";

%include "&filbane/rateprogram/standard_rate.sas";
%include "&filbane/formater/bo.sas";
%include "&filbane/formater/beh.sas";
%include "&filbane/formater/drg.sas";
%include "&filbane/formater/icd10.sas";
%include "&filbane/formater/ncmp.sas";
%include "&filbane/formater/ncrp.sas";
%include "&filbane/formater/ncsp.sas";
%include "&filbane/formater/hdiag3tegn.sas";
%include "&filbane/formater/NPR_somatikk.sas";
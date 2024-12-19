%let oppdatering_filbane=/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser;
%include "&oppdatering_filbane/makroer/setup.sas";
%include "&filbane/makroer/kodematch.sas";

/*************************************
 GJØR ENDRINGER I DENNE LILLE BOLKEN
*************************************/
%let tema=ivf;
%let startaar=2015;
%let sluttaar=2023;
/****************************************
 OG TILPASS MAKROER ETTER PUBLISER_RATE
*****************************************/

%include "&oppdatering_filbane/figurmakroer/oppsett.sas";



data ivf_kont;
   %NPR(avd,
      periode=&startaar-&sluttaar,
	   in_pros=LCA30 LCW30K LCW31K,
      where=ermann=0 and 18 <= alder <= 46
   )
   ivf = 1;

   /*
    Bioteknologiloven: (https://lovdata.no/dokument/NL/lov/2003-12-05-100/KAPITTEL_2#KAPITTEL_2)

      Kapittel 2. Assistert befruktning
        § 2-1.Definisjoner
          I denne lov forstås med:

            a.	assistert befruktning: inseminasjon og befruktning utenfor kroppen;
            b.	inseminasjon: innføring av sæd i kvinnen på annen måte enn ved samleie;
            c.	befruktning utenfor kroppen: befruktning av egg utenfor kvinnens kropp.

        § 2-3 a.Aldersgrense for assistert befruktning
          Kvinne som skal motta assistert befruktning, kan ikke være eldre enn fylte 46 år ved inseminasjon eller innsetting av befruktet egg.
          Kommentar: ^ Tilføyd i 2020. I og med at kvinnen må være 18 for å gi samtykke til assistert befruktning (samme lov),
                       så betyr det at aldersgrensen i dag er 18-46.
   */

   over39 = alder >= 39;
   under39 = not over39;
run;


proc sql;
create table ivf_ordered as
   select * from ivf_kont
   order by aar, pid, utdato desc, uttid desc;
run;

data ivf; /* En rad pr pasient pr år */
   set ivf_ordered;
   by aar pid;
   if first.pid then output;
run;


%oppdater(ivf,
   total=ivf,
   variables=eget_hf annet_hf over39 under39,
   force_update=true
)




%include "&oppdatering_filbane/analyser/&tema./text/&sluttaar..sas";

%publiser_rate(ivf,
   total=ivf,
   kjonn=kvinner,
   custom_views=
     %define_view(
        name=eget_annet_hf,
        variables=eget_hf annet_hf,
        title=%str(no := Eget hf/annet hf
                || en := Own health trust/other health trust),
        label_1=no := Eget HF  || en := Own health trust,
        label_2=no := Annet HF || en := Other health trust)
     %define_view(
        name=over_under39,
        variables=under39 over39,
        title=%str(no := Alder over/under 39
                || en := Age over/under 39),
        label_1=no := Under 39 år || en := Younger than 39,
        label_2=no := 39 år eller eldre || en := 39 years or older),
   title= no := In vitro fertilisering
       || en := In vitro fertilization,
   &settinn_txt,
   tags=
)


%let tema=ivf;
%total_figurer;
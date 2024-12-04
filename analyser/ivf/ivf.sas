%let oppdatering_filbane=/sas_smb/skde_analyse/Helseatlas/oppdaterte_analyser_kloner/Mattias;
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

%include "&oppdatering_filbane/analyser/&tema./text/&sluttaar..sas";
%include "&oppdatering_filbane/figurmakroer/oppsett.sas";


data ivf_kont;
   %NPR(avd,
      periode=&startaar-&sluttaar,
	   in_pros=LCA30 LCW30K,
      where=ermann=0 and 16 <= alder <= 55,
      format=no
   )
   ivf = 1;

   /*
    Typer assistert befruktning:
     * IVF: LCA30 LCW30K (Dette inkluderer ICSI). Inkluderer det FET? Andre typer assistert befruktning?
     * Intrauterin inseminasjon: LCGX20
     * ICSI: LCGX10

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
   select * from ivf
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


%publiser_rate(ivf,
   total=ivf,
   kjonn=kvinner,
   custom_views=
     %define_view(
        name=eget_annet_hf,
        variables=eget_hf annet_hf,
        title=%str(no := Enkeltår, eget hf/annet hf
                || en := Single year, own health trust/other health trust),
        label_1=no := Eget HF  || en := Own health trust,
        label_2=no := Annet HF || en := Other health trust)
     %define_view(
        name=over_under39,
        variables=under39 over39,
        title=%str(no := Enkeltår, alder
                || en := Single year, age),
        label_1=no := Under 39 år || en := Younger than 39,
        label_2=no := Over 39 år || en := Older than 39),
   &settinn_txt,
   tags=kvinner ivf
)


%let tema=ivf;
%total_figurer;
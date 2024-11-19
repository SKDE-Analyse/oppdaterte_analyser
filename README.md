Dette er dokumentasjon, i *markdown*.
## Mappen "analyser"
I denne mappen ligger alle SAS-filene som genererer de ulike "analyseboksene". For hver analyse/analyseboks lages det en mappe og hver mappe inneholder en SAS-fil.
Mappen skal ha navn som identifiserer den aktuelle analysen, og SAS-filen inni mappen skal ha samme navn.

Inni SAS-filen samles både tekst i analyseboksen:
- diskusjon,
- informasjon/utvalg,
- labels,
- aksetekster osv.
og all kode:
- utvalg,
- oppdeling ved flerdelt søyle,
- aggregering,
- rateprogram,
- produksjon av jsonfil,
- figurproduksjon for skriving/analyse

Følgende makroer anvendes for å lage data til analyseboksen:
- npr
- beh_eget_annet_priv (som regel)
- oppdater
- publiser_rate

SAS-filene skal ha egen dokumentasjon som består av informasjon om:
- hvem som sist gjennomførte analysen
- eventuelle endringer i utvalgskoder

Figurer som lages for til bruk i analyse/skriveprosessen skal lagres på Q i mappen oppdaterte_analyser/Figurer 
I mappen oppdaterte_analyser/Figurer skal hver analyse/analyseboks ha sin egen mappe (speiler oppsett i mappen "analyser") 
hvor alle figurer som hører til den aktuelle analysen/analyseboksen legges.

## Mappen "figurmakroer"
I denne mappen samles alle figurermakroer som brukes i analyse/skriveprosessen. 

## Mappen "makroer"
I denne mappen samles alle makroer som brukes i **produksjonen av data og tekst som skal inn i jsonfilen** og til nettsiden.

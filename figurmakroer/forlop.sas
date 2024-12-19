%macro forlop(inndata=, indeks=, event=);
/* Indeks er kontakten/raden man tar utgangspunkt i og
event er hendelsen som kommer i etterkant av indeks */

proc sort data=&inndata.; 
    by pid descending inndato; 
run;
 
data &inndata;
set &inndata.;
retain forste_&event._etter dato_&event.; 
by pid; 
if first.pid then do;
		forste_&event._etter = .;
		dato_&event.=.;
		end; 
if &event. eq 1 then do;
	forste_&event._etter =.;
	dato_&event. = inndato;
	end; 
if dato_&event. ne . and &indeks. eq 1 then forste_&event._etter+1; /*markere første event etter indeks*/ 
format dato_&event. eurdfdd10.;
run;
 
data &inndata;
set &inndata; 
if  &indeks. eq . then forste_&event._etter = .; 
/*beregn dager mellom indeks og event */
if forste_&event._etter eq 1 then dager_etter_&indeks = dato_&event. - inndato; 
drop forste_&event._etter dato_&event.;
run;
 
proc sort data=&inndata; by pid inndato;run;
%mend forlop;
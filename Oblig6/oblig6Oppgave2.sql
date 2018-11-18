/*TESTDATA*/
Insert
Insert
Insert
Insert

/*Skriv SQL-spørringer som henter ut følgende informasjon: */

/*1. En liste over alle kunder. Listen skal inneholde kundenummer, kundenavn og kundeadresse. */

select kundenummer, kundenavn, kundeadresse
from Kunde
order by kundenummer asc; /*laveste forst*/

/*2. Alle telefonnummer som er lagret i databasen, samt hvilke kundenummer de tilhører. Listen skal være sortert etter fallende kundenummer*/
select nummer, kundenummer
from Telefonnummer
order by kundenummer desc; /*høyeste forst*/

/* 3. En liste over alle ansattnummere som er prosjektledere. Dersom en ansatt er prosjektleder
for flere prosjekter burde ansattnummeret fortsatt kun forekomme en gang i listen. */
select distinct prosjektleder, ansattnr
from Prosjekt P, Ansatt A
where P.prosjektleder = A.ansattnr
order by ansattnr desc;

/* 4. Alle ansattnummerene som er knyttet til prosjektet med prosjektnavn «Ruter app» IKKE FERDIG*/
select ansattnr, prosjektnavn
from AnsattDeltakerIProsjekt
where prosjektnavn = 'Ruter app'
order by ansattnr desc;

/* 5. En liste over alle ansatte og deres timelønn. Listen skal bestå av ansattnummer og timelønn. */
select ansattnr, timelonn
from Ansatt A, Gruppe G
where A.gruppenavn = G.gruppenavn

/* 6. En liste med org_nummer og kundenavn for alle offentlige etater. */


/*Tips: det kan være lurt a lage testdata til tabellen slik at du får ut reelle svar pa spørringene.*/
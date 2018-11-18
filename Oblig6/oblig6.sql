/* OPGGAVE 1 */
CREATE TABLE Kunde (
	kundenummer 		int primary key,
	kundenavn			varchar(40) not null,
	kundeadresse 		varchar(40) not null,
	kundefakturaadresse varchar(40) not null
);

CREATE TABLE Offentlig_Etat (
	kundenummer 	int primary key references Kunde(kundenummer),
	departement 	varchar(40) not null
);

CREATE TABLE Firma (
	kundenummer 	int primary key references Kunde(kundenummer),
	org_nummer  	int unique not null,
);

CREATE TABLE Telefonnummer(
	nummer 			char(8) primary key,
	kundenummer 	int references Kunde(kundenummer)
);

CREATE TABLE Prosjekt (
	prosjektnummer 	int primary key,
	prosjektleder 	int references Ansatt(ansattnr),
	prosjektnavn 	varchar(15),
	kundenummer 	int references Kunde(kundenummer)
);

CREATE TABLE Ansatt (
	ansattnr 		int primary key,
	gruppenavn 		varchar(15) refences Gruppe(gruppenavn)

);

CREATE TABLE AnsattDeltakerIProsjekt (
	ansattnr 		int references Ansatt(ansattnr),
	prosjektnr 		int eferences Prosjekt(prosjektnummer),
	primary key(ansattnr, prosjektnr)
);

CREATE TABLE Gruppe (
	gruppenavn		varchar(15) primary key,
 	timelonn 		real
);

/*TESTDATA*/
Insert into Kunde value(123, 'Ruter', 'Dronningens gate 1', 'Henrik Ibsens vei 13');
Insert into OffentligEtat value(123, 'Kollektivtransport: Oslo & Akershus');

Insert into Kunde value(124, 'Jernbaneverket', 'Bjørnstjerne Bjørnsonsvei 12', 'Bjørnstjerne Bjørnsonsvei 12');
Insert into OffentligEtat value(124, 'Kollektivtransport: Infrastruktur og Logistikk');

Insert into Kunde value(125, 'NSB', '', '');
Insert into OffentligEtat value(125,'Kollektivtransport');

Insert into Kunde value(126, '', '', '')
Insert into OffentligEtat value(126,'');

Insert into Kunde value(127, '', '', '');
Insert into OffentligEtat(kundenummer, departement);
value(127, '');
Insert into Kunde(kundenummer, kundenavn, kundeadresse, kundefakturaadresse)
value(128, '', '', '');
Insert into OffentligEtat(kundenummer, departement);
value(128,'');
Insert into Kunde(kundenummer, kundenavn, kundeadresse, kundefakturaadresse)
value(129, '', '', '');
Insert into OffentligEtat(kundenummer, departement);
value(129,'');
Insert into Kunde(kundenummer, kundenavn, kundeadresse, kundefakturaadresse)
value(122, 'Uranienborg skole', 'Briskebyveien 3', 'Uranienborgveien 12');
Insert into OffentligEtat(kundenummer, departement)
value(122,'Utdanning: Grunnskole');
Insert into Ansatt value();
Insert into Ansatt value();
Insert into Anasat value();
Insert into Ansatt value();
Insert into Ansatt(ansattnr, gruppenavn)
value();
Insert into Ansatt(ansattnr, gruppenavn)
value();
Insert into Ansatt(ansattnr, gruppenavn)
value();
Insert into Ansatt(ansattnr, gruppenavn)
value();
Insert into Ansatt(ansattnr, gruppenavn)
value();
Insert into Ansatt value();
Insert into Ansatt(ansattnr, gruppenavn)
value();
Insert into Gruppe(gruppenavn, timelonn)
value();
Insert into Gruppe(gruppenavn, timelonn)
value();
Insert into Gruppe(gruppenavn, timelonn)
value();
Insert into Prosjekt(prosjektnummer, prosjektleder, prosjektnavn, kundenummer)
value(23, 1854, 'Ruter app', 123);
Insert into Prosjekt(prosjektnummer, prosjektleder, prosjektnavn, kundenummer)
value();
Insert into Prosjekt(prosjektnummer, prosjektleder, prosjektnavn, kundenummer)
value();
Insert into Prosjekt(prosjektnummer, prosjektleder, prosjektnavn, kundenummer)
value();
Insert into Telefonnummer value('40001518', 123);
Insert into Telefonnummer value();
Insert into Telefonnummer(nummer, kundenummer)
value();
Insert into Telefonnumer(nummer, kundenummer)
value();
Insert into Telefonnummer(nummer, kundenummer)
value();
Insert into Telefonnummer(nummer, kundenummer)
value();
Insert into Telefonnummer(nummer, kundenummer)
value();
Insert into Telefonnumer(nummer, kundenummer)
value();


/*OPPGAVE 2: Skriv SQL-spørringer som henter ut følgende informasjon: */
/*1. En liste over alle kunder. Listen skal inneholde kundenummer, kundenavn og kundeadresse. */
select kundenummer, kundenavn, kundeadresse
from Kunde
order by kundenummer asc; /*laveste forst*/

/*2. Alle telefonnummer som er lagret i databasen, samt hvilke kundenummer de tilhører. Listen skal være sortert etter fallende kundenummer*/
select *
from Telefonnummer
order by kundenummer desc; /*høyeste forst*/

/* 3. En liste over alle ansattnummere som er prosjektledere. Dersom en ansatt er prosjektleder
for flere prosjekter burde ansattnummeret fortsatt kun forekomme en gang i listen. */
select distinct prosjektleder, ansattnr
from Prosjekt P, Ansatt A
where P.prosjektleder = A.ansattnr
group by ansattnr
order by ansattnr desc;

/* 4. Alle ansattnummerene som er knyttet til prosjektet med prosjektnavn «Ruter app» IKKE FERDIG*/
select ansattnr, prosjektnavn
from AnsattDeltakerIProsjekt
where prosjektnavn = 'Ruter app'
order by ansattnr desc;

/* 5. En liste over alle ansatte og deres timelønn. Listen skal bestå av ansattnummer og timelønn. */
select ansattnr, timelonn, gruppenavn
from Ansatt A, Gruppe G
where A.gruppenavn = G.gruppenavn

/* 6. En liste med org_nummer og kundenavn for alle offentlige etater. */
select org_nummer, kundenavn
from OffentligEtat OE, Kunde K
/* OPGGAVE 1 */
CREATE TABLE Kunde (
	kundenummer 		int primary key
	kundenavn			varchar(40)
	kundeadresse 		varchar(40)
	kundefakturaadresse varchar(40)
);

CREATE TABLE Offentlig_Etat (
	kundenummer int primary key references Kunde(kundenummer)
	departement varchar(40)
);

CREATE TABLE Firma (
	kundenummer int primary key references Kunde(kundenummer)
	org_nummer  int not null
	unique(org_nummer)
);

CREATE TABLE Telefonnummer(
	nummer int primary key
	kundenummer int references Kunde(kundenummer)
);

CREATE TABLE Prosjekt (
	prosjektnummer int primary key
	prosjektleder int references Ansatt(ansattnr)
	prosjektnavn varchar(15)
	kundenummer int references Kunde(kundenummer)
);

CREATE TABLE Ansatt (
	ansattnr 		int primary key
	gruppenavn 		varchar(15) refences Gruppe(gruppenavn)

);

CREATE TABLE AnsattDeltakerIProsjekt (
	ansattnr 		int references Ansatt(ansattnr)
	prosjektnr 		int references Prosjekt(prosjektnummer)
	unique(ansattnr, prosjektnr)
);

CREATE TABLE Gruppe (
	gruppenavn	varchar(15) primary key
 	timelonn 	real
);

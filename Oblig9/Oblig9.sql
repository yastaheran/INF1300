/* OBLIG 9 yast */
/* Create-setningene */
CREATE TABLE Stilling(
	stillingtype varchar(15) primary key,
	stillingsprosent int not null, -- 50 = deltid og 100 = fulltid 
	lonn real not null
);

CREATE TABLE Vare(
	varenr int primary key,
	antall int
);

CREATE TABLE Hylle(
	hyllenr int primary key, 
	radnr int unique not null, 
	varenr int not null references Vare(varenr)
);

CREATE TABLE Ansatt(
	ansattnr int primary key, 
	navn varchar(40) not null, 
	adresse varchar(40) not null, 
	tlfnr char(8) not null, 
	stillingtype varchar(15) not null references Stilling(stillingtype),
	unique(navn, adresse, tlfnr)
);

CREATE TABLE Bakeri(
	bakerid int primary key, 
	adresse varchar(40) not null,
	tlfnr char(8) not null,
	dagligleder int not null references Ansatt(ansattnr),
	unique(adresse, tlfnr, dagligleder)
);

CREATE TABLE AnsattPåBakeri(
	ansattnr int not null references Ansatt(ansattnr), 
	bakerinr int not null references Bakeri(bakerid),
	primary key(ansattnr, bakerinr)
);

CREATE TABLE Oppskrift(
	oppskriftid int primary key,
	fremgangsmåte varchar(500) not null,
--	bakst varchar(15) not null references Bakst(bakstType), 
	baker int not null references Ansatt(ansattnr)
);

CREATE TABLE Bakst(
	bakstType varchar(15) primary key,
	pris float not null,
	allergen varchar(15),
	oppskrift int not null references Oppskrift(oppskriftid)
);

CREATE TABLE Betalingsmåte(
	betalingsmåteid int primary key  --hvor 1 er kontant og 2 er kort
);

CREATE TABLE Drikke(
	drikkeType varchar(15) primary key,
	pris float not null,
	varenr int not null references Vare(varenr)
);
CREATE TABLE Meny(
	menyid int primary key,
	drikke varchar(15) references Drikke(drikkeType), 
	bakst varchar(15) references Bakst(bakstType)
);

CREATE TABLE Kasse(
	kasseid int primary key,
	betalingsmåte int not null references Betalingsmåte(betalingsmåteid),
	betjening int not null references Ansatt(ansattnr),
	menyid int not null references Meny(menyid)
);

CREATE TABLE Byen(
	bykode int primary key, 
	bakerinr int references Bakeri(bakerid),
	check(bakerinr <= 10)
);

CREATE TABLE Ingredienser(
	ingrediensnavn varchar(15) primary key,
	mengde int,  -- mel, melk, sukker i dl      bakepulver, vaniljesukker i ts     egg i stk
	varenr int not null references Vare(varenr)
);

CREATE TABLE Lager(
	lagerid int primary key,
	hyllenr int references Hylle(hyllenr)
);

CREATE TABLE OppskriftIngrediens(
	oppskriftid int references Oppskrift(oppskriftid),
	ingredienser varchar(15) references Ingredienser(ingrediensnavn),
	primary key(oppskriftid,ingredienser)
);

/* Testdata (Insert) */
insert into Stilling values('Dagligleder', 100, 230);
insert into Stilling values('ServitørDel', 50, 120);
insert into Stilling values('ServitørHel', 100, 150);
insert into Stilling values('Baker', 100, 150);

insert into Vare values(1, 12);
insert into Vare values(2, 14);
insert into Vare values(3, 20);
insert into Vare values(4, 30);
insert into Vare values(5, 10);
insert into Vare values(6, 12);
insert into Vare values(7, 12);
insert into Vare values(8, 0);
insert into Vare values(9, 12);
insert into Vare values(10, 0);
insert into Vare values(11, 46);
insert into Vare values(12, 44);
insert into Vare values(13, 10);
insert into Vare values(14, 10);

insert into Ansatt values(35664,'Susanne Forøy', 'Nordbyveien 46A','43542232','Dagligleder');
insert into Ansatt values(35446, 'Thea Østby', 'Drammensveien 10', '93654416', 'Dagligleder');
insert into Ansatt values(35554, 'Kamilla Koldberg', 'Briskebyveien 4', '47294543', 'Dagligleder');
insert into Ansatt values(35555, 'Ragnhild Buller', 'Rosenlundveien 1', '45887257', 'Dagligleder');
insert into Ansatt values(35556, 'Julie Forøy', 'Sandboveien 8B', '99468353', 'Dagligleder');
insert into Ansatt values(35553, 'Hanne Buller', 'Ulfstensgate 8A', '96693701', 'Dagligleder');
insert into Ansatt values(35552, 'Camilla Hagerup', 'Magnusgate 3C', '90750034', 'Dagligleder');
insert into Ansatt values(35551, 'Solveig Kleppan', 'Professor Dahls gate 1', '41123882', 'Dagligleder');
insert into Ansatt values(35445, 'Alve Vig', 'Bjørnstjerne Bjørnsonsvei 73', '92459504', 'ServitørDel');
insert into Ansatt values(35334, 'Andrea Johanson', 'Åsveien 23', '45092841', 'ServitørHel');
insert into Ansatt values(35443, 'Mathias Raustøl', 'Drammensveien 50', '95021819', 'ServitørDel');
insert into Ansatt values(35224, 'Stig Eriksen', 'Lyngåsen 2', '93678794', 'ServitørDel');
insert into Ansatt values(35442, 'Erik Nørstebø', 'Sandertunet 125', '93568927', 'ServitørHel');
insert into Ansatt values(35114, 'Haakon Gundersen', 'Sanderveien 213', '93628927', 'ServitørDel');
insert into Ansatt values(35441, 'Atiqullah Amini', 'Inkognitogata 24', '47313895', 'ServitørDel');
insert into Ansatt values(35004, 'Aron Wahili', 'Skiveien 56', '98494694', 'ServitørHel');
insert into Ansatt values(36114, 'Johan Gunnarstorp', 'Dronningveien 23', '974 05 932', 'ServitørDel');
insert into Ansatt values(36004, 'Isak Huseby', 'Dronningens gate 37', '90240345', 'ServitørHel');
insert into Ansatt values(36001, 'Joachim Vainio', 'Sandboveien 345', '90253508', 'ServitørDel');
insert into Ansatt values(36002, 'Henrik Koldberg', 'Sandertunet 111', '41290200', 'ServitørDel');
insert into Ansatt values(36003, 'Kim Possible', 'Skoleveien 34', '40282980', 'ServitørHel');
insert into Ansatt values(36010, 'Øystein Andersen', 'Skoleveien 130', '92010145', 'ServitørDel');
insert into Ansatt values(36012, 'Tiril Susann Bratt', 'Ansgar Sørlies vei 36', '91605574', 'ServitørHel');
insert into Ansatt values(36013, 'Bjørnar Andersen', 'Linkoban 10', '45452080', 'ServitørDel');
insert into Ansatt values(36014, 'Beate Kirkerød', 'Csisarveien 32', '41160183', 'ServitørDel');
insert into Ansatt values(36015, 'Mathilde Wangen', 'Solbakken 1', '93258828', 'ServitørHel');
insert into Ansatt values(36110, 'Gwen Stefani', 'Skoleveien 123', '92404059', 'ServitørDel');
insert into Ansatt values(36112, 'Zac Efron', 'Strandveien 23', '92490309', 'ServitørHel');
insert into Ansatt values(35774, 'Johnny Depp', 'Audestad gata 213', '45053142', 'Baker');
insert into Ansatt values(35447, 'Selena Gomez', 'Skonnord gata 90', '92253165', 'Baker');
insert into Ansatt values(35884, 'Yolo McSwag', 'Bogstadveien 45', '99479755', 'Baker');
insert into Ansatt values(35448, 'Carmada Dillo', 'Niel Jules gate 32', '64874789', 'Baker');
insert into Ansatt values(35994, 'Amanda Blank', 'Vikerlia 76', '41362555', 'Baker');
insert into Ansatt values(35449, 'Amanda Christiansen', 'Grønlundveien 11', '94489294', 'Baker');
insert into Ansatt values(34000, 'Demi Lovato', 'Skrikerudgate 64', '92655772', 'Baker');
insert into Ansatt values(34002, 'Justin Timberlake', 'Sebergveien 56', '48262620', 'Baker');
insert into Ansatt values(34001, 'Aksel Knudsens', 'Ida Færgisvei 67', '95944145', 'Baker');
insert into Ansatt values(34003, 'Amalie Borgan', 'Smidasang gate 45', '91772986', 'Baker');
insert into Ansatt values(34005, 'Andreas Boer', 'Solbråtan gate 34', '41191195', 'Baker');
insert into Ansatt values(34004, 'Andreas Simonsen', 'Smestadlia 67', '92626363', 'Baker');
insert into Ansatt values(34006, 'Anne Strande', 'Nymoenveien 34', '47450525', 'Baker');
insert into Ansatt values(34007, 'Elsa Audestad', 'Nymoenveien 34', '94296724', 'Baker');
insert into Ansatt values(34008, 'Erik Dehle', 'Westerdales 90', '45638585', 'Baker');
insert into Ansatt values(34009, 'Eva Mey', 'Storgata 74', '97779270', 'Baker');

insert into Bakeri values(10, 'Bakeriveien 23', '64874594', 35446);
insert into Bakeri values(9, 'Bakerigata 32', '64955275',35664);
insert into Bakeri values(4, 'Idrettsveien 45', '22164343', 35554);
insert into Bakeri values(5, 'Bakerigata 5', '22554763', 35555);
insert into Bakeri values(3, 'Solbakken 34', '55582408', 35553);
insert into Bakeri values(2, 'Strandveien 12', '64861126', 35552);
insert into Bakeri values(1, 'Csisarveien 123', '32827729', 35551);
insert into Bakeri values(6, 'Kirkealleen 67', '23270027', 35556);

insert into AnsattPåBakeri values(35664, 9);
insert into AnsattPåBakeri values(35445, 9);
insert into AnsattPåBakeri values(35774, 9);
insert into AnsattPåBakeri values(35447, 9);
insert into AnsattPåBakeri values(35446, 10);
insert into AnsattPåBakeri values(35443, 10);
insert into AnsattPåBakeri values(35224, 10);
insert into AnsattPåBakeri values(35442, 10);
insert into AnsattPåBakeri values(35884, 10);
insert into AnsattPåBakeri values(35448, 10);
insert into AnsattPåBakeri values(35551, 1);
insert into AnsattPåBakeri values(35114, 1);
insert into AnsattPåBakeri values(35441, 1);
insert into AnsattPåBakeri values(35004, 1);
insert into AnsattPåBakeri values(35994, 1);
insert into AnsattPåBakeri values(35449, 1);
insert into AnsattPåBakeri values(35552, 2);
insert into AnsattPåBakeri values(36114, 2);
insert into AnsattPåBakeri values(36004, 2);
insert into AnsattPåBakeri values(34000, 2);
insert into AnsattPåBakeri values(34002, 2);
insert into AnsattPåBakeri values(35553, 3);
insert into AnsattPåBakeri values(36001, 3);
insert into AnsattPåBakeri values(36002, 3);
insert into AnsattPåBakeri values(36003, 3);
insert into AnsattPåBakeri values(34001, 3);
insert into AnsattPåBakeri values(34003, 3);
insert into AnsattPåBakeri values(35554, 4);
insert into AnsattPåBakeri values(36010, 4);
insert into AnsattPåBakeri values(36012, 4);
insert into AnsattPåBakeri values(34005, 4);
insert into AnsattPåBakeri values(34004, 4);
insert into AnsattPåBakeri values(35555, 5);
insert into AnsattPåBakeri values(36013, 5);
insert into AnsattPåBakeri values(36014, 5);
insert into AnsattPåBakeri values(36015, 5);
insert into AnsattPåBakeri values(34006, 5);
insert into AnsattPåBakeri values(34007, 5);
insert into AnsattPåBakeri values(35556, 6);
insert into AnsattPåBakeri values(36110, 6);
insert into AnsattPåBakeri values(36112, 6);
insert into AnsattPåBakeri values(34008, 6);
insert into AnsattPåBakeri values(34009, 6);

insert into Bakst values('Bolle', 10, 'gluten, egg', 2);
insert into Bakst values('Skolebolle', 15, 'gluten, melk, egg', 1);
insert into Bakst values('Croissant', 20, 'gluten', 3);
insert into Bakst values('Muffins', 20, 'gluten, melk, egg', 4);
insert into Bakst values('Glutenfri muffins', 25, 'melk, egg', 5);

insert into Betalingsmåte values(1);
insert into Betalingsmåte values(2);
insert into Betalingsmåte values(1);
insert into Betalingsmåte values(2);
insert into Betalingsmåte values(2);
insert into Betalingsmåte values(2);
insert into Betalingsmåte values(1);
insert into Betalingsmåte values(2);
insert into Betalingsmåte values(1);
insert into Betalingsmåte values(1);
insert into Betalingsmåte values(2);

insert into Byen values(3001, 4);
insert into Byen values(3001, 5);
insert into Byen values(3001, 6);
insert into Byen values(3001, 3);
insert into Byen values(3001, 2);
insert into Byen values(3001, 1);
insert into Byen values(3701, 10);
insert into Byen values(1406, 9);

insert into Drikke values('Cola', 20, 1);
insert into Drikke values('Fanta', 20, 2);
insert into Drikke values('Imsdal', 12, 3);
insert into Drikke values('Kakao', 20, 4);
insert into Drikke values('Iste', 20, 5);
insert into Drikke values('Iskaffe', 20, 6);
insert into Drikke values('Kaffe', 12, 7);
insert into Drikke values('Te', 12, 8);

insert into Hylle values(1, 1, 1);
insert into Hylle values(2, 1, 2);
insert into Hylle values(3, 1, 3);
insert into Hylle values(1, 2, 4);
insert into Hylle values(2, 2, 5);
insert into Hylle values(3, 2, 6);
insert into Hylle values(1, 3, 7);
insert into Hylle values(2, 3, 8);
insert into Hylle values(3, 3, 9);
insert into Hylle values(1, 4, 10);
insert into Hylle values(2, 4, 11);
insert into Hylle values(3, 4, 12);
insert into Hylle values(1, 5, 13);
insert into Hylle values(2, 5, 14);

insert into Lager values(1, 1);
insert into Lager values(1, 2);
insert into Lager values(1, 3);

insert into Meny values(1234, 'Iste', 'Skolebolle',);
insert into Meny values(2341, 'Kakao', 'Croissant');
insert into Meny values(3412, 'Kaffe', 'Bolle');
insert into Meny values(4123, 'Imsdal', 'Muffins');
insert into Meny values(5678, 'Te', 'Glutenfri Muffins');
insert into Meny values(6785, 'Iskaffe', 'Skolebolle');
insert into Meny values(7856, 'Fanta');
insert into Meny values(8567, 'Cola');

insert into Ingredienser values('melk', 3, 10);
insert into Ingredienser values('sukker', 3, 11);
insert into Ingredienser values('mel', 5, 9);
insert into Ingredienser values('bakepulver', 2, 12);
insert into Ingredienser values('vaniljesukker', 1, 13);
insert into Ingredienser values('egg', 2, 14);

insert into Kasse values(11, 1, 36001, 1234);
insert into Kasse values(12, 2, 35443, 1234);
insert into Kasse values(13, 1, 35224, 2341);
insert into Kasse values(14, 2, 35442, 2341);
insert into Kasse values(15, 2, 35445, 3412);
insert into Kasse values(16, 2, 35114, 3412);
insert into Kasse values(17, 1, 35441, 4123);
insert into Kasse values(18, 2, 36114, 6785);
insert into Kasse values(19, 1, 36004, 5678);
insert into Kasse values(20, 1, 36110, 7856);
insert into Kasse values(21, 2, 36112, 8567);

insert into Oppskrift values(1, 'Bland, hev, stek, server', 35774);
insert into Oppskrift values(2, 'Bland, hev, stek, server',35447);
insert into Oppskrift values(3, 'Bland, hev, stek, server', 35774);
insert into Oppskrift values(4, 'Bland, stek, server', 35774);
insert into Oppskrift values(5, 'Bland, stek, server', 35447);

insert into OppskriftIngrediens values (1, 'egg');
insert into OppskriftIngrediens values (1, 'mel');
insert into OppskriftIngrediens values (1, 'melk');
insert into OppskriftIngrediens values (1, 'sukker');
insert into OppskriftIngrediens values (1, 'bakepulver');
insert into OppskriftIngrediens values (1, 'vaniljesukker');
insert into OppskriftIngrediens values (2, 'egg');
insert into OppskriftIngrediens values (2, 'mel');
insert into OppskriftIngrediens values (2, 'melk');
insert into OppskriftIngrediens values (2, 'sukker');
insert into OppskriftIngrediens values (2, 'bakepulver');
insert into OppskriftIngrediens values (2, 'vaniljesukker');
insert into OppskriftIngrediens values (3, 'mel');
insert into OppskriftIngrediens values (3, 'melk');
insert into OppskriftIngrediens values (3, 'sukker');
insert into OppskriftIngrediens values (3, 'bakepulver');
insert into OppskriftIngrediens values (3, 'vaniljesukker');
insert into OppskriftIngrediens values (4, 'egg');
insert into OppskriftIngrediens values (4, 'mel');
insert into OppskriftIngrediens values (4, 'melk');
insert into OppskriftIngrediens values (4, 'sukker');
insert into OppskriftIngrediens values (4, 'bakepulver');
insert into OppskriftIngrediens values (4, 'vaniljesukker');
insert into OppskriftIngrediens values (5, 'egg');
insert into OppskriftIngrediens values (5, 'mel');
insert into OppskriftIngrediens values (5, 'melk');
insert into OppskriftIngrediens values (5, 'sukker');
insert into OppskriftIngrediens values (5, 'bakepulver');
insert into OppskriftIngrediens values (5, 'vaniljesukker');

/* Testdata (Update) */
update Ansatt set ansattnr = 24351 where ansattnr = 35446;
update Vare set antall = 50 where antall = 0;
update Stilling set stillingprosent = 30 where stillingprosent = 50;

/* Select-setningene */
/* 1. Hvem er dagligleder i bakeriet med bakerinummer 10? */
select dagligleder
from Bakeri
where bakerid = 10;

/* 2. Hvor mange ansatte ved bakeriet med bakerinummer 9 har tilgang til oppskriftene? */
select count(a.ansattnr) as antall
from Ansatt a, Stilling s, Bakeri b, AnsattPåBakeri ab
where ab.ansattnr = a.ansattnr AND a.stillingtype = s.stillingtype and s.stillingtype = 'Baker'
having b.bakerid = 9;

/* 3. Hvilke drikkevare/bakst er mest populær i bakeriet som er plassert i Skien? */
select count(drikkevareType) as antallDrikke, drikkeType, count(bakstType) as antallBakst, bakstType
from Drikke d, Bakst b, Bakeri bakeri, Byen byen
where bakeri.bakerid = byen.bakerid
having by byen.kode = 3701
group by drikkevareType, bakstType;

/* 4. Hvilke allergener finnes det i menyen med ID 1234? */
select allergener
from Meny m, Bakst b
where b.bakstType = m.bakst
order by allergener;

/* 5. På hylle 23, rad 3 er det plassert varer med hvilket varenummer? */
select hyllenr as hylle, radnr as rad, varenr
from Hylle h, Vare v
where radnr = 3 and hyllenr = 23;

/* 6. Hvor mange bakerier finnes det i Drammen? */
select count(bakerid) as antallBakerier, bykode
from Bakeri b, Byen byen
where b.bakerid = byen.bakerid and byen.bykode = 3001;

/* 7. Hvilken betalingsmåte er brukt mer enn 5 ganger? */ -- endret på spørsmål 7 slik at jeg fikk hatt med having
select count(betalingsmåteid) as antall, betalingsmåteid
from Betalingsmåte
having count(betalingsmåteid) > 5;

/* 8. Hvor mye tjente bakeri nr. 4? */
select sum(b.pris) as tjentBakst, sum(d.pris) as tjentDrikke, bakerinr
from Bakst b, Drikke d, Meny m, Kasse k, Bakeri bakeri
where k.menyid = m.menyid and bakeri.bakerinr = 4 and m.bakst = b.bakstType and m.drikke = d.drikkeType;

/* 9. Hvor mange deltidsansatte er det i bakeri nr. 4? */
select count(ansattnr) as antallAnsatte, stillingtype
from Ansatt a, Stilling s, AnsattPåBakeri ab
where a.ansattnr = ab.ansattnr and s.stillingtype = a.stillingtype and s.stillingtype = 'ServitørDel' and s.stillingprosent = 50
having bakerinr = 4;

/* 10. Hvor jobber ansatt med ansattnummer 35664? */
select ansattnr, bakerinr
from AnsattPåBakeri
where ansattnr = 35664;

/* Skriv selectsetninger som skriver ut en tabell med: */
/* 1. fullstendig tittel og produksjonsår for alle filmer i kampsport- og 
spenningsfilmserien Rush Hour */
select title, prodyear
from film F, filmgenre FG
where title LIKE 'Rush Hour%' AND F.filmid = FG.filmid AND FG.genre = 'Action';

/* 2. tittel, produksjonsår og filmtype for alle kinofilmer som ble produsert i året 
1893 */
select title, prodyear, filmtype
from film F, filmitem I
where F.filmid = I.filmid AND F.prodyear = 1893;

/* 3. navn på alle skuespillere i filmen Baile Perfumado */
select p.firstname || ' ' || p.lastname AS name
from person p, film f, filmparticipation fp 
where f.title = 'Baile Perfumado' AND fp.personid = p.personid AND fp.filmid = f.filmid AND fp.parttype = 'cast';

/* 4. tittel og produksjonsår for alle filmene som Ingmar Bergman har vært regissør for. 
Sorter tuplene kronologisk etter produksjonsår*/
select title, prodyear
from film f, person p, filmparticipation fp
where f.filmid = fp.filmid AND fp.parttype = 'director' AND fp.personid = p.personid AND p.firstname = 'Ingmar' AND p.lastname = 'Bergman'
order by prodyear desc;

/* 5. produksjonsår for første og siste film Ingmar Bergman regisserte */
select min(prodyear) AS forste, max(prodyear) AS siste
from person p, film f, filmparticipation fp
where f.filmid = fp.filmid AND fp.personid = p.personid AND fp.parttype = 'director' AND p.firstname = 'Ingmar' AND p.lastname = 'Bergman'

/* 6. år og antall tv-serier som ble produsert første gang i 2008 og 2009. En linje 
for hvert år */
select firstprodyear, count(*)
from series
where firstprodyear = 2008 OR firstprodyear = 2009
group by firstprodyear;

/* 7. tittel og produksjonsår for de filmene hvor mer enn 300 personer har deltatt, 
uansett hvilken funksjon de har hatt */
select title, prodyear
from film f, filmparticipation fp
where f.filmid = fp.filmid
group by f.title, f.prodyear
having count distinct fp.personid > 300;

/* 8. oversikt over regissører som har regissert kinofilmer over et stort tidsspenn. I 
tillegg til navn, ta med antall kinofilmer og første og siste år personen hadde regi. 
Skriv ut alle som har et tidsintervall på mer enn 49 år mellom første og siste film og 
sorter dem etter lengden på dette tidsintervallet, de lengste først. */
select p.firstname || ' ' || p.lastname AS name, count(filmid) AS antallfilmer, max(prodyear) as siste, min(prodyear) as forste
from film f, peron p, filmparticipation fp
where fp.personid = p.personid  AND f.filmid = fp.filmid AND AND fp.parttype = 'director'
group by name, p.personid
having max(f.prodyear) - min(f.prodyear) > 49
order by max(f.prodyear) - min(f.prodyear) desc;

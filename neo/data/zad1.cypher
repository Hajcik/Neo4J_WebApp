-- GAMES
CREATE(g:Game{title:'League of Legends',                genre:'MOBA',   price:0,    director:'Steve Feak',          developer:'Riot Games',             publisher:'Riot Games'});
CREATE(g:Game{title:'Valorant',                         genre:'FPS',    price:0,    director:'David Nottingham',    developer:'Riot Games',             publisher:'Riot Games'});
CREATE(g:Game{title:'Counter-Strike: Condition-Zero',   genre:'FPS',    price:15,   director:'Valve Corporation',   developer:'Turtle Rock Studios',    publisher:'Valve Corporation'});
CREATE(g:Game{title:'Counter-Strike: Global Offensive', genre:'FPS',    price:0,    director:'Valve Corporation',   developer:'Valve Corporation',      publisher:'Valve Corporation'});
CREATE(g:Game{title:'Half-Life',                        genre:'FPS',    price:10,   director:'Marc Laidlaw',        developer:'Valve Corporation',      publisher:'Sierra Entertainment'});
CREATE(g:Game{title:'Half-Life 2',                      genre:'FPS',    price:15,   director:'Marc Laidlaw',        developer:'Valve Corporation',      publisher:'Sierra Entertainment'});
CREATE(g:Game{title:'Defence of the Ancients',          genre:'MOBA',   price:0,    director:'Steve Feak',          developer:'IceFrog'});
CREATE(g:Game{title:'DotA 2',                           genre:'MOBA',   price:0,    director:'Steve Feak',          developer:'Valve Corporation',      publisher:'Valve Corporation'});
CREATE(g:Game{title:'Left 4 Dead',                      genre:'FPS',    price:13,   director:'Chet Faliszek',       developer:'Turtle Rock Studios',    publisher:'Valve Corporation'});
CREATE(g:Game{title:'Evolve', price:15,                 genre:'FPS',    price:15,   director:'Phil Robb',           developer:'Turtle Rock Studios',    publisher:'2K Studios'});
CREATE(g:Game{title:'Life is Strange',                  genre:'Story',  price:29.99,director:'Raoul Barbet',        developer:'Dontnod Entertainment',  publisher:'Square Enix'});

-- DIRECTORS
CREATE(d:Director{name:'David Nottingham'});
CREATE(d:Director{name:'Steve Feak'});
CREATE(d:Director{name:'Garry Newman'});
CREATE(d:Director{name:'Raoul Barbet'});
CREATE(d:Director{name:'Minh Le'});
CREATE(d:Director{name:'Chet Faliszek'});
CREATE(d:Director{name:'Marc Laidlaw'});
CREATE(d:Director{name:'Valve Corporation'});

-- MODS
CREATE(d:Mod{title:'Counter-Strike', moddedGame:'Half-Life', director:'Minh Le', publisher:'Valve Corporation'});
CREATE(d:Mod{title:'Garrys Mod', moddedGame:'Half-Life 2', director:'Garry Newman', publisher: 'Valve Corporation'});

-- DEVS
CREATE(d:Developer{name:'Riot Games', country:'USA', established:2006});
CREATE(d:Developer{name:'Valve Corporation', country:'USA', established:1996});
CREATE(d:Developer{name:'Turtle Rock Studios', country:'USA', established:2002});
CREATE(d:Developer{name:'Dontnod Entertainment', country:'France', established:2008});
CREATE(d:Developer{name:'IceFrog', country:'Mexico', established:2001});

-- PUBLISHERS
CREATE(p:Publisher{name:'Valve Corporation'});
CREATE(p:Publisher{name:'Riot Games'});
CREATE(p:Publisher{name:'Sierra Entertainment'});
CREATE(p:Publisher{name:'2K Studios'});
CREATE(p:Publisher{name:'Square Enix'});


# Relations
---------------------------------------------------------------
# Relation Game/Director, DIRECTED_BY

MATCH(g:Game), (d:Director)
WHERE g.director = 'David Nottingham' AND d.name = 'David Nottingham'
    CREATE (g)-[dir:DIRECTED_BY]-> (d);

MATCH(g:Game), (d:Director)
WHERE g.director = 'Raoul Barbet' AND d.name = 'Raoul Barbet'
    CREATE (g)-[dir:DIRECTED_BY]-> (d);

MATCH(g:Game), (d:Director)
WHERE g.director = 'Steve Feak' AND d.name = 'Steve Feak'
    CREATE (g)-[dir:DIRECTED_BY]-> (d);

MATCH(g:Game), (d:Director)
WHERE g.director = 'Chet Faliszek' AND d.name = 'Chet Faliszek'
    CREATE (g)-[dir:DIRECTED_BY]-> (d);

MATCH(g:Game), (d:Director)
WHERE g.director = 'Marc Laidlaw' AND d.name = 'Marc Laidlaw'
    CREATE (g)-[dir:DIRECTED_BY]-> (d);

MATCH(g:Game), (d:Director)
WHERE g.director = 'Valve Corporation' AND d.name = 'Valve Corporation'
    CREATE (g)-[dir:DIRECTED_BY]-> (d);

---------------------------------------------------------------
# Relation Mod/Director, DIRECTED_BY

MATCH(g:Mod), (d:Director)
WHERE g.director = 'Garry Newman' AND d.name = 'Garry Newman'
    CREATE (g)-[dir:DIRECTED_BY]-> (d);

Match(g:Mod), (d:Director)
WHERE g.director = 'Minh Le' AND d.name='Minh Le'
    CREATE (g)-[dir:DIRECTED_BY]->(d);
---------------------------------------------------------------
-- Relation Game/Mod, MODIFICATION_OF_GAME
MATCH(g:Game), (m:Mod)
WHERE g.title = 'Half-Life' AND m.moddedGame = 'Half-Life'
CREATE (m)-[modded:MODIFICATION_OF_GAME]-> (g);

MATCH(g:Game), (m:Mod)
WHERE g.title = 'Half-Life 2' AND m.moddedGame = 'Half-Life 2'
	CREATE (m)-[modded:MODIFICATION_OF_GAME]-> (g);
---------------------------------------------------------------
-- Relation Game/Developer, DEVELOPED_BY

MATCH(g:Game), (d:Developer)
WHERE g.developer = 'Valve Corporation' AND d.name = 'Valve Corporation'
	CREATE (g)-[dev:DEVELOPED_BY]->(d);

MATCH(g:Game), (d:Developer)
WHERE g.developer = 'Turtle Rock Studios' AND d.name = 'Turtle Rock Studios'
	CREATE (g)-[dev:DEVELOPED_BY]->(d);

MATCH(g:Game), (d:Developer)
WHERE g.developer = 'Riot Games' AND d.name = 'Riot Games'
	CREATE (g)-[dev:DEVELOPED_BY]->(d);

MATCH(g:Game), (d:Developer)
WHERE g.developer = 'Dontnod Entertainment' AND d.name = 'Dontnod Entertainment'
	CREATE (g)-[dev:DEVELOPED_BY]->(d);

MATCH(g:Game), (d:Developer)
WHERE g.developer = 'IceFrog' AND d.name = 'IceFrog'
	CREATE (g)-[dev:DEVELOPED_BY]->(d);
---------------------------------------------------------------

-- Relation Game/Developer, PUBLISHED_BY

MATCH(g:Game), (p:Publisher)
WHERE g.publisher = 'Valve Corporation' AND p.name = 'Valve Corporation'
    CREATE (g)-[pub:PUBLISHED_BY]-> (p);

MATCH(g:Game), (p:Publisher)
WHERE g.publisher = 'Sierra Entertainment' AND p.name = 'Sierra Entertainment'
    CREATE (g)-[pub:PUBLISHED_BY]-> (p);

MATCH(g:Game), (p:Publisher)
WHERE g.publisher = 'Riot Games' AND p.name = 'Riot Games'
    CREATE (g)-[pub:PUBLISHED_BY]-> (p);

MATCH(g:Game), (p:Publisher)
WHERE g.publisher = '2K Studios' AND p.name = '2K Studios'
    CREATE (g)-[pub:PUBLISHED_BY]-> (p);

MATCH(g:Game), (p:Publisher)
WHERE g.publisher = 'Square Enix' AND p.name = 'Square Enix'
    CREATE (g)-[pub:PUBLISHED_BY]-> (p);

---------------------------------------------
-- ZAPYTANIA ZADANIE 3

-- Alfabetycznie gry, plus mody na sam koniec
MATCH (n:Game) RETURN (n.title) ORDER BY (n.title) UNION MATCH (n:Mod) RETURN (n.title)

-- Gry które nie są za darmo oraz są zrobione przez Valve Corporation
MATCH (n:Game) WHERE (n.price > 0 AND n.developer = 'Valve Corporation') RETURN (n)

-- Deweloperzy którzy założyli przedsiębiorstwo po 2000 roku oraz nie są ze Stanów Zjednoczonych
MATCH (n:Developer) WHERE (n.established > 2000 AND n.country <> 'USA') RETURN (n)

-- Wypisanie losowych 3 gier
MATCH (n:Game) RETURN (n.title), rand() as r ORDER BY r LIMIT 3

-- Wypisanie trzech środkowych więzłów dot. deweloperów
MATCH (n:Developer) RETURN (n.name) SKIP 0 LIMIT 3

-- Wypisanie wydawców których nazwa zaczyna się na S
MATCH (p:Publisher) WHERE (p.name STARTS WITH 'S') RETURN (p)

-- ZAPYTANIA ZADANIE 4

-- Usuwanie zduplikowanych relacji z całego grafu
MATCH ()-[r]->()
MATCH (s)-[r]->(e)
WITH s,e,TYPE(r) AS typ, TAIL(collect(r)) as coll
FOREACH(x IN coll | DELETE x)

-- Zmiana nazw gier zaczynających się na 'Counter-Strike...' na 'KANTER STRAJK'
MATCH (n:Game) WHERE (n.title STARTS WITH 'Counter-Strike')
SET n.title = 'KANTER-STRAJK' RETURN (n)

-- Aktualizacja cen darmowych gier na losowe ceny w zakresie od 0 do 30 USD
MATCH (g:Game) SET (CASE WHEN g.price = 0 THEN g END).price = toInteger(rand()*31)
RETURN (g.title), (g.price)

-- Aktualizacja cen, jeśli gra ma cenę > 15USD, zrób ją za darmo
MATCH (g:Game) SET (CASE WHEN g.price > 15 THEN g END).price = 0
RETURN (g.title), (g.price)

-- Usuwanie wszystkich więzłów oraz relacji
MATCH (n) DETACH DELETE (n)

-- Dodanie wydawcy 'DOTO LOTO' do Defence of the Ancients
MATCH (g:Game) SET (CASE WHEN g.title = 'Defence of the Ancients' THEN g END).publisher = 'DOTO LOTO' RETURN (g)

-- ZAPYTANIA ZADANIE 5
-- Srednia cena wszystkich gier
MATCH (g:Game) RETURN avg(g.price) as avg_cena_gier

-- Maksymalna cena gry w katalogu
MATCH (g:Game) RETURN max(g.price) as max

-- Kolekcja gier na D lub C
MATCH (n:Game) WHERE (n.title STARTS WITH 'D' OR n.title STARTS WITH 'C') RETURN collect(n.title) as kolekcja_gier_na_d_lub_c

-- Odchylenie standardowe roku założenia firmy deweloperskiej
MATCH (n:Developer) WHERE n.established IN [1996, 2001, 2002, 2006, 2008]
RETURN stDev(n.established)

-- Suma cen wszystkich gier
MATCH(n:Game) RETURN sum(n.price)

-- Rok zalozenia najstarszej firmy deweloperskiej
MATCH (n:Developer) RETURN min(n.established)

-- ZAPYTANIA ZADANIE 6
-- Wypisanie losowych 3 gier ( RAND )
MATCH (n:Game) RETURN (n.title), rand() as r ORDER BY r LIMIT 3

-- Wypisanie properties więzła typu Deweloper ( PROPERTIES )
MATCH(n:Developer) RETURN properties(n) LIMIT 1

-- Alfabetycznie gry, nazwy od tyłu ( REVERSE )
MATCH (n:Game) RETURN (n.title) ORDER BY (n.title) UNION MATCH (n:Mod) RETURN reverse(n.title)









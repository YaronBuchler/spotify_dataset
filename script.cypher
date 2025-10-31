// ============================
// CRIAÇÃO DE DADOS DE TESTE
// ============================

// Usuários
CREATE (:User {fullName: "Charles Hughes"});
CREATE (:User {fullName: "Alice Johnson"});
CREATE (:User {fullName: "Bob Smith"});
CREATE (:User {fullName: "Eve Carter"});

// Músicas
CREATE (:Music {name: "Song A"});
CREATE (:Music {name: "Song B"});
CREATE (:Music {name: "Song C"});
CREATE (:Music {name: "Song D"});
CREATE (:Music {name: "Song E"});

// Gêneros
CREATE (:Genre {name: "Pop"});
CREATE (:Genre {name: "Rock"});
CREATE (:Genre {name: "Jazz"});

// Relacionamento música → gênero
MATCH (m:Music {name: "Song A"}), (g:Genre {name: "Pop"})
MERGE (m)-[:OF_GENRE]->(g);

MATCH (m:Music {name: "Song B"}), (g:Genre {name: "Rock"})
MERGE (m)-[:OF_GENRE]->(g);

MATCH (m:Music {name: "Song C"}), (g:Genre {name: "Jazz"})
MERGE (m)-[:OF_GENRE]->(g);

MATCH (m:Music {name: "Song D"}), (g:Genre {name: "Pop"})
MERGE (m)-[:OF_GENRE]->(g);

MATCH (m:Music {name: "Song E"}), (g:Genre {name: "Rock"})
MERGE (m)-[:OF_GENRE]->(g);

// Charles Hughes curtiu algumas músicas
MATCH (u:User {fullName: "Charles Hughes"}), (m:Music)
WITH u, m LIMIT 2
MERGE (u)-[:LIKED]->(m);

// Criar seguidores para Charles Hughes
MATCH (u:User {fullName: "Charles Hughes"}), (f:User)
WHERE f.fullName <> "Charles Hughes"
WITH u, f LIMIT 2
MERGE (f)-[:FOLLOWED]->(u);

// Fazer os seguidores ouvirem músicas
MATCH (f:User)-[:FOLLOWED]->(u:User {fullName: "Charles Hughes"}), (m:Music)
WITH f, m LIMIT 3
MERGE (f)-[:LISTENED_TO]->(m);

// ============================
// EXEMPLOS DE RECOMENDAÇÃO
// ============================

// 1. Por gênero
MATCH (u:User {fullName: "Charles Hughes"})-[:LIKED]->(:Music)-[:OF_GENRE]->(g:Genre)
MATCH (g)<-[:OF_GENRE]-(rec:Music)
WHERE NOT (u)-[:LIKED]->(rec)
RETURN DISTINCT rec.name AS recomendacao, g.name AS genero
LIMIT 10;

// 2. Social (seguidores ouviram)
MATCH (u:User {fullName: "Charles Hughes"})<-[:FOLLOWED]-(follower:User)-[:LISTENED_TO]->(rec:Music)
WHERE NOT (u)-[:LIKED]->(rec)
RETURN DISTINCT rec.name AS recomendacao
LIMIT 10;

// 3. Popularidade (mais curtidas)
MATCH (m:Music)<-[:LIKED]-(u:User)
RETURN m.name AS musica, COUNT(u) AS likes
ORDER BY likes DESC
LIMIT 10;

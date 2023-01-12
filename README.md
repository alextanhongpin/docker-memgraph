# docker-memgraph

Basic friends relationship
```
alice
bob
charles

alice -> charles
bob -> charles
```

```memgraph
-- NOTE: Multiple lines is not accepted when pasting to console.

-- Ensure name is unique.
CREATE CONSTRAINT ON (u:User) ASSERT u.name IS UNIQUE;

-- Ensure name is not null.
CREATE CONSTRAINT ON (u:User) ASSERT EXISTS (u.name);

CREATE (alice: User{name: 'alice'}), (bob: User{name: 'bob'}), (charles: User{name: 'charles'});

MATCH (n) RETURN n;

-- Return all bidirectional relationship.
MATCH (n)-[r]-(m) RETURN n, r, m;

-- Return all unidirectional relationship.
MATCH (n)-[r]->(m) RETURN n, r, m;

-- Clear nodes (only if they don't have relationships).
MATCH (n) DELETE n;

-- Clear relationships and nodes.
MATCH (n) DETACH DELETE n;

-- WARN: This will create duplicates.
-- CREATE (bob: User{name: 'bob'})-[:KNOWS]->(charles: User{name: 'charles'});

-- Doesn't work
-- MATCH (alice: User{name: 'alice'}), (charles: User{name: 'charles'}),
	-- CREATE (alice)-[k:KNOWS]->(charles) RETURN k;
MATCH (alice), (charles) WHERE alice.name = 'alice' and charles.name = 'charles' MERGE (alice)-[k:KNOWS]->(charles) RETURN k;


MATCH (bob) where bob.name = 'bob' RETURN bob;
MATCH (bob: User{name: 'bob'}) RETURN bob;
MATCH (bob: User{name: 'bob'}), (charles: User{name: 'charles'}) RETURN bob, charles;
-- NOTE: Running this twice with CREATE will create duplicate relationships. Use MERGE instead.
MATCH (bob: User{name: 'bob'}), (charles: User{name: 'charles'}) MERGE (bob)-[k:KNOWS]->(charles) RETURN k;

-- Unidirectional.
MATCH (u: User)-[:KNOWS]->(o: User) RETURN u, o;

-- Bidirectional.
MATCH (u: User)-[:KNOWS]-(o: User) RETURN u, o;


-- All of this behaves similarly.
MATCH (me: User{name: 'alice'})-[]-()<-[]-(fof:User) RETURN fof;
MATCH (me: User{name: 'alice'})-[]-()-[]-(fof:User) RETURN fof;
MATCH (me: User{name: 'alice'})-[]-()-[]->(fof:User) RETURN fof; -- no result, cause of relationship
MATCH (me: User{name: 'alice'})--()--(fof:User) RETURN fof;
MATCH (me: User{name: 'alice'})--()--(fof:User) RETURN fof;
MATCH (me: User{name: 'alice'})-[:KNOWS]-(:User)-[:KNOWS]-(fof:User) RETURN fof;
MATCH (me: User{name: 'alice'})-[:KNOWS]-(:User)-[:KNOWS]-(fof:User) WHERE me <> fof RETURN DISTINCT fof;
MATCH (me: User{name: 'alice'})-[:KNOWS]->(o: User) MATCH (o)-[:KNOWS]-(fof:User) WHERE me <> fof RETURN fof;
MATCH (me: User{name: 'alice'})-[:KNOWS]->(o: User) MATCH (User {name: o.name})-[:KNOWS]-(fof:User) WHERE me <> fof RETURN fof;
```


# References
- [Manual](https://memgraph.com/docs/cypher-manual/)
- [Product recommendation](https://rubygarage.org/blog/neo4j-database-guide-with-use-cases)
- [Cheat Sheet](https://memgraph.com/blog/cypher-cheat-sheet)
- [Movie Recommendation](https://47billion.com/blog/recommendation-system-using-graph-database/)

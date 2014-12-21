library(RNeo4j)

graph = startGraph("http://localhost:7474/db/data/")

graph$version
# [1] "2.0.3"

mugshots = createNode(graph, "Bar", name = "Mugshots", location = "Downtown")
parlor = createNode(graph, "Bar", name = "The Parlor", location = "Hyde Park")
createNode(graph, "Bar", name = "Cheer Up Charlie's", location = "Downtown")

nicole = createNode(graph, name = "Nicole", status = "Student")
addLabel(nicole, "Person")

addConstraint(graph, "Person", "name")
addConstraint(graph, "Bar", "name")

charlies = getUniqueNode(graph, "Bar", name="Cheer Up Charlie's")

createRel(nicole, "DRINKS_AT", mugshots, on = "Fridays")
rel = createRel(nicole, "DRINKS_AT", parlor, on="Saturdays")

rel$on

start = startNode(rel)
end = endNode(rel)

start$name
end$name

query = "MATCH (p:Person {name:'Nicole'})-[d:DRINKS_AT]->(b:Bar)
          RETURN p.name, d.on, b.name, b.location"

cypher(graph, query)

bars = getLabeledNodes(graph, "Bar")
bars_names = lapply(bars, function(b) b$name)
unique(unlist(bars_names))
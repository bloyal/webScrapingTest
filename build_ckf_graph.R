library(RNeo4j);

graph = startGraph("http://localhost:7474/db/data/");

graph$version;
# [1] "2.1.6"

#bulkCreateNodes(graph, "MenuItem","name",menu$name)

#bulkUpdateNodeProperties(graph, rep("MenuItem",323), 
#                         rep("name",323), menu$name, 
#                         rep("description",323), menu$description)

bulkCreateNodes<-function(graph, labelName, indexName, indexValues){
  query <- paste("CREATE (n:",labelName," {",indexName,":{indexValue}})", sep="");
  t <- newTransaction(graph);
  
  for (i in 1:length(indexValues)){
   value <- indexValues[i];
   appendCypher(t, query, indexValue = value);
  }
  
  commit(t);
  
  addIndex(graph, labelName, indexName);
}

bulkUpdateNodeProperties<-function(graph, labelNames, indexNames, indexValues, 
                                   propertyNames, propertyValues){
  nodeInfo <- cbind(labelName=labelNames, indexName=indexNames, 
                    indexValue=as.character(indexValues), 
                    propertyName=propertyNames, 
                    propertyValue=propertyValues);
  t <- newTransaction(graph);
  
  for (i in 1:nrow(nodeInfo)){
    query <- paste("MERGE (n:", nodeInfo[i,"labelName"]," {", nodeInfo[i,"indexName"], ":'", nodeInfo[i,"indexValue"], "'}) ",
                   "SET n.",nodeInfo[i,"propertyName"],"='",nodeInfo[i,"propertyValue"], "'", sep="");
    appendCypher(t, query);
  }

  commit(t);
}

bulkCreateRelationships(graph, 
                        rep("MenuItem",5), rep("name",5), menu$name[1:5],
                        rep("Feature",5), rep("name",5), unique(unlist(features))[1:5],
                        rep("HAS_FEATURE",5)
                        )

bulkCreateRelationships<-function(graph, 
                                  startLabel, startIndexName, startIndexValue, 
                                  endLabel, endIndexName, endIndexValue,
                                  relationshipType){
  relInfo <- cbind(startLabel, startIndexName, startIndexValue,
                   endLabel, endIndexName, endIndexValue,
                   relationshipType);
  t <- newTransaction(graph);
  for (i in 1:nrow(relInfo)){
    query <- paste("MERGE (a:", relInfo[i,"startLabel"]," {", relInfo[i,"startIndexName"], ":'", relInfo[i,"startIndexValue"], "'}) ",
                   "MERGE (b:", relInfo[i,"endLabel"]," {", relInfo[i,"endIndexName"], ":'", relInfo[i,"endIndexValue"], "'}) ",
                   "CREATE (a)-[r:",relInfo[i,"relationshipType"],"]->(b)", sep="");
    #print(query)
    appendCypher(t, query);
  }
  commit(t);
}
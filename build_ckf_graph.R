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

bulkUpdateNodeProperties<-function(graph, labelNames, indexNames, indexValues, propertyNames, propertyValues){
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
library(RNeo4j);

graph = startGraph("http://localhost:7474/db/data/");

graph$version;
# [1] "2.1.6"

bulkCreateNodes<-function(graph, labelName, indexName, indexValueVector){
  query <- paste("CREATE (n:",labelName," {",c,":{indexValue}})", sep="");
  t <- newTransaction(graph);
  
  for (i in 1:length(indexValueVector)){
    value <- indexValueVector[i];
    appendCypher(t, query, indexValue = value);
  }
  
  commit(t);
  
  addIndex(graph, labelName, indexName);
}

bulkAddNodeProperties<-function(graph, NodeInfo){
  indexName <- colnames(NodeInfo)[1];
  indexValues <- NodeInfo[,1];
  Properties <- NodeInfo[,-1];
  query <- paste("
                 MERGE (n {",indexName,":{indexValue}})
                 SET n.{propertyName}="
                 ,""
                 )
                
  
  for (i in 1:length(indexValues)){
    
  }
}
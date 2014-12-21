library(RNeo4j);

graph = startGraph("http://localhost:7474/db/data/");

graph$version;
# [1] "2.1.6"



createBulkNodes <- function(Properties,labelName){
  apply(Properties, 1, function(row){
    #print(row[1]);
    #print(row[2]);
    #print(row[3]);
    #typeof(row[1]);
    createNode(graph, labelName, name=row[[1]], hair = row[[2]], age = row[[3]]);
  });
  
  
}

# 
# for (i in menu[,1]) {print(i)};
# 
# #create menu item nodes
# for (i in menu[,1]) {
#   createNode(graph, "Item", name = i);
# };
# 
# #add index 
# addIndex(graph, "Item", "name");
# 
# #create feature nodes
# for (i in unique(unlist(features))) {
#   createNode(graph, "Feature", name = i);
# };
# 
# #add index 
# addIndex(graph, "Feature", "name");
# 
# full <- cbind(menu, features);
# 
# #create relationships between items and features
# #This needs work - probably need to use lapply, or something
# 
# apply(full, 1, function(row){
#       title_tmp <- row[[1]];
#       #print(title_tmp);
#       for (feature_tmp in row[[3]]){
#         #print(feature_tmp);
#         cypher(graph, "CREATE (i:Item)-[r:HAS_FEATURE]->(f:Feature) WHERE i.name={items} AND f.name={features}", items=title_tmp, features=feature_tmp);
#       }
#     }
#   )
# 
# 
# for (i in full) {
#   i[,1]
# #  for (j in unlist(features[i])) {
#  #   print(i)
#   #  print(j)
#     #cypher(graph, "CREATE (i:Item {name:'Beer'})-[r:HAS_FEATURE]->(f:Feature {name:'beer'})");
#   #}
# }
# 
# for (j in features) {
#   print(unlist(j))
# }
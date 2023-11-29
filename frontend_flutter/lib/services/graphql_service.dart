import "package:frontend_flutter/services/graphql_config.dart";
import "package:graphql_flutter/graphql_flutter.dart";

class GraphQLService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

  // type Query {
  //     artist(name: String!): Artist
  //     album(name: String!): Album
  //     song(name: String!): Song
  // }

}

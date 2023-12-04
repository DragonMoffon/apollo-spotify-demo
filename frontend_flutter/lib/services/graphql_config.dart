import 'package:graphql_flutter/graphql_flutter.dart';
// Configurations for the GraphQL client.
class GraphQLConfig {
  static HttpLink httpLink = HttpLink('http://localhost:4000'); // HTTP link should be where your GraphQL server is hosted
  GraphQLClient clientToQuery() =>
      GraphQLClient(link: httpLink, cache: GraphQLCache());
}

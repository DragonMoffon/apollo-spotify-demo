import "package:frontend_flutter/models/album_model.dart";
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
  Future<List<AlbumModel>> getAlbumFromSearch({required String title}) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
            query album(\$title: String!) {
              album(title: \$title) {
                title
                artists
                songs {
                  title
                  length
                  artists
                }
              }
            }
          """),
          variables: {"title": title},
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      }

      /// Since it returns a jsonmap need to put it in an array.
      List? res = [Map<String, dynamic>.from(result.data?['album'])];
      if (res.isEmpty) {
        return [];
      }

      List<AlbumModel> album =
          res.map((item) => AlbumModel.fromMap(item)).toList();

      return album;
    } catch (err) {
      throw Exception(err);
    }
  }
}

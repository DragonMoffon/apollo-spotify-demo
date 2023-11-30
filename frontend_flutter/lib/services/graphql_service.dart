import "package:frontend_flutter/models/SPF_track_model.dart";
import "package:frontend_flutter/services/graphql_config.dart";
import "package:graphql_flutter/graphql_flutter.dart";

class GraphQLService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

  Future<List<SPF_TrackModel>> getTrackFromSearch(
      {required String inputTitle}) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
              query SPF_search_for_item(\$query: SPF_SearchQuery!, \$types: [SPF_SearchableTypes]!) {
                SPF_search_for_item(query: \$query, types: \$types) {
                  tracks {
                    items {
                      ... on SPF_Track {
                        disc
                        duration
                        explicit
                        href
                        id
                        is_local
                        is_playable
                        name
                        number
                        popularity
                        preview
                        type
                        uri
                      }
                    }
                  }
                }
              }
          """),
          variables: {
            "query": {"input": inputTitle},
            "types": "track"
          },
        ),
      );

      // print(result.toString());
      if (result.hasException) {
        throw Exception(result.exception);
      }

      List? res = result.data?['SPF_search_for_item']['tracks']['items'];

      if (res == null ||res.isEmpty) {
        return [];
      }

      List<SPF_TrackModel> tracks =
          res.map((item) => SPF_TrackModel.fromMap(item)).toList();
      return tracks;
    } catch (err) {
      throw Exception(err);
    }
  }

  // Future<List<AlbumModel>> getAlbumFromSearch({required String title}) async {
  //   try {
  //     QueryResult result = await client.query(
  //       QueryOptions(
  //         fetchPolicy: FetchPolicy.noCache,
  //         document: gql("""
  //           query album(\$title: String!) {
  //             album(title: \$title) {
  //               title
  //               artists
  //               songs {
  //                 title
  //                 length
  //                 artists
  //               }
  //             }
  //           }
  //         """),
  //         variables: {"title": title},
  //       ),
  //     );

  //     if (result.hasException) {
  //       throw Exception(result.exception);
  //     }

  //     /// Since it returns a jsonmap need to put it in an array.
  //     List? res = [Map<String, dynamic>.from(result.data?['album'])];
  //     if (res.isEmpty) {
  //       return [];
  //     }

  //     List<AlbumModel> album =
  //         res.map((item) => AlbumModel.fromMap(item)).toList();

  //     return album;
  //   } catch (err) {
  //     throw Exception(err);
  //   }
  // }
}

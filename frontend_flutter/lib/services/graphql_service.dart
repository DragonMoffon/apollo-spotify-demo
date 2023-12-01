import "package:frontend_flutter/models/SPF_artist_model.dart";
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
                      artists {
                        name
                        uri
                        id
                        href
                      }
                      disc
                      duration
                      explicit
                      external_ids {
                        id
                        name
                      }
                      external_urls {
                        name
                        url
                      }
                      href
                      id
                      is_playable
                      name
                      popularity
                      preview
                      number
                      type
                      uri
                      is_local
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
      // print("---------------------------------");
      // print(res.toString());
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

  Future<List<SPF_ArtistModel>> getArtistFromSearch(
      {required String inputName}) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
            query SPF_search_for_item(\$query: SPF_SearchQuery!, \$types: [SPF_SearchableTypes]!) {
              SPF_search_for_item(query: \$query, types: \$types) {
                artist {
                  items {
                    ... on SPF_Artist {
                      followers
                      href
                      id
                      external_urls {
                        name
                        url
                      }
                      name
                      popularity
                      type
                      uri
                      images {
                        url
                        width
                        height
                      }
                    }
                  }
                }
              }
            }
          """),
          variables: {
            "query": {"input": inputName},
            "types": "artist"
          },
        ),
      );

      print(result.toString());
      if (result.hasException) {
        throw Exception(result.exception);
      }

      List? res = result.data?['SPF_search_for_item']['artist']['items'];
      print("---------------------------------");
      print(res.toString());
      if (res == null ||res.isEmpty) {
        return [];
      }

      List<SPF_ArtistModel> tracks =
          res.map((item) => SPF_ArtistModel.fromMap(item)).toList();
      return tracks;
    } catch (err) {
      throw Exception(err);
    }
  }
}

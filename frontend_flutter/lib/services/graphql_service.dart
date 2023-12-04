import "package:frontend_flutter/models/SPF_album_model.dart";
import "package:frontend_flutter/models/SPF_artist_model.dart";
import "package:frontend_flutter/models/SPF_track_model.dart";
import "package:frontend_flutter/services/graphql_config.dart";
import "package:graphql_flutter/graphql_flutter.dart";

// This class is the GraphQL client interacts with GraphQL Server to perform
// search for tracks, artists and albums on Spotify.
class GraphQLService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

  // Generic api call method to get data from GraphQL server.
  Future<List<T>> searchForItems<T>({
    required String input,
    required String types,
    required String query,
    // In theory you could just remove itemKey and use the types parameter but 
    // when getting tracks the itemkey required is "tracks" not "track" like in type.
    required String itemKey,
    required T Function(Map<String, dynamic>) fromMap,
  }) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(query),
          variables: {
            "query": {"input": input},
            "types": types,
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      }

      List? res = result.data?['SPF_search_for_item'][itemKey]['items'];
      if (res == null || res.isEmpty) {
        return [];
      }

      return res.map((item) => fromMap(item)).toList();
    } catch (err) {
      throw Exception(err);
    }
  }

  // Performs a GraphQL query to search for tracks based on the provided title.
  Future<List<SPF_TrackModel>> getTrackFromSearch(
      {required String inputTitle}) async {
    return searchForItems(
      input: inputTitle,
      types: 'track',
      query: """
        query SPF_search_for_item(\$query: SPF_SearchQuery!, \$types: [SPF_SearchableTypes]!) {
          SPF_search_for_item(query: \$query, types: \$types) {
            tracks {
              items {
                ... on SPF_Track {
                   album {
                    href
                    id
                    name
                    images {
                      width
                      url
                      height
                    }
                  }
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
      """,
      itemKey: 'tracks',
      fromMap: (item) => SPF_TrackModel.fromMap(item),
    );
  }

   // Performs a GraphQL query to search for artists based on the provided name.
  Future<List<SPF_ArtistModel>> getArtistFromSearch(
      {required String inputName}) async {
    return searchForItems(
      input: inputName,
      types: 'artist',
      query: """
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
      """,
      itemKey: 'artist',
      fromMap: (item) => SPF_ArtistModel.fromMap(item),
    );
  }

     // Performs a GraphQL query to search for albums based on the provided title.
  Future<List<SPF_AlbumModel>> getAlbumFromSearch(
      {required String inputName}) async {
    return searchForItems(
      input: inputName,
      types: 'album',
      query: """
        query SPF_search_for_item(\$query: SPF_SearchQuery!, \$types: [SPF_SearchableTypes]!) {
          SPF_search_for_item(query: \$query, types: \$types) {
            album {
              items {
                ... on SPF_Album {
                  album_type
                  id
                  href
                  images {
                    height
                    url
                    width
                  }
                  name
                  release
                  total_tracks
                  type
                  uri
                  artists {
                    id
                    name
                    uri
                    href
                  }
                  external_urls {
                    name
                    url
                  }
                }
              }
            }
          }
        }
      """,
      itemKey: 'album',
      fromMap: (item) => SPF_AlbumModel.fromMap(item),
    );
  }
}

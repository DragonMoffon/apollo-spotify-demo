import { AccessToken } from "./auth.js"
import { search_for_item } from "./api_calls.js"

function process_track(track){
    return {
        disc: track['disc_number'],
        duration: track['duration_ms'],
        href: track['href'],
        id: track['id'],
        is_local: track['is_local'],
        is_playable: track['is_playable'],
        name: track['name'],
        popularity: track['popularity'],
        preview: track['preview'],
        number: track['track_number'],
        type: track['type'],
        uri: track['uri']
    }
}

function process_search_for_tracks(result){
    var track_search = {
        limit: result['limit'],
        offset: result['offset'],
        total: result['total'],
        next: null,
        prev: null,
        items: result['items'].map((value, index, array) => process_track(value))
    }

    return track_search
}

async function resolve_SPF_search_for_item(parent, args, contextValue, info) {
    const inital_get = await search_for_item(args.query, args.types, args.market, args.limit, args.offset, args.include_external)

    const tracks = process_search_for_tracks(inital_get['tracks'])

    return {
        tracks: tracks,
        artist: null,
        album: null,
        playlists: null
    }
}


export const SPF_search_resolvers = {
    Query: {
        SPF_search_for_item: resolve_SPF_search_for_item
    },
    SPF_SearchableItem: {
        __resolveType(obj, contextValue, info){
            switch (obj.type) {
                case "track":
                    return 'SPF_Track'
                case "album":
                    return 'SPF_Album'
                case "artist":
                    return 'SPF_Artist'
                case "playlist":
                    return 'SPF_Playlist'
            }
            return null
        }
    }

}


async function resolve_SPF_search_for_item(parent, args, contextValue, info) {
    return {
        tracks: [],
        artist: [],
        album: [],
        playlists: [],
        shows: [],
        episodes: [],
        audiobooks: []

    }
}

export const SPF_search_resolvers = {
    Query: {
        SPF_search_for_item: resolve_SPF_search_for_item
    }
}


async function resolve_SPF_search_for_item(parent, args, contextValue, info) {
    console.log(args.query)
    return {
        tracks: [
            {
                limit: 200
            }
        ],
        artist: null,
        album: null,
        playlists: null
    }
}

async function resolve_no_6(parent, args, contextValue, info) {
    console.log(6)
    return 6
}

export const SPF_search_resolvers = {
    Query: {
        SPF_search_for_item: resolve_SPF_search_for_item
    }
}


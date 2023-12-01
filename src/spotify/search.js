import { AccessToken } from "./auth.js"
import { search_for_item, get_several_artists, get_artist } from "./api_calls.js"
import { get } from "http"
import { it } from "node:test"
import { types } from "util"
import { trace } from "console"

function process_external_url(name, url){
    return {
        name: name,
        url: url
    }
}  

function process_external_id(name, id){
    return {
        name: name,
        id: id
    }
}

function process_image(image){
    return {
        url: image.url,
        width: image.width,
        height: image.height
    }
}

function process_album(album){
    return {

    }
}

function process_artist(artist){
    return {
        external_urls: Object.keys(artist.external_urls).map((name) => process_external_url(name, artist.external_urls[name])),
        followers: artist.followers.total,
        href: artist.href,
        id: artist.id,
        images: Object.keys(artist.images).map((image) => process_image(image)),
        name: artist.name,
        popularity: artist.popularity,
        type: artist.type,
        uri: artist.uri
    }
}


async function process_track(track){
    var artist_data = await get_several_artists(track.artists.map((artist) => artist.id))
    var artists = artist_data.artists.map((artist) => process_artist(artist))
    return {
        alubms: process_album(track.album),
        artists: artists,
        available_markets: track.available_markets,
        disc: track.disc_number,
        duration: track.duration_ms,
        external_urls: Object.keys(track.external_urls).map((name) => process_external_url(name, track.external_urls[name])),
        external_ids: Object.keys(track.external_ids).map((name) => process_external_id(name, track.external_ids[name])),
        href: track.href,
        id: track.id,
        is_local: track.is_local,
        is_playable: track.is_playable,
        name: track.name,
        popularity: track.popularity,
        preview: track.preview,
        number: track.track_number,
        type: track.type,
        uri: track.uri
    }
}

async function process_search_for_tracks(result){
    var items = await Promise.all(result.items.map(async (track) => await process_track(track)))
    var track_search = {
        limit: result.limit,
        offset: result.offset,
        total: result.total,
        next: null,
        prev: null,
        items: items,
    }
    return track_search
}

async function process_search_for_artists(result){
    var items = await Promise.all(result.items.map(async (artist) => await process_artist(artist)))
    var artist_search = {
        limit: result.limit,
        offset: result.offset,
        total: result.total,
        next: null,
        prev: null,
        items: items,
    }

    return artist_search
}

async function proces_search_for_albums(result){
    var items = await Promise.all(result.items.map(async (albums) => await process_album(album)))
    var album_search = {
        limit: result.limit,
        offset: result.offset,
        total: result.total,
        next: null,
        prev: null,
        items: items,
    }

    return album_search
}

async function resolve_SPF_search_for_item(parent, args, contextValue, info) {
    const inital_get = await search_for_item(args.query, args.types, args.market, args.limit, args.offset, args.include_external)

    const tracks = inital_get.tracks != undefined ? await process_search_for_tracks(inital_get.tracks) : null
    const artists = inital_get.artists != undefined ? await process_search_for_artists(inital_get.artists) : null
    // const albums = initial_get.albums != undefined ? await proces_search_for_albums(inital_get.albums) : null
    // console.log(albums)

    return {
        tracks: tracks,
        artist: artists,
        album: null,
        playlists: null
    }
}


export const SPF_search_resolvers = {
    Query: {
        SPF_search_for_item: resolve_SPF_search_for_item
    },
    SPF_Search: {
        items(parent) {
            return parent.items
        }
    },
    SPF_Album: {
        artists(album) {
            console.log("artist process album: " + album)
        },
        tracks(album) {
            console.log("tracks process album: " + album)
        }
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


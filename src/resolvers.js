import { artists, albums, songs } from "./data.js"

// QUERY RESOLVERS

function get_song_by_name(parent, args, contextValue, info) {
    console.log(`getting song from title: ${args.title}`)
    return songs.find((song) => song.title === args.title)
};

function get_album_by_name(parent, args, contextValue, info) {
    console.log(`getting album from title: ${args.title}`)
    return albums.find((album) => album.title === args.title)
};

function get_artist_by_name(parent, args, contextValue, info) {
    console.log(`getting artist from name: ${args.name}`)
    return artists.find((artist) => artist.name === args.name)
};

// ARTIST SPECFIC RESOLVERS (for nested resolving)

function get_discography_of_artist(parent, args, contextValue, info) {
    return albums.filter((album) => album.artists.includes(parent.name))
}

// ALBUM SPECIFIC RESOLVERS (for nested resolving)

function get_songs_in_album(parent, args, contextValue, info) {
    return songs.filter((song) => parent.songs.includes(song.title))
}

export const resolvers = {
    Query: {
        song: get_song_by_name,
        album: get_album_by_name,
        artist: get_artist_by_name
    },
    Artist: {
        discography: get_discography_of_artist
    },
    Album: {
        songs: get_songs_in_album
    }
}
import exp from "constants";
import { AccessToken } from "./auth.js";

export async function search_for_item(query, types, market = null, limit = null, offset = null, include_external = null){
    const query_string = "q=" + [query.input, ...(query.album != null ? [`album:${query.album}`] : []), ...(query.artist != null ? [`artist:${query.artist}`] : []), ...(query.track != null ? [`track:${query.track}`] : [])].join("%20");
    const type_string = "type=" + types.join("%2C");

    const full_query = [query_string, type_string, ...(market != null ? [`market=${market}`] : []), ...(limit != null ? [`limit=${limit}`] : []), ...(offset != null ? [`offset=${offset}`] : []), ...(include_external!=null ? [`include_external=audio`] : [])].join("&");

    try {
        const initial_get_result = await fetch(
            "https://api.spotify.com/v1/search?" + full_query,
            {
                method: "GET",
                headers: {
                    "Authorization": `Bearer ${AccessToken.get_token()}`
                }
            }
        );
        
        if (!initial_get_result.ok) {
            console.log(initial_get_result);
            throw new error(`Error! status: ${initial_get_result.status}`);
        }
        return await initial_get_result.json();
    }
    catch (err){
        console.log(err);
    }
}

export async function get_artist(id){

}

export async function get_several_artists(ids){
    const full_query = "ids=" + ids.join("%2C");
    try {
        const inital_get_result = await fetch(
            "https://api.spotify.com/v1/artists?" + full_query,
            {
                method: "Get",
                headers: {
                    "Authorization": `Bearer ${AccessToken.get_token()}`
                }
            }
        );

        if (!inital_get_result.ok) {
            console.log(inital_get_result);
        }
        return await inital_get_result.json();
    }
    catch (err) {
        console.log(err);
    }
}

export async function get_album(id){
    
} 
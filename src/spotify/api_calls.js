import { AccessToken } from "./auth.js";

export async function search_for_item(query, types, market = null, limit = null, offset = null, include_external = null){
    const query_string = "q=" + [query.input, ...(query.album != null ? [`album:${query.album}`] : []), ...(query.artist != null ? [`artist:${query.artist}`] : []), ...(query.track != null ? [`track:${query.track}`] : [])].join("%20")
    const type_string = "type=" + types.join("%2C")

    const full_query = [query_string, type_string, ...(market != null ? [`market=${market}`] : []), ...(limit != null ? [`limit=${limit}`] : []), ...(offset != null ? [`offset=${offset}`] : []), ...(include_external!=null ? [`include_external=audio`] : [])].join("&")
    console.log(full_query)

    try {
        const initial_get_result = await fetch(
            "https://api.spotify.com/v1/search?" + full_query,
            {
                method: "GET",
                headers: {
                    "Authorization": `Bearer ${AccessToken.get_token()}`
                }
            }
        )
        
        if (!initial_get_result.ok) {
            console.log(initial_get_result);
            throw new error(`Error! status: ${initial_get_result.status}`);
        }
        return await initial_get_result.json()
    }
    catch (err){
        console.log(err)
    }
}
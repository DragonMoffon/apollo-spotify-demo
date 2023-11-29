import { error } from "console";
import { service_id, service_secret } from "./secret.js"

export async function get_access_token(){
    try{
        const response = await fetch(
            "https://accounts.spotify.com/api/token",
            {
                method: 'POST',
                body: new URLSearchParams({
                    'grant_type': 'client_credentials',
                }),
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                    'Authorization': 'Basic ' + (Buffer.from(service_id + ':' + service_secret).toString('base64'))
                }
            }
        );
    
        if (!response.ok) {
            console.log(response);
            throw new error(`Error! status: ${response.status}`);
        }
        const data = await response.json()
        return {
            token: data['access_token'],
            expires: Date.now() + 1000 * data['expires_in']
        };
    }
    catch (err) {
        console.log(err)
    }
}

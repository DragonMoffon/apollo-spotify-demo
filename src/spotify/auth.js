import { error } from "console";
import { service_id, service_secret } from "./secret.js"

export class AccessToken {
    static token_raw = null;
    static token = null;
    static expires = null;

    static set_token(token, expires, raw){
        AccessToken.token = token
        AccessToken.expires = expires
        AccessToken.token_raw = raw
    }

    static get_token(){
        return AccessToken.token
    }

    static get_expiry(){
        return AccessToken.expires
    }

    static get_raw(){
        return AccessToken.token_raw
    }

    static check_valid(){
        return !(AccessToken.token == null) || !AccessToken.check_expired()
    }

    static check_expired(){
        return Date.now() >= AccessToken.expires
    }

    static async request_new_token(){
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
            AccessToken.set_token(data['access_token'], Date.now() + 1000 * data['expires_in'], data)
        }
        catch (err) {
            console.log(err)
        }
    }

}

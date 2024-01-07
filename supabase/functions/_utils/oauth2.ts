import { encodeBase64Url } from "https://deno.land/std@0.211.0/encoding/base64url.ts";

export interface Oauth2Response {
    access_token: string,
    scope: string,
    token_type: string,
    expires_in: number
}

export interface JwtTokenInput {
    keyId: string,
    email: string,
    privateKey: string
}

export async function generateJwtToken(data: JwtTokenInput): Promise<string> {
  const header = {
    alg: "RS256",
    typ: "JWT",
    kid: data.keyId
  };
  const payload = {
    iss: data.email,
    scope: ['https://www.googleapis.com/auth/androidpublisher'],
    exp: Date.now()+120,
    iat: Date.now(),
    aud: "https://oauth2.googleapis.com/token"
  };
  
  const keyString = data.privateKey;
  var enc = new TextEncoder();
  const keyBuffer = enc.encode(keyString).buffer;
  const key = await crypto.subtle.importKey(
    "pkcs8",
    keyBuffer,
    {
      name: "RSASSA-PKCS1-v1_5",
      hash: "SHA-256",
    },
    true,
    ["sign", "verify"]
  );

  const base64Header = encodeBase64Url(JSON.stringify(header));
  const base64Payload = encodeBase64Url(JSON.stringify(payload));

  /*const signature = await crypto.subtle.sign(
    "RSASSA-PKCS1-v1_5",
    key,
    enc.encode(base64Header  + "." + base64Payload)
  );

  const base64Signature = encodeBase64Url(signature);*/

  return "";
  //return base64Header + "." + base64Payload + "." + base64Signature;
}

export async function getOauth2AccessToken(jwtToken: string): Promise<Oauth2Response> {
  const response = await fetch(
    "https://oauth2.googleapis.com/token",
    {
      method: "POST",
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: JSON.stringify({
        grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer",
        assertion: jwtToken
      }),
    }
  );

  if(!response.ok) {
    throw new Error("Oauth2 token response failure status: ${response.status}");
  }
  const json = await response.json();
  const data: Oauth2Response = {
    access_token: json.access_token,
    scope: json.scope,
    token_type: json.token_type,
    expires_in: json.expires_in
  };
  return data;
}

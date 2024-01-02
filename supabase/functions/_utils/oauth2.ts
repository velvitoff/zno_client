import { create } from "https://deno.land/x/djwt@v3.0.1/mod.ts";

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
    typ: "JWT", kid: data.keyId
  };
  const payload = {
    iss: data.email,
    scope: ['https://www.googleapis.com/auth/androidpublisher'],
    exp: Date.now()+120,
    iat: Date.now()
  };
  
  const binaryDerString = atob(data.privateKey);
  const binaryDer = str2ab(binaryDerString);
  const key = crypto.subtle.importKey(
    "pkcs8",
    binaryDer,
    {
      name: "RSASSA-PKCS1-v1_5",
      hash: "SHA-256",
    },
    true,
    ["sign", "verify"]
  )

  return await create(header, payload, key);
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

function str2ab(str: string): ArrayBuffer {
  const buf = new ArrayBuffer(str.length);
  const bufView = new Uint8Array(buf);
  for (let i = 0, strLen = str.length; i < strLen; i++) {
    bufView[i] = str.charCodeAt(i);
  }
  return buf;
}
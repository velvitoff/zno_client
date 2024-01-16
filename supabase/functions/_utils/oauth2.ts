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

function base64StringToArrayBuffer(b64str) {
  var byteStr = atob(b64str);
  var bytes = new Uint8Array(byteStr.length);
  for (var i = 0; i < byteStr.length; i++) {
    bytes[i] = byteStr.charCodeAt(i);
  }
  return bytes.buffer;
}

export async function generateJwtToken(data: JwtTokenInput): Promise<string> {
  const textEncoder = new TextEncoder();
  const privateKey = await crypto.subtle.importKey(
    "pkcs8",
    base64StringToArrayBuffer(data.privateKey),
    {
      name: "RSASSA-PKCS1-v1_5",
      hash: "SHA-256"
    },
    true,
    ["sign"]
  );

  const header = {
    alg: "RS256",
    typ: "JWT",
    kid: data.keyId
  };
  const header64 = encodeBase64Url(textEncoder.encode(JSON.stringify(header)));

  const payload = {
    iss: data.email,
    scope: 'https://www.googleapis.com/auth/androidpublisher',
    aud: "https://oauth2.googleapis.com/token",
    iat: Math.floor(Date.now() / 1000),
    exp: Math.floor(Date.now() / 1000) + 3600
  };
  const payload64 = encodeBase64Url(textEncoder.encode(JSON.stringify(payload)));

  const signInput = `${header64}.${payload64}`;
  const signature = await crypto.subtle.sign(
    "RSASSA-PKCS1-v1_5",
    privateKey,
    new TextEncoder().encode(signInput)
  );

  return `${signInput}.${encodeBase64Url(signature)}`;  
}

export async function getOauth2AccessToken(jwtToken: string): Promise<Oauth2Response> {
  const bodyParams = new URLSearchParams();
  bodyParams.append('grant_type', 'urn:ietf:params:oauth:grant-type:jwt-bearer');
  bodyParams.append('assertion', jwtToken);

  const response = await fetch(
    "https://oauth2.googleapis.com/token",
    {
      method: "POST",
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: bodyParams.toString(),
    }
  );

  const json = await response.json();
  const data: Oauth2Response = {
    access_token: json.access_token,
    scope: json.scope,
    token_type: json.token_type,
    expires_in: json.expires_in
  };
  return data;
}

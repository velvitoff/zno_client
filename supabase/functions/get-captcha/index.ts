import { createCaptcha } from "https://deno.land/x/captcha/mods.ts";

Deno.serve(async (req) => {
  const captcha = createCaptcha();

  return new Response(
    JSON.stringify({
      text: captcha.text,
      image: captcha.image
    }),
    { headers: { "Content-Type": "application/json" } },
  )
})

//supabase functions deploy get-premium-text --project-ref ydhnhgdhqmsgivefgczz
Deno.serve(async (req: any) => {
  return new Response(
    new TextEncoder().encode(JSON.stringify([
      "Придбання преміуму надає доступ до тестів ЗНО та НМТ усіх попередніх років.",
      "Оплата відбувається лише один раз — це не підписка.",
      "З таких предметів як Хімія і Фізика наразі є додаткові тести до 2016 року включно. Математика має тести до 2014 року включно.",
      "Преміум коштує 89.99 гривень. Після купівлі, перезайдіть у ваш акаунт."
    ])),
    { headers: { "Content-Type": "application/json; charset=utf-8" } },
  )
})

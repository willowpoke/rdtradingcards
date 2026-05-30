local item = {}

function item.run(uj, ujf, message, mt, interaction)
  if not uj.conspt then uj.conspt = "none" end
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/cons.json")
  local replying = interaction or message
  if uj.conspt == "none" then
    uj.consumables["ratingform"] = uj.consumables["ratingform"] - 1
    if uj.consumables["ratingform"] == 0 then uj.consumables["ratingform"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1

    local rating = math.random(5)
    local star = config.emojis.star
    local nostar = config.emojis.missingstar
    local startext = string.rep(star, rating) .. string.rep(nostar, 5-rating)

    uj.conspt = "star_"..rating
    replying:reply(formatstring(lang.ratingform_message, {rating, startext}))
    local randtime = math.random(4, 8)
    uj.lastpull = uj.lastpull - randtime
    message:reply(formatstring(lang.cooldown_decrease, {randtime}, lang.plural_s))
    dpf.savejson(ujf, uj)
  else
    replying:reply(lang.ratingform_conspt)
  end
end

return item
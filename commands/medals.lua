local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !medals")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)

  local pagenumber = tonumber(mt[1]) and math.floor(mt[1]) or 1
  pagenumber = math.max(1, pagenumber)

  local nummedals = 0
  for k, v in pairs(uj.medals) do
    if v then nummedals = nummedals + 1 end
  end
  print("Number of medals is " .. nummedals)
  local maxpn = math.ceil(nummedals / 10)
  pagenumber = math.min(pagenumber, maxpn)

  print("Page number is " .. pagenumber)
  local medaltable = {}
  local medalstring = ''

  for k, v in pairs(uj.medals) do
    if v then table.insert(medaltable, "**" .. medaldb[k].name .. "**\n") end
  end
  table.sort(medaltable)

  for i = (pagenumber - 1) * 10 + 1, (pagenumber) * 10 do
    print(i)
    if medaltable[i] then medalstring = medalstring .. medaltable[i] end
  end
  
  message.channel:send{
    content = message.author.mentionString .. ", you have the following medals:",
    embed = {
      color = 0x85c5ff,
      title = message.author.name .. "'s Medals",
      description = medalstring,
      footer = {
        text =  "(Page " .. pagenumber .. " of " .. maxpn .. ")",
        icon_url = message.author.avatarURL
      }
    }
  }
end
return command

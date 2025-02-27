local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !togglecheck")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  if #mt ~= 1 then
    message.channel:send("Sorry, but the c!togglecheck command expects 1 argument. You can either set to check **card** or **token**.")
    return
  end
    
  if (mt[1] == "card") then
    uj.togglecheckcard = not uj.togglecheckcard
    if uj.togglecheckcard then
      message.channel:send("Getting a card that you have none of in your storage will no longer be notified!")
    else
      message.channel:send("Getting a card that you have none of in your storage will now be notified!")
    end
  elseif (mt[1] == "token") then
    uj.togglechecktoken = not uj.togglechecktoken
    if uj.togglechecktoken then
      message.channel:send("How many tokens you have after receiving or giving will no longer be notified!")
    else
      message.channel:send("How many tokens you have after receiving or giving will now be notified!")
    end
  else
    if mt[1] == "" then
      message.channel:send("Sorry, but the c!togglecheck command expects 1 argument. You can either set to check **card** or **token**.")
      return
    else
      message.channel:send("Sorry, but I cannot find " .. mt[1] .. ". You can either set to check **card** or **token**.")
    end
  end
  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
end
return command
  
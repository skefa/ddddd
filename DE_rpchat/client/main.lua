local PlayerData              = {}
local nbrDisplaying = 1
ESX                           = nil
local peds = {}
local GetGameTimer = GetGameTimer
local viewooc = true
local viewnews = true
local viewad = true
local viewbad = true

TriggerEvent('chat:addSuggestion', '/flipcoin', 'Flip a coin.')
TriggerEvent('chat:addSuggestion', '/dice', 'Shoot some dice.')
TriggerEvent('chat:addSuggestion', '/changechar', 'Go back to the character selection screen.')
TriggerEvent('chat:addSuggestion', '/address', 'Check your location.')
TriggerEvent('chat:addSuggestion', '/tognews', 'Toggle news broadcasts.')
TriggerEvent('chat:addSuggestion', '/togad', 'Toggle advertisements.')
TriggerEvent('chat:addSuggestion', '/togbad', 'Toggle business advertisements.')
TriggerEvent('chat:addSuggestion', '/address', 'Check your location.')
TriggerEvent('chat:addSuggestion', '/news', 'Broadcast the news.', {{ name="text", help="The story that you want to broadcast."}})
TriggerEvent('chat:addSuggestion', '/ad', 'Post an advertisement.', {{ name="text", help="What you want the advertisement to say."}})
TriggerEvent('chat:addSuggestion', '/bad', 'Post a business advertisement.', {{ name="text", help="What you want the advertisement to say."}})
TriggerEvent('chat:addSuggestion', '/pm', 'Private Message a player.', {{ name="id", help="ID of the player." }, { name="text", help="What you want to say." }})
TriggerEvent('chat:addSuggestion', '/pma', 'Private Message a admin.', {{ name="id", help="ID of the admin." }, { name="text", help="What you want to say." }})

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterCommand('blockb', function(source, args, rawCommand)
  if viewooc == true then
    viewooc = false
    exports['dlrms_notify']:SendAlert('info', 'You have blocked local OOC')
  else
    viewooc = true
    exports['dlrms_notify']:SendAlert('info', 'You have unblocked local OOC')
  end
end)

RegisterCommand('tognews', function(source, args, rawCommand)
	if viewnews == true then
		viewnews = false
		exports['dlrms_notify']:SendAlert('error', 'You have turned news broadcasts off')
	else
		viewnews = true
		exports['dlrms_notify']:SendAlert('success', 'You have turned news broadcasts on')
	end
end)

RegisterCommand('togad', function(source, args, rawCommand)
	if viewad == true then
		viewad = false
		exports['dlrms_notify']:SendAlert('error', 'You have turned advertisements off')
	else
		viewad = true
		exports['dlrms_notify']:SendAlert('success', 'You have turned advertisements on')
	end
end)

RegisterCommand('togbad', function(source, args, rawCommand)
	if viewbad == true then
		viewbad = false
		exports['dlrms_notify']:SendAlert('error', 'You have turned business advertisements off')
	else
		viewbad = true
		exports['dlrms_notify']:SendAlert('success', 'You have turned business advertisements on')
	end
end)

RegisterCommand('address', function(source, args, rawCommand)
    local playerCoords, address  = GetEntityCoords(PlayerPedId())
    local street, cross = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
    local zone = GetLabelText(GetNameOfZone(playerCoords.x, playerCoords.y, playerCoords.z))

    if cross ~= nil and cross ~= street then
      address = string.format('%s, %s, %s', GetStreetNameFromHashKey(street), GetStreetNameFromHashKey(cross), zone)
    end
    
    address = string.format('%s, %s', GetStreetNameFromHashKey(street), zone)

    TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(255, 255, 255, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> You are at {0} </div>',
      template = '<div style="color: rgba(255, 255, 255, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> You are at {0} </div>',
      args = { address }
    })
end)


RegisterNetEvent('prrp_rpchat:sendSays')
AddEventHandler('prrp_rpchat:sendSays', function(playerId, title, message, color)
  local source = PlayerId()
  local target = GetPlayerFromServerId(playerId)

  local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
  local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

  if target == source then
    TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(255, 255, 255, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} says: {1} </div>',
      template = '<div style="color: rgba(255, 255, 255, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} says: {1} </div>',
        args = { title, message }
    })
  elseif GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 5 then
    TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(255, 255, 255, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} says: {1} </div>',
      template = '<div style="color: rgba(255, 255, 255, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} says: {1} </div>',
        args = { title, message }
    })
  elseif GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 10 then
    TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(148, 148, 148, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} says: {1} </div>',
      template = '<div style="color: rgba(255, 255, 255, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} says: {1} </div>',
        args = { title, message }
    })
  elseif GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 15 then
    TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(75, 75, 75, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} says: {1} </div>',
      template = '<div style="color: rgba(255, 255, 255, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} says: {1} </div>',
        args = { title, message }
    })
  end
end)

RegisterNetEvent('prrp_rpchat:sendShout')
AddEventHandler('prrp_rpchat:sendShout', function(playerId, title, message, color)
  local source = PlayerId()
  local target = GetPlayerFromServerId(playerId)

  local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
  local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

  if target == source then
    TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(255, 255, 255, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} shouts: {1} </div>',
      template = '<div style="color: rgba(255, 255, 255, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} shouts: {1} </div>',
        args = { title, message }
    })
  elseif GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 20 then
    TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(255, 255, 255, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} shouts: {1} </div>',
      template = '<div style="color: rgba(255, 255, 255, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} shouts: {1} </div>',
        args = { title, message }
    })
  elseif GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 30 then
    TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(148, 148, 148, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} shouts: {1} </div>',
      template = '<div style="color: rgba(255, 255, 255, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} shouts: {1} </div>',
        args = { title, message }
    })
  elseif GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 40 then
    TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(75, 75, 75, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} shouts: {1} </div>',
      template = '<div style="color: rgba(255, 255, 255, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} shouts: {1} </div>',
        args = { title, message }
    })
  end
end)

RegisterNetEvent('prrp_rpchat:sendLow')
AddEventHandler('prrp_rpchat:sendLow', function(playerId, title, message, color)
  local source = PlayerId()
  local target = GetPlayerFromServerId(playerId)

  local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
  local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

  if target == source then
    TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(255, 255, 255, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} says [low]: {1} </div>',
      template = '<div style="color: rgba(255, 255, 255, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} says [low]: {1} </div>',
        args = { title, message }
    })
  elseif GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 3 then
    TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(255, 255, 255, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} says [low]: {1} </div>',
      template = '<div style="color: rgba(255, 255, 255, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} says [low]: {1} </div>',
        args = { title, message }
    })
  elseif GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 6 then
    TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(148, 148, 148, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} says [low]: {1} </div>',
      template = '<div style="color: rgba(255, 255, 255, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} says [low]: {1} </div>',
        args = { title, message }
    })
  elseif GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 10 then
    TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(75, 75, 75, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} says [low]: {1} </div>',
      template = '<div style="color: rgba(255, 255, 255, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} says [low]: {1} </div>',
        args = { title, message }
    })
  end
end)

RegisterNetEvent('prrp_rpchat:sendWhisper')
AddEventHandler('prrp_rpchat:sendWhisper', function(playerId, title, message, color)
  local source = PlayerId()
  local target = GetPlayerFromServerId(playerId)

  local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
  local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

  if target == source then
    TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(252, 245, 69, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} whispers: {1} </div>',
      template = '<div style="color: rgba(252, 245, 69, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} whispers: {1} </div>',
        args = { title, message }
    })
  elseif GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 2 then
    TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(252, 245, 69, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} whispers: {1} </div>',
      template = '<div style="color: rgba(252, 245, 69, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} whispers: {1} </div>',
        args = { title, message }
    })
  end
end)

RegisterNetEvent('prrp_rpchat:sendCarWhisper')
AddEventHandler('prrp_rpchat:sendCarWhisper', function(playerId, title, message, color)
  local source = PlayerId()
  local target = GetPlayerFromServerId(playerId)

  local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
  local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

  if IsPedInAnyVehicle(sourcePed, false) then
    if target == source then
      TriggerEvent('chat:addMessage', {
        --template = '<div style="color: rgba(252, 245, 69, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> (Car) {0} whispers: {1} </div>',
        template = '<div style="color: rgba(252, 245, 69, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> (Car) {0} whispers: {1} </div>',
        args = { title, message }
      })
    elseif GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 2 then
      TriggerEvent('chat:addMessage', {
        --template = '<div style="color: rgba(252, 245, 69, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> (Car) {0} whispers: {1} </div>',
        template = '<div style="color: rgba(252, 245, 69, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> (Car) {0} whispers: {1} </div>',
        args = { title, message }
      })
    end
  else
    exports['dlrms_notify']:SendAlert('error', 'You must be in a car')
  end
end)

RegisterNetEvent('prrp_rpchat:sendCarOOC')
AddEventHandler('prrp_rpchat:sendCarOOC', function(playerId, title, message, color)
  local source = PlayerId()
  local target = GetPlayerFromServerId(playerId)

  local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
  local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

  if viewooc == true then
    if IsPedInAnyVehicle(sourcePed, false) then
      if target == source then
        TriggerEvent('chat:addMessage', {
          --template = '<div style="color: rgba(252, 245, 69, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> (( {0}: {1} )) </div>',
          template = '<div style="color: rgba(252, 245, 69, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> (( {0}: {1} )) </div>',
          args = { title, message }
        })
      elseif GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 2 then
        TriggerEvent('chat:addMessage', {
          --template = '<div style="color: rgba(252, 245, 69, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> (( {0}: {1} )) </div>',
          template = '<div style="color: rgba(252, 245, 69, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> (( {0}: {1} )) </div>',
          args = { title, message }
        })
      end
    else
      exports['dlrms_notify']:SendAlert('error', 'You must be in a car')
    end
  end
end)

RegisterNetEvent('prrp_rpchat:sendMe')
AddEventHandler('prrp_rpchat:sendMe', function(playerId, title, message, color)
	local source = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
	local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

	if target == source then
		TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(194, 162, 218, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; ">* {0} {1}</div>',
      template = '<div style="color: rgba(194, 162, 218, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; ">* {0} {1}</div>',
        args = { title, message }
    })
	elseif GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 20 then
		TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(194, 162, 218, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; ">* {0} {2}</div>',
      template = '<div style="color: rgba(194, 162, 218, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; ">* {0} {2}</div>',
        args = { title, name, message }
    })
	end
end)

RegisterNetEvent('prrp_rpchat:sendMy')
AddEventHandler('prrp_rpchat:sendMy', function(playerId, title, message, color)
	local source = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
	local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

	if target == source then
		TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(194, 162, 218, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; ">* {0}\'s {1}</div>',
      template = '<div style="color: rgba(194, 162, 218, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; ">* {0}\'s {1}</div>',
        args = { title, message }
    })
	elseif GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 20 then
		TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(194, 162, 218, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; ">* {0}\'s {2}</div>',
      template = '<div style="color: rgba(194, 162, 218, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; ">* {0}\'s {2}</div>',
        args = { title, name, message }
    })
	end
end)

RegisterNetEvent('prrp_rpchat:flipcoin')
AddEventHandler('prrp_rpchat:flipcoin', function(playerId, title, side)
	local source = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
	local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

	if target == source then
		TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(194, 162, 218, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; ">* {0} flips a coin and lands it on ^3{1}</div>',
      template = '<div style="color: rgba(194, 162, 218, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; ">* {0} flips a coin and lands it on <span style="color: rgb(252, 245, 69)">{1}</span></div>',
        args = { title, side }
    })
	elseif GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 20 then
		TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(194, 162, 218, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; ">* {0} flips a coin and lands it on ^3{1}</div>',
      template = '<div style="color: rgba(194, 162, 218, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; ">* {0} flips a coin and lands it on <span style="color: rgb(252, 245, 69)">{1}</span></div>',
        args = { title, side }
    })
	end
end)

RegisterNetEvent('prrp_rpchat:dice')
AddEventHandler('prrp_rpchat:dice', function(playerId, title, numbers)
	local source = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
	local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

	if target == source then
		TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(194, 162, 218, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; ">* {0} throws a dice that lands on {1}</div>',
      template = '<div style="color: rgba(194, 162, 218, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; ">* {0} throws a dice that lands on {1}</div>',
        args = { title, numbers }
    })
	elseif GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 20 then
		TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(194, 162, 218, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; ">* {0} throws a dice that lands on {1}</div>',
      template = '<div style="color: rgba(194, 162, 218, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; ">* {0} throws a dice that lands on {1}</div>',
        args = { title, numbers }
    })
	end
end)

RegisterNetEvent('prrp_rpchat:serverdisconnect')
AddEventHandler('prrp_rpchat:serverdisconnect', function(playerId, title, reason)
	local source = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
	local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

	if target == source then
		TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(255, 255, 255, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; "> {0} has left the server. (Reason: {1})</div>',
      template = '<div style="color: rgba(255, 255, 255, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; "> {0} has left the server. (Reason: {1})</div>',
        args = { title, reason }
    })
	elseif GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 10 then
		TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(255, 255, 255, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; "> {0} has left the server. (Reason: {1})</div>',
      template = '<div style="color: rgba(255, 255, 255, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; "> {0} has left the server. (Reason: {1})</div>',
        args = { title, reason }
    })
	end
end)

RegisterNetEvent("prrp_rpchat:diceanim")
AddEventHandler("prrp_rpchat:diceanim", function()
    RequestAnimDict('anim@mp_player_intcelebrationmale@wank')

    while not HasAnimDictLoaded('anim@mp_player_intcelebrationmale@wank') do
      Citizen.Wait(0)
    end

    TaskPlayAnim(GetPlayerPed(-1), "anim@mp_player_intcelebrationmale@wank", "wank", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(1500)
    ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('prrp_rpchat:sendDo')
AddEventHandler('prrp_rpchat:sendDo', function(playerId, title, message, color)
	local source = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
	local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

	if target == source then
		TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(194, 162, 218, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; ">* {1} (( {0} ))</div>',
      template = '<div style="color: rgba(194, 162, 218, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; ">* {1} (( {0} ))</div>',
        args = { title, message }
    })
	elseif GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 20 then
		TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(194, 162, 218, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; ">* {1} (( {0} ))</div>',
      template = '<div style="color: rgba(194, 162, 218, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; ">* {1} (( {0} ))</div>',
        args = { title, message }
    })
	end
end)

RegisterNetEvent('prrp_rpchat:sendLocalOOC')
AddEventHandler('prrp_rpchat:sendLocalOOC', function(playerId, title, message, color)
	local source = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
	local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

  if viewooc == true then
	  if target == source then
		  TriggerEvent('chat:addMessage', {
        --template = '<div style="color: rgba(175, 175, 175, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;">(( {0}: {1} ))</div>',
        template = '<div style="color: rgba(175, 175, 175, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;">(( {0}: {1} ))</div>',
        args = { title, message }
      })
	  elseif GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 20 then
		  TriggerEvent('chat:addMessage', {
        --template = '<div style="color: rgba(175, 175, 175, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;">(( {0}: {1} ))</div>',
        template = '<div style="color: rgba(175, 175, 175, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;">(( {0}: {1} ))</div>',
        args = { title, message }
      })
	  end
  end
end)

RegisterNetEvent('prrp_rpchat:changechar')
AddEventHandler('prrp_rpchat:changechar', function(playerId, title)
	local source = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
	local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

	if target == source then
		TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(255, 255, 255, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; "> {0} changed their character and quit this one.</div>',
      template = '<div style="color: rgba(255, 255, 255, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; "> {0} changed their character and quit this one.</div>',
        args = { title }
    })
	elseif GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 20 then
		TriggerEvent('chat:addMessage', {
      --template = '<div style="color: rgba(255, 255, 255, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; "> {0} changed their character and quit this one.</div>',
      template = '<div style="color: rgba(255, 255, 255, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; "> {0} changed their character and quit this one.</div>',
        args = { title }
    })
	end
end)

RegisterNetEvent('prrp_rpchat:sendbroadcast')
AddEventHandler('prrp_rpchat:sendbroadcast', function(playerId, title, message, color)
  local source = PlayerId()
  local target = GetPlayerFromServerId(playerId)

	if viewnews then
    	TriggerEvent('chat:addMessage', {
			  --template = '<div style="color: rgba(51, 170, 51, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} {1}: {2} </div>',
        template = '<div style="color: rgba(51, 170, 51, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> {0} {1}: {2} </div>',
        	args = { "[NEWS]", title, message }
    	})
	end
end)

RegisterNetEvent('prrp_rpchat:sendad')
AddEventHandler('prrp_rpchat:sendad', function(playerId, message, number)
  local source = PlayerId()
  local target = GetPlayerFromServerId(playerId)

	if viewad == true then
    	TriggerEvent('chat:addMessage', {
      		--template = '<div style="color: rgba(51, 170, 51, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> [Advertisement] {0} [PH: {1}] </div>',
          template = '<div style="color: rgba(51, 170, 51, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> [Advertisement] {0} [PH: {1}] </div>',
        	args = { message, number }
    	})
	end
end)

RegisterNetEvent('prrp_rpchat:sendbad')
AddEventHandler('prrp_rpchat:sendbad', function(playerId, message)
  local source = PlayerId()
  local target = GetPlayerFromServerId(playerId)

  	if viewbad == true then
    	TriggerEvent('chat:addMessage', {
      		--template = '<div style="color: rgba(51, 170, 51, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> [Business Advertisement] {0} </div>',
          template = '<div style="color: rgba(51, 170, 51, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word;"> [Business Advertisement] {0} </div>',
        	args = { message }
    	})
	end
end)

RegisterNetEvent('3dme:triggerDisplay')
AddEventHandler('3dme:triggerDisplay', function(name, text, source)
    local offsetme = 1.24 + (nbrDisplaying*0.15)
    DisplayMe(GetPlayerFromServerId(source), name, text, offsetme)
end)

function DisplayMe(mePlayer, text, name, offsetme)
  local displaying = true

  Citizen.CreateThread(function()
      Wait(6000)
      displaying = false
  end)

  Citizen.CreateThread(function()
      nbrDisplaying = nbrDisplaying + 1
      while displaying do
          Wait(0)
          local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
          local coords = GetEntityCoords(PlayerPedId(), false)
          local dist = Vdist2(coordsMe, coords)
          if dist < 500 then

              local output = string.format("%s %s", name, text)
               DrawText3Dme(coordsMe['x'], coordsMe['y'], coordsMe['z']+offsetme-1.250, output)
          end
      end
      nbrDisplaying = nbrDisplaying - 1
  end)
end

function DrawText3Dme(x,y,z, text)
local onScreen, _x, _y = World3dToScreen2d(x, y, z)
local p = GetGameplayCamCoords()
local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
local scale = (1 / distance) * 2
local fov = (1 / GetGameplayCamFov()) * 100
local scale = scale * fov
if onScreen then
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
  end
end

local coordsVisible = false

function DrawGenericText(text)
	SetTextColour(186, 186, 186, 255)
	SetTextFont(7)
	SetTextScale(0.378, 0.378)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(false)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 205)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.40, 0.00)
end

-- Scene
RegisterCommand('scene', function(source, args)
    local sceneText = table.concat(args, " ")
    TriggerServerEvent('3dme:sceneDisplay', sceneText)
end)

RegisterNetEvent('3dme:sceneTriggerDisplay')
AddEventHandler('3dme:sceneTriggerDisplay', function(sceneText, source)
    local player = GetPlayerFromServerId(source)
    if player ~= -1 then
        local ped = GetPlayerPed(player)
        Utils.DisplayScene(ped, sceneText)
    end
end)

Utils = {
    Draw3DTextScene = function(xyz, sceneText)
        local onScreen, _x, _y = World3dToScreen2d(xyz.x,xyz.y,xyz.z)
        local p = GetGameplayCamCoords()
        local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, xyz.x,xyz.y,xyz.z, 1)
        local scale = (1 / distance) * (4)
        local fov = (1 / GetGameplayCamFov()) * 75
        local scale = scale * fov
        if onScreen then
            SetTextScale(tonumber(1*0.0), tonumber(0.35 * (1)))
            SetTextFont(0)
            SetTextProportional(true)
            SetTextColour(194, 162, 218, 255)
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextEdge(2, 0, 0, 0, 150)
            SetTextOutline()
            SetTextEntry("STRING")
            SetTextCentre(true)
            AddTextComponentString('* ' .. sceneText)
            DrawText(_x,_y)
            --local factor = (string.len(sceneText)) / 370
            --DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
        end
    end,
    DisplayScene = function(ped, sceneText)
        local timeout = 600000
        local xyz=GetEntityCoords(ped)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local pedCoords = GetEntityCoords(ped)
        local displaying = true
        Citizen.CreateThread(function()
            Citizen.Wait(timeout)
            displaying = false
        end)
        Citizen.CreateThread(function()
            while displaying do
                Citizen.Wait(0)
                    local output = string.format("%s", sceneText)
    
                    if Vdist2(GetEntityCoords(PlayerPedId(), false), xyz ) <= 55 then
                        Utils.Draw3DTextScene(xyz, output)
                    
                end
            end
        end)
    end,
    DrawText3Ds = function(x, y, z, text)
        local onScreen, _x, _y = World3dToScreen2d(x, y, z)
        local p = GetGameplayCamCoords()
        local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
        local scale = (1 / distance) * 2
        local fov = (1 / GetGameplayCamFov()) * 100
        local scale = scale * fov
        if onScreen then
              SetTextScale(0.35, 0.35)
              SetTextFont(4)
              SetTextProportional(1)
              SetTextColour(255, 255, 255, 215)
              SetTextEntry("STRING")
              SetTextCentre(1)
              AddTextComponentString(text)
              DrawText(_x,_y)
              local factor = (string.len(text)) / 370
              DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
          end
      end,
    Display = function(ped, name, text, offset)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local pedCoords = GetEntityCoords(ped)
        local dist = #(playerCoords - pedCoords)
    
        local displaying = true
        Citizen.CreateThread(function()
            Wait(7000)
            displaying = false
        end)
        Citizen.CreateThread(function()
            nbrDisplaying = nbrDisplaying + 1
            while displaying do
                Wait(0)
                if dist <= 15 then
                    local output = string.format("%s %s", name, text)
    
                    if HasEntityClearLosToEntity(playerPed, ped, 17 ) then
                        local x, y, z = table.unpack(GetEntityCoords(ped))
                        z = z + offset
                        Utils.DrawText3Ds(x, y, z, output, 3.0, 7)
                    end
                end
            end
            nbrDisplaying = nbrDisplaying - 1
        end)
    end,
}

Citizen.CreateThread(function()
    while true do
		local sleepThread = 250
		
		if coordsVisible then
			sleepThread = 5

			local playerPed = PlayerPedId()
			local playerX, playerY, playerZ = table.unpack(GetEntityCoords(playerPed))
			local playerH = GetEntityHeading(playerPed)

			DrawGenericText(("~g~X~w~: %s ~g~Y~w~: %s ~g~Z~w~: %s ~g~H~w~: %s"):format(FormatCoord(playerX), FormatCoord(playerY), FormatCoord(playerZ), FormatCoord(playerH)))
		end

		Citizen.Wait(sleepThread)
	end
end)

FormatCoord = function(coord)
	if coord == nil then
		return "unknown"
	end

	return tonumber(string.format("%.2f", coord))
end

ToggleCoords = function()
	coordsVisible = not coordsVisible
end

RegisterCommand("coords", function()
    ToggleCoords()
end)

local function draw3dTextAme(coords, text)
  local camCoords = GetGameplayCamCoord()
  local dist = #(coords - camCoords)
  
  -- Experimental math to scale the text down
  local scale = 200 / (GetGameplayCamFov() * dist)

  -- Format the text
  SetTextColour(179, 159, 229, 255)
  SetTextScale(0.0, 0.4 * scale)
  SetTextFont(0)
  SetTextDropshadow(0, 0, 0, 0, 55)
  SetTextDropShadow()
  SetTextCentre(true)

  -- Diplay the text
  BeginTextCommandDisplayText("STRING")
  AddTextComponentSubstringPlayerName(text)
  SetDrawOrigin(coords, 0)
  EndTextCommandDisplayText(0.0, 0.0)
  ClearDrawOrigin()
end

local function displayTextAme(ped, text)
  local playerPed = PlayerPedId()
  local playerPos = GetEntityCoords(playerPed)
  local targetPos = GetEntityCoords(ped)
  local dist = #(playerPos - targetPos)
  local los = HasEntityClearLosToEntity(playerPed, ped, 17)

  if dist <= 250 and los then
      local exists = peds[ped] ~= nil

      peds[ped] = {
          time = GetGameTimer() + 5000,
          text = text
      }

      if not exists then
          local display = true

          while display do
              Wait(0)
              local pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, 1.0)
              draw3dTextAme(pos, peds[ped].text)
              display = GetGameTimer() <= peds[ped].time
          end

          peds[ped] = nil
      end

  end
end

local function onShareDisplayAme(text, target)
  local player = GetPlayerFromServerId(target)
  if player ~= -1 or target == GetPlayerServerId(PlayerId()) then
      local ped = GetPlayerPed(player)
      displayTextAme(ped, text)
  end
end

RegisterNetEvent('3dme:shareDisplayAme', onShareDisplayAme)
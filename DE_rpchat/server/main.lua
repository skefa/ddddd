ESX = nil
local printItems = true

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function defaultdict(callable)
  local T = {}
  setmetatable(T, {
      __index = function(T, key)
          local val = rawget(T, key)
          if not val then
              rawset(T, key, callable())
          end
          return rawget(T, key)
      end
  })
  return T
end

commandCooldown = defaultdict(function() return 0 end)

local cooldown = 1800

AddEventHandler('esx:playerDropped', function(source)
  local _source = source
  local identifier = GetPlayerIdentifiers(_source)[1]

  commandCooldown[identifier] = nil
end)

AddEventHandler('playerDropped', function(reason)
  local xPlayer = ESX.GetPlayerFromId(source)
  local name = xPlayer.getName()
  TriggerClientEvent('prrp_rpchat:serverdisconnect', -1, source, name, reason)
end)

RegisterServerEvent('sendmetoall')
AddEventHandler('sendmetoall', function(message)
  local _source = source
  local name = GetCharacterName(_source)
  xPlayer = ESX.GetPlayerFromId(_source)

  TriggerClientEvent('prrp_rpchat:sendProximityMessage', -1, xPlayer.source, name, message, { 186, 0, 255 })
  TriggerClientEvent('3dme:triggerDisplay', -1, message, xPlayer.source)
end)

AddEventHandler('chatMessage', function(source, name, message)
  if string.sub(message, 1, string.len('/')) ~= '/' then
    CancelEvent()
 
    local xPlayer = ESX.GetPlayerFromId(source)
    if Config.EnableESXIdentity then name = xPlayer.getName() end

    TriggerClientEvent('prrp_rpchat:sendSays', -1, source, name, message, {186, 0, 255});
  end
end)

RegisterServerEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text)
   local xPlayer = ESX.GetPlayerFromId(source)
   if xPlayer then name = xPlayer.getName() end

   TriggerClientEvent('prrp_rpchat:sendMe', -1, source, name, text, { 196, 33, 246 })
end)

-- BAD command
RegisterCommand('bad', function(source, args, rawCommand)
  args = table.concat(args, ' ')
  local xPlayer = ESX.GetPlayerFromId(source)
  local price = 300
  local hasEnough = false
  local plyMon = xPlayer.getMoney()
  local identifier = GetPlayerIdentifiers(source)[1]
  local currentTime = os.time()
  
	if xPlayer.job.grade_name == 'boss' then
		if plyMon >= price then
			hasEnough = true
			
			if ((currentTime - commandCooldown[identifier]) > cooldown) then
			
			  TriggerClientEvent('prrp_rpchat:sendbad', -1, source, args)
        xPlayer.removeMoney(price)
			  TriggerClientEvent('dlrms_notify', source, 'info', 'You have paid $300 for this advertisement.')
			  Wait(2500)
			  TriggerClientEvent('dlrms_notify', source, 'info', 'You must wait 30 minutes before advertising again.')
			  commandCooldown[identifier] = currentTime
		  else
			  TriggerClientEvent('dlrms_notify', source, 'error', 'You need to wait the cooldown.')
      end
    else
      TriggerClientEvent('dlrms_notify', source, 'error', 'You do not have enough money.')
		end
	else
    TriggerClientEvent('dlrms_notify', source, 'error', 'You must be a higher rank in your job.')
  end
end)

-- AD command
RegisterCommand('ad', function(source, args, rawCommand)
  args = table.concat(args, ' ')
  local xPlayer = ESX.GetPlayerFromId(source)
  local price = 300
  local hasEnough = false
  local plyMon = xPlayer.getMoney()
  local identifier = GetPlayerIdentifiers(source)[1]
  local currentTime = os.time()
  local number = getNumberPhone(xPlayer.identifier)
 
	if plyMon >= price then
		hasEnough = true
			
		if ((currentTime - commandCooldown[identifier]) > cooldown) then
			
      TriggerClientEvent('prrp_rpchat:sendad', -1, source, args, number)
      xPlayer.removeMoney(price)
		  TriggerClientEvent('dlrms_notify', source, 'info', 'You have paid $300 for this advertisement.')
		  Wait(2500)
		  TriggerClientEvent('dlrms_notify', source, 'info', 'You must wait 30 minutes before advertising again.')
		  commandCooldown[identifier] = currentTime
	  else
		  TriggerClientEvent('dlrms_notify', source, 'error', 'You need to wait the cooldown.')
    end
  else
    TriggerClientEvent('dlrms_notify', source, 'error', 'You do not have enough money.')
	end
end)

-- NEWS command
RegisterCommand('news', function(source, args, rawCommand)
  args = table.concat(args, ' ')
  local xPlayer = ESX.GetPlayerFromId(source)
  name = xPlayer.getName()
  
	if xPlayer.job.name == 'reporter' then
	  TriggerClientEvent('prrp_rpchat:sendbroadcast', -1, source, name, args)
  else
    TriggerClientEvent('dlrms_notify', source, 'error', 'You must be a reporter for this.')
  end
end)

-- ME command
RegisterCommand('me', function(source, args, rawCommand)
  if source == 0 then
    print('prrp_rpchat: you can\'t use this command from rcon!')
    return
  end

  args = table.concat(args, ' ')
  local xPlayer = ESX.GetPlayerFromId(source)
  if Config.EnableESXIdentity then name = xPlayer.getName() end

  TriggerClientEvent('prrp_rpchat:sendMe', -1, source, name, args, { 196, 33, 246 })
end)

-- MY command
RegisterCommand('my', function(source, args, rawCommand)
  if source == 0 then
    print('prrp_rpchat: you can\'t use this command from rcon!')
    return
  end

  args = table.concat(args, ' ')
  local xPlayer = ESX.GetPlayerFromId(source)
  if Config.EnableESXIdentity then name = xPlayer.getName() end

  TriggerClientEvent('prrp_rpchat:sendMy', -1, source, name, args, { 196, 33, 246 })
end)

-- DO command
RegisterCommand('do', function(source, args, rawCommand)
  if source == 0 then
    print('prrp_rpchat: you can\'t use this command from rcon!')
    return
  end

  args = table.concat(args, ' ')
  local xPlayer = ESX.GetPlayerFromId(source)
  if Config.EnableESXIdentity then name = xPlayer.getName() end

  TriggerClientEvent('prrp_rpchat:sendDo', -1, source, name, args, { 255, 198, 0 })
end)

-- Low command
RegisterCommand('l', function(source, args, rawCommand)
  if source == 0 then
    print('prrp_rpchat: you can\'t use this command from rcon!')
    return
  end

  args = table.concat(args, ' ')
  local xPlayer = ESX.GetPlayerFromId(source)
  if Config.EnableESXIdentity then name = xPlayer.getName() end

  TriggerClientEvent('prrp_rpchat:sendLow', -1, source, name, args, {30, 144, 255});
end)

RegisterCommand('low', function(source, args, rawCommand)
  if source == 0 then
    print('prrp_rpchat: you can\'t use this command from rcon!')
    return
  end

  args = table.concat(args, ' ')
  local xPlayer = ESX.GetPlayerFromId(source)
  if Config.EnableESXIdentity then name = xPlayer.getName() end

  TriggerClientEvent('prrp_rpchat:sendLow', -1, source, name, args, {30, 144, 255});
end)

-- Whisper command
RegisterCommand('w', function(source, args, rawCommand)
  if source == 0 then
    print('prrp_rpchat: you can\'t use this command from rcon!')
    return
  end

  args = table.concat(args, ' ')
  local xPlayer = ESX.GetPlayerFromId(source)
  if Config.EnableESXIdentity then name = xPlayer.getName() end

  TriggerClientEvent('prrp_rpchat:sendWhisper', -1, source, name, args, {30, 144, 255});
end)

RegisterCommand('whisper', function(source, args, rawCommand)
  if source == 0 then
    print('prrp_rpchat: you can\'t use this command from rcon!')
    return
  end

  args = table.concat(args, ' ')
  local xPlayer = ESX.GetPlayerFromId(source)
  if Config.EnableESXIdentity then name = xPlayer.getName() end

  TriggerClientEvent('prrp_rpchat:sendWhisper', -1, source, name, args, {30, 144, 255});
end)

-- Car Whisper command
RegisterCommand('cw', function(source, args, rawCommand)
  if source == 0 then
    print('prrp_rpchat: you can\'t use this command from rcon!')
    return
  end

  args = table.concat(args, ' ')
  local xPlayer = ESX.GetPlayerFromId(source)
  if Config.EnableESXIdentity then name = xPlayer.getName() end

  TriggerClientEvent('prrp_rpchat:sendCarWhisper', -1, source, name, args, {30, 144, 255});
end)

-- Shout command
RegisterCommand('s', function(source, args, rawCommand)
  if source == 0 then
    print('prrp_rpchat: you can\'t use this command from rcon!')
    return
  end

  args = table.concat(args, ' ')
  local xPlayer = ESX.GetPlayerFromId(source)
  if Config.EnableESXIdentity then name = xPlayer.getName() end

  TriggerClientEvent('prrp_rpchat:sendShout', -1, source, name, args, {30, 144, 255});
end)

RegisterCommand('shout', function(source, args, rawCommand)
  if source == 0 then
    print('prrp_rpchat: you can\'t use this command from rcon!')
    return
  end

  args = table.concat(args, ' ')
  local xPlayer = ESX.GetPlayerFromId(source)
  if Config.EnableESXIdentity then name = xPlayer.getName() end

  TriggerClientEvent('prrp_rpchat:sendShout', -1, source, name, args, {30, 144, 255});
end)

-- OOC command
RegisterCommand('b', function(source, args, rawCommand)
  if source == 0 then
    print('prrp_rpchat: you can\'t use this command from rcon!')
    return
  end

  args = table.concat(args, ' ')
  local xPlayer = ESX.GetPlayerFromId(source)
  local identifier = GetPlayerIdentifiers(source)[1]
  local currentTime = os.time()
  local coords = GetEntityCoords(GetPlayerPed(source))
  if Config.EnableESXIdentity then name = "[" ..source.. "] " ..xPlayer.getName() end

  TriggerClientEvent('prrp_rpchat:sendLocalOOC', -1, source, name, args, {30, 144, 255});
end)

-- Car OOC command
RegisterCommand('cb', function(source, args, rawCommand)
  if source == 0 then
    print('prrp_rpchat: you can\'t use this command from rcon!')
    return
  end

  args = table.concat(args, ' ')
  local xPlayer = ESX.GetPlayerFromId(source)
  if Config.EnableESXIdentity then name = "[" ..source.. "] " ..xPlayer.getName() end

  TriggerClientEvent('prrp_rpchat:sendCarOOC', -1, source, name, args, {30, 144, 255});
end)

-- Flipcoin command
RegisterCommand('flipcoin', function(source, args, rawCommand)
  if source == 0 then
    print('prrp_rpchat: you can\'t use this command from rcon!')
    return
  end

  side = CoinSide()
  local xPlayer = ESX.GetPlayerFromId(source)
  if Config.EnableESXIdentity then name = xPlayer.getName() end

  TriggerClientEvent('prrp_rpchat:flipcoin', -1, source, name, side)
end)

-- Dice command
RegisterCommand('dice', function(source, args, rawCommand)
  if source == 0 then
    print('prrp_rpchat: you can\'t use this command from rcon!')
    return
  end

  numbers = math.random(1, 6)
  local xPlayer = ESX.GetPlayerFromId(source)
  if Config.EnableESXIdentity then name = xPlayer.getName() end

  TriggerClientEvent('prrp_rpchat:dice', -1, source, name, numbers)
  TriggerClientEvent('prrp_rpchat:diceanim', source)
end)

RegisterServerEvent('3dme:sceneDisplay')
AddEventHandler('3dme:sceneDisplay', function(sceneText)
	TriggerClientEvent('3dme:sceneTriggerDisplay', -1, sceneText, source)
end)

AddEventHandler('chatMessage', function(playerId, playerName, message)
	if string.sub(message, 1, string.len('/')) ~= '/' then
		CancelEvent()

		local xPlayer = ESX.GetPlayerFromId(playerId)
		if xPlayer then playerName = xPlayer.getName() end

        local output = ('[Local] %s: %s'):format(playerName, message)
		print(output)
		
		if playerId ~= nil then
			local coords = GetEntityCoords(GetPlayerPed(playerId))
			TriggerClientEvent('cmd:b', -1, playerId, playerName, message, coords)
		end
	end
end)

Sides = {
  'Heads',
  'Tails'
}

function CoinSide()
  return Sides[math.random(#Sides)]
end

AddEventHandler('chatMessage', function(source, n, message)
  local args = stringsplit(message, ' ')
  if (args[1] == "/showid") then
      local first = table.remove(args, 2)
      local last = table.remove(args, 2)

      if (first ~= nil and last ~= nil) then
          TriggerClientEvent('chatMessage', -1, 'ID', {0, 0, 0}, '('..n..') First: '..first..' Last: '..last)
      end

      CancelEvent()
 end
end)

function getNumberPhone(identifier)
  local result = MySQL.Sync.fetchAll("SELECT phone_number FROM gksphone_settings WHERE identifier = @identifier", {
      ['@identifier'] = identifier
  })
  if result[1] ~= nil then
      return result[1].phone_number
  end
  return nil
end

function stringsplit(inputstr, sep)
  if sep == nil then
      sep = "%s"
  end
  local t={} ; i=1
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
      t[i] = str
      i = i + 1
  end
  return t
end

local function onMeCommand(source, args)
  local xPlayer = ESX.GetPlayerFromId(source)
  local text = "* " .. xPlayer.getName() .. ' ' .. table.concat(args, " ")
  TriggerClientEvent('3dme:shareDisplayAme', -1, text, source)
  TriggerClientEvent('chat:addMessage', source, {
      --template = '<div style="color: rgba(194, 162, 218, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; "><b>> {0} {1}</b></div>',
      template = '<div style="color: rgba(194, 162, 218, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; ">> {0} {1}</div>',
      args = { xPlayer.getName(), table.concat(args, " ") }
  })
end

local function onMyCommand(source, args)
  local xPlayer = ESX.GetPlayerFromId(source)
  local text = "* " .. xPlayer.getName() .. '\'s ' .. table.concat(args, " ")
  TriggerClientEvent('3dme:shareDisplayAme', -1, text, source)
  TriggerClientEvent('chat:addMessage', source, {
      --template = '<div style="color: rgba(194, 162, 218, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; "><b>> {0}\'s {1}</b></div>',
      template = '<div style="color: rgba(194, 162, 218, 1); width: fit-content; max-width: 100%; overflow: hidden; word-break: break-word; ">> {0}\'s {1}</div>',
      args = { xPlayer.getName(), table.concat(args, " ") }
  })
end

RegisterCommand('ame', onMeCommand)

RegisterCommand('amy', onMyCommand)
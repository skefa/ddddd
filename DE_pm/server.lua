ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('pm', function(source, args)
     local id = tonumber(args[1])
     local xPlayer = ESX.GetPlayerFromId(source)
     local xTarget = ESX.GetPlayerFromId(args[1])
     local sendername = xPlayer.getName()
     local receiver = xTarget.getName()
     local msg = table.concat(args, " ")	 
     msg = string.gsub(msg, id, '')
	if xTarget.getGroup() == 'admin' or xTarget.getGroup() == 'superadmin' then id = nil
		TriggerClientEvent('dlrms_notify', source, 'error', 'You cannot PM admins.')
		return
	end
	
	if xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'superadmin' then sendername = GetPlayerName(source) end
	
     if id ~= nil and msg ~= nil then
        if GetPlayerName(id) ~= GetPlayerName(source) then
            if GetPlayerName(id) ~= nil then 
            TriggerClientEvent('chat:addMessage', source, {
                template = '<div style="color: rgba(252, 245, 69, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 200%; overflow: hidden; word-break: break-word; "> (( '.._U('pm_send')..' {1} (ID: {0}): {2} )) <br></div>',
                args = { id, receiver, msg }
            })
            TriggerClientEvent('chat:addMessage', id, {
                template = '<div style="color: rgba(252, 245, 69, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 200%; overflow: hidden; word-break: break-word; "> (( '.._U('pm_receive')..' {1} (ID: {0}): {2} )) <br></div>',
                args = { source, sendername, msg }
            })
			if xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'superadmin' then
				TriggerClientEvent('dlrms_notify', id, 'inform', 'You have received a PM from an admin, use /pma to respond.')
			end
            if Config.Logging then
            local headers = {
				['Content-Type'] = 'application/json'
			  }
			  local data = {
				["username"] = 'Private Message',
				["embeds"] = {{
				  ["color"] = 1752220,
				  ["timestamp"] = dateNow,
				  ['description'] = '('..GetPlayerName(source).. ' - '..GetPlayerIdentifier(source)..')\n'.._U('pm_sent_to')..':\n('..GetPlayerName(tonumber(args[1])).. ' - '..GetPlayerIdentifier(tonumber(args[1]))..')\n*'.._U('message')..':*\n***' ..msg.. '***'
				}}
			  }
              PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)	
            end
            else
              TriggerClientEvent('dlrms_notify', source, 'error', 'Wrong ID')
            end
        else
            TriggerClientEvent('dlrms_notify', source, 'error', 'You cannot PM yourself')
         end
     else
        TriggerClientEvent('dlrms_notify', source, 'error', 'Invalid message')
     end
end)
 
RegisterCommand('pma', function(source, args)
     local id = tonumber(args[1])
     local xPlayer = ESX.GetPlayerFromId(source)
     local xTarget = ESX.GetPlayerFromId(id)
     local sendername = xPlayer.getName()
     local receiver = xTarget.getName()
     local msg = table.concat(args, " ")	 
     msg = string.gsub(msg, id, '')
     
	if xTarget.getGroup() == 'admin' or xTarget.getGroup() == 'superadmin' then receiver = GetPlayerName(id) end
	
	if xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'superadmin' then sendername = GetPlayerName(source) end
	
     if id ~= nil and msg ~= nil then
        if GetPlayerName(id) ~= GetPlayerName(source) then
            if GetPlayerName(id) ~= nil then 
            TriggerClientEvent('chat:addMessage', source, {
                template = '<div style="color: rgba(252, 245, 69, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 200%; overflow: hidden; word-break: break-word; "> (( '.._U('pm_send')..' {1} (ID: {0}): {2} )) <br></div>',
                args = { id, receiver, msg }
            })
            TriggerClientEvent('chat:addMessage', id, {
                template = '<div style="color: rgba(252, 245, 69, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 200%; overflow: hidden; word-break: break-word; "> (( '.._U('pm_receive')..' {1} (ID: {0}): {2} )) <br></div>',
                args = { source, sendername, msg }
            })
			if xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'superadmin' then
				TriggerClientEvent('dlrms_notify', id, 'inform', 'You have received a PM from an admin, use /pma to respond.')
			end
            if Config.Logging then
            local headers = {
				['Content-Type'] = 'application/json'
			  }
			  local data = {
				["username"] = 'Private Message',
				["embeds"] = {{
				  ["color"] = 1752220,
				  ["timestamp"] = dateNow,
				  ['description'] = '('..GetPlayerName(source).. ' - '..GetPlayerIdentifier(source)..')\n'.._U('pm_sent_to')..':\n('..GetPlayerName(tonumber(args[1])).. ' - '..GetPlayerIdentifier(tonumber(args[1]))..')\n*'.._U('message')..':*\n***' ..msg.. '***'
				}}
			  }
              PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)	
            end
            else
              TriggerClientEvent('dlrms_notify', source, 'error', 'Wrong ID')
          end
        else
            TriggerClientEvent('dlrms_notify', source, 'error', 'You cannot PM yourself')
        end
     else
       TriggerClientEvent('dlrms_notify', source, 'error', 'Invalid message')
     end
end)
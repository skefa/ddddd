ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- report
RegisterCommand('report',function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)

	for _, playerId in ipairs(GetPlayers()) do
		local xPlayers = ESX.GetPlayerFromId(playerId)
		if xPlayers.getGroup() == 'admin' or xPlayers.getGroup() == 'leadadmin' or xPlayers.getGroup() == 'management' then
			TriggerClientEvent('chat:addMessage', playerId, {
				--template = '<div style="color: rgba(255, 99, 71, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> {0} | {1}</div>',
				template = '<div style="color: rgba(255, 99, 71, 1); width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> {0} | {1}</div>',
				args = {"REPORT", " [" .. GetPlayerName(source) .. " | " .. source .. "] : " .. table.concat(args, " ")}
			})
		end
	end
	TriggerClientEvent('chat:addMessage', source, {
		--template = '<div style="color: rgba(255, 99, 71, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> SERVER: Your report was sent to all administrators online.</div>',
		template = '<div style="color: rgba(255, 99, 71, 1); width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> SERVER: Your report was sent to all administrators online.</div>',
		args = {}
	})
end)
-- helpme
RegisterCommand('helpme',function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)

	for _, playerId in ipairs(GetPlayers()) do
		local xPlayers = ESX.GetPlayerFromId(playerId)
		if xPlayers.getGroup() == 'tester' or xPlayers.getGroup() == 'mod' or xPlayers.getGroup() == 'admin' or xPlayers.getGroup() == 'leadadmin' or xPlayers.getGroup() == 'management' then
			TriggerClientEvent('chat:addMessage', playerId, {
				--template = '<div style="color: rgba(255, 99, 71, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> {0} | {1}</div>',
				template = '<div style="color: rgba(255, 99, 71, 1); width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> {0} | {1}</div>',
				args = {"HELP", " [" .. GetPlayerName(source) .. " | " .. source .. "] : " .. table.concat(args, " ")}
			})
		end
	end
	TriggerClientEvent('chat:addMessage', source, {
		--template = '<div style="color: rgba(51, 170, 51, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> Request successfully sent to on-duty testers! </div>',
		template = '<div style="color: rgba(51, 170, 51, 1); width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> Request successfully sent to on-duty testers! </div>',
		args = {}
	})
end)
RegisterCommand('acceptreport', function(source, args, rawCommand)
	local target = tonumber(args[1])
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getGroup() == 'admin' then
		adminname = 'Game Administrator ' .. GetPlayerName(source)
	end
	if xPlayer.getGroup() == 'leadadmin' then
		adminname = 'Lead Administrator ' .. GetPlayerName(source)
	end
	if xPlayer.getGroup() == 'management' then
		adminname = 'Management ' .. GetPlayerName(source)
	end

	if xPlayer.getGroup() == 'user' or xPlayer.getGroup() == 'tester' or xPlayer.getGroup() == 'mod' then
		TriggerClientEvent('dlrms_notify', source, 'error', 'You don\'t have access to this')
	else
		TriggerClientEvent('chat:addMessage', target, {
			--template = '<div style="color: rgba(255, 99, 71, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> {0} has accepted your report.</div>',
			template = '<div style="color: rgba(255, 99, 71, 1); width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> {0} has accepted your report.</div>',
			args = { adminname }
		})
	
		for _, playerId in ipairs(GetPlayers()) do
			local xPlayers = ESX.GetPlayerFromId(playerId)
			if xPlayers.getGroup() == 'admin' or xPlayers.getGroup() == 'leadadmin' or xPlayers.getGroup() == 'management' then
				TriggerClientEvent('chat:addMessage', playerId, {
					--template = '<div style="color: rgba(255, 99, 71, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> {0} has accepted a report from {1}.</div>',
					template = '<div style="color: rgba(255, 99, 71, 1); width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> {0} has accepted a report from {1}.</div>',
					args = { adminname, GetPlayerName(target) }
				})
			end
		end
	end
end)
RegisterCommand('acceptrequest', function(source, args, rawCommand)
	local target = tonumber(args[1])
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getGroup() == 'tester' then
		adminname = 'Tester ' .. GetPlayerName(source)
	end
	if xPlayer.getGroup() == 'mod' then
		adminname = 'Moderator ' .. GetPlayerName(source)
	end
	if xPlayer.getGroup() == 'admin' then
		adminname = 'Game Administrator ' .. GetPlayerName(source)
	end
	if xPlayer.getGroup() == 'leadadmin' then
		adminname = 'Lead Administrator ' .. GetPlayerName(source)
	end
	if xPlayer.getGroup() == 'management' then
		adminname = 'Management ' .. GetPlayerName(source)
	end

	if xPlayer.getGroup() == 'user' then
		TriggerClientEvent('dlrms_notify', source, 'error', 'You don\'t have access to this')
	else
		TriggerClientEvent('chat:addMessage', target, {
			--template = '<div style="color: rgba(255, 99, 71, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> {0} has accepted your request.</div>',
			template = '<div style="color: rgba(255, 99, 71, 1); width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> {0} has accepted your request.</div>',
			args = { adminname }
		})

		for _, playerId in ipairs(GetPlayers()) do
			local xPlayers = ESX.GetPlayerFromId(playerId)
			if xPlayers.getGroup() == 'tester' or xPlayers.getGroup() == 'mod' or xPlayers.getGroup() == 'admin' or xPlayers.getGroup() == 'leadadmin' or xPlayers.getGroup() == 'management' then
				TriggerClientEvent('chat:addMessage', playerId, {
					--template = '<div style="color: rgba(255, 99, 71, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> {0} has accepted a request from {1}.</div>',
					template = '<div style="color: rgba(255, 99, 71, 1); width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> {0} has accepted a request from {1}.</div>',
					args = { adminname, GetPlayerName(target) }
				})
			end
		end
	end
end)
-- dv
RegisterCommand('dv',function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'user' or xPlayer.getGroup() == 'tester' or xPlayer.getGroup() == 'mod' then
		TriggerClientEvent('dlrms_notify', source, 'error', 'You don\'t have access to this')
	elseif xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'leadadmin' or xPlayer.getGroup() == 'management' then
		TriggerClientEvent('prrp_admin:dv', source)
	end
end)
-- dvall
RegisterCommand('dvall',function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'user' or xPlayer.getGroup() == 'tester' or xPlayer.getGroup() == 'mod' then
		TriggerClientEvent('dlrms_notify', source, 'error', 'You don\'t have access to this')
	else
		TriggerClientEvent('prrp_admin:dvall', -1)

		for _, playerId in ipairs(GetPlayers()) do
			local xPlayers = ESX.GetPlayerFromId(playerId)
			if xPlayers.getGroup() == 'admin' or xPlayers.getGroup() == 'leadadmin' or xPlayers.getGroup() == 'management' then
				TriggerClientEvent('chat:addMessage', playerId, {
					--template = '<div style="color: rgba(255, 99, 71, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: {0} has deleted all vehicles</div>',
					template = '<div style="color: rgba(255, 99, 71, 1); width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: {0} has deleted all vehicles</div>',
					args = { GetPlayerName(source) }
				})
			end
		end
	end
end)
-- clearmap
RegisterCommand('clearmap',function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'user' or xPlayer.getGroup() == 'tester' or xPlayer.getGroup() == 'mod' then
		TriggerClientEvent('dlrms_notify', source, 'error', 'You don\'t have access to this')
	else
		TriggerClientEvent('prrp_admin:clearmap', -1)

		for _, playerId in ipairs(GetPlayers()) do
			local xPlayers = ESX.GetPlayerFromId(playerId)
			if xPlayers.getGroup() == 'admin' or xPlayers.getGroup() == 'leadadmin' or xPlayers.getGroup() == 'management' then
				TriggerClientEvent('chat:addMessage', playerId, {
					--template = '<div style="color: rgba(255, 99, 71, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: {0} has cleared the map</div>',
					template = '<div style="color: rgba(255, 99, 71, 1); width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: {0} has cleared the map</div>',
					args = { GetPlayerName(source) }
				})
			end
		end
	end
end)
-- freeze
RegisterCommand('freeze',function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerId = args[1]
	if xPlayer.getGroup() == 'user' or xPlayer.getGroup() == 'tester' or xPlayer.getGroup() == 'mod' then
		TriggerClientEvent('dlrms_notify', source, 'error', 'You don\'t have access to this')
	elseif xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'leadadmin' or xPlayer.getGroup() == 'management' then
		TriggerClientEvent('prrp_admin:freeze', playerId)
		TriggerClientEvent('chat:addMessage', playerId, {
			--template = '<div style="color: rgba(255, 99, 71, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: You have been frozen by {0}</div>',
			template = '<div style="color: rgba(255, 99, 71, 1); width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: You have been frozen by {0}</div>',
			args = { GetPlayerName(source) }
		})
		TriggerClientEvent('chat:addMessage', source, {
			--template = '<div style="color: rgba(255, 99, 71, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: You have frozen {0}</div>',
			template = '<div style="color: rgba(255, 99, 71, 1); width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: You have frozen {0}</div>',
			args = { GetPlayerName(playerId) }
		})
	end
end)
-- unfreeze
RegisterCommand('unfreeze',function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerId = args[1]
	if xPlayer.getGroup() == 'user' or xPlayer.getGroup() == 'tester' or xPlayer.getGroup() == 'mod' then
		TriggerClientEvent('dlrms_notify', source, 'error', 'You don\'t have access to this')
	elseif xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'leadadmin' or xPlayer.getGroup() == 'management' then
		TriggerClientEvent('prrp_admin:unfreeze', playerId)
		TriggerClientEvent('chat:addMessage', playerId, {
			--template = '<div style="color: rgba(255, 99, 71, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: You have been unfrozen by {0}</div>',
			template = '<div style="color: rgba(255, 99, 71, 1); width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: You have been unfrozen by {0}</div>',
			args = { GetPlayerName(source) }
		})
		TriggerClientEvent('chat:addMessage', source, {
			--template = '<div style="color: rgba(255, 99, 71, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: You have unfrozen {0}</div>',
			template = '<div style="color: rgba(255, 99, 71, 1); width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: You have unfrozen {0}</div>',
			args = { GetPlayerName(playerId) }
		})
	end
end)
-- slay
RegisterCommand('slay',function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerId = args[1]
	if xPlayer.getGroup() == 'user' or xPlayer.getGroup() == 'tester' or xPlayer.getGroup() == 'mod' then
		TriggerClientEvent('dlrms_notify', source, 'error', 'You don\'t have access to this')
	elseif xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'leadadmin' or xPlayer.getGroup() == 'management' then
		TriggerClientEvent('prrp_admin:slay', playerId)
		TriggerClientEvent('chat:addMessage', playerId, {
			--template = '<div style="color: rgba(255, 99, 71, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: You have been slain by {0}</div>',
			template = '<div style="color: rgba(255, 99, 71, 1); width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: You have been slain by {0}</div>',
			args = { GetPlayerName(source) }
		})
		TriggerClientEvent('chat:addMessage', source, {
			--template = '<div style="color: rgba(255, 99, 71, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: You have slain {0}</div>',
			template = '<div style="color: rgba(255, 99, 71, 1); width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: You have slain {0}</div>',
			args = { GetPlayerName(playerId) }
		})
	end
end)
-- invisible
RegisterCommand('invisible', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'leadadmin' or xPlayer.getGroup() == 'management' then
		TriggerClientEvent('prrp_admin:toggleInvisibility', source)
	else
		TriggerClientEvent('dlrms_notify', source, 'error', 'You don\'t have access to this')
	end
end)
-- bring
RegisterCommand('bring',function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerId = args[1]
	local coords = GetEntityCoords(GetPlayerPed(source))
	if xPlayer.getGroup() == 'user' or xPlayer.getGroup() == 'tester' or xPlayer.getGroup() == 'mod' then
		TriggerClientEvent('dlrms_notify', source, 'error', 'You don\'t have access to this')
	elseif xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'leadadmin' or xPlayer.getGroup() == 'management' then
		SetEntityCoords(GetPlayerPed(playerId), coords.x, coords.y, coords.z + 0.5)
		TriggerClientEvent('chat:addMessage', playerId, {
			--template = '<div style="color: rgba(255, 99, 71, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: You have been brought by {0}</div>',
			template = '<div style="color: rgba(255, 99, 71, 1); width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: You have been brought by {0}</div>',
			args = { GetPlayerName(source) }
		})
		TriggerClientEvent('chat:addMessage', source, {
			--template = '<div style="color: rgba(255, 99, 71, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: You have brought {0}</div>',
			template = '<div style="color: rgba(255, 99, 71, 1); width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: You have brought {0}</div>',
			args = { GetPlayerName(playerId) }
		})
	end
end)
-- goto
RegisterCommand('goto',function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerId = args[1]
	local coords = GetEntityCoords(GetPlayerPed(playerId))
	if xPlayer.getGroup() == 'user' or xPlayer.getGroup() == 'tester' or xPlayer.getGroup() == 'mod' then
		TriggerClientEvent('dlrms_notify', source, 'error', 'You don\'t have access to this')
	elseif xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'leadadmin' or xPlayer.getGroup() == 'management' then
		SetEntityCoords(GetPlayerPed(source), coords.x, coords.y, coords.z + 0.5)
		TriggerClientEvent('chat:addMessage', playerId, {
			--template = '<div style="color: rgba(255, 99, 71, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: You have been teleported to by {0}</div>',
			template = '<div style="color: rgba(255, 99, 71, 1); width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: You have been teleported to by {0}</div>',
			args = { GetPlayerName(source) }
		})
		TriggerClientEvent('chat:addMessage', source, {
			--template = '<div style="color: rgba(255, 99, 71, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: You have teleported to {0}</div>',
			template = '<div style="color: rgba(255, 99, 71, 1); width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: You have teleported to {0}</div>',
			args = { GetPlayerName(playerId) }
		})
	end
end)
-- kick
RegisterCommand('kick',function(source, args, rawCommand)
	local playerId = args[1]
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(playerId)
	local TargetName = xTarget.getName()
	
	local reason = args
	table.remove(reason, 1)
	if(#reason == 0) then
		reason = "You have been kicked from the server"
	else
		reason = "" .. table.concat(reason, " ")
	end

	if xPlayer.getGroup() == 'user' or xPlayer.getGroup() == 'tester' then
		TriggerClientEvent('dlrms_notify', source, 'error', 'You don\'t have access to this')
	elseif xPlayer.getGroup() == 'mod' or xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'leadadmin' or xPlayer.getGroup() == 'management' then
		DropPlayer(playerId, reason)
		TriggerClientEvent('chat:addMessage', -1, {
			--template = '<div style="color: rgba(255, 99, 71, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: {0} was kicked by {1}, Reason: {2}</div>',
			template = '<div style="color: rgba(255, 99, 71, 1); width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> AdmCmd: {0} was kicked by {1}, Reason: {2}</div>',
			args = { TargetName, GetPlayerName(source), reason }
		})
	end
end)

RegisterCommand('announce', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'leadadmin' or xPlayer.getGroup() == 'management' then
		TriggerClientEvent('chat:addMessage', -1, {
			--template = '<div style="color: rgba(255, 99, 71, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 75%; overflow: hidden; word-break: break-word; "> {0}: {1}</div>',
			template = '<div style="color: rgba(255, 99, 71, 1); width: fit-content; max-width: 120%; overflow: hidden; word-break: break-word; "> {0}: {1}</div>',
			args = {"SERVER", table.concat(args, " ")}
		})
	else
		TriggerClientEvent('dlrms_notify', source, 'error', 'You don\'t have have access to this')
	end
end)
-- Staff Chat
RegisterCommand('sc',function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	local PlayerName = xPlayer.getName()
	local args = table.concat(args, " ")

	if xPlayer.getGroup() == 'tester' then PlayerName = 'Tester ' .. xPlayer.getName() end
	if xPlayer.getGroup() == 'mod' then PlayerName = 'Moderator ' .. xPlayer.getName() end
	if xPlayer.getGroup() == 'admin' then PlayerName = 'Game Administrator ' .. xPlayer.getName() end
	if xPlayer.getGroup() == 'leadadmin' then PlayerName = 'Lead Administrator ' .. xPlayer.getName() end
	if xPlayer.getGroup() == 'management' then PlayerName = 'Management ' .. xPlayer.getName() end

	if xPlayer.getGroup() == 'user' then
		TriggerClientEvent('dlrms_notify', source, 'error', 'You don\'t have access to this')
	else
		for _, playerId in ipairs(GetPlayers()) do
			local xPlayers = ESX.GetPlayerFromId(playerId)
			if xPlayers.getGroup() == 'tester' or xPlayers.getGroup() == 'mod' or xPlayers.getGroup() == 'admin' or xPlayers.getGroup() == 'leadadmin' or xPlayers.getGroup() == 'management' then
				TriggerClientEvent('chat:addMessage', playerId, {
					--template = '<div style="color: rgba(252, 245, 69, 1); font-family: arial; font-weight: bold; text-shadow: 0px 0px 3px #000000; width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> {0} ({1}): {2}</div>',
					template = '<div style="color: rgba(252, 245, 69, 1); width: fit-content; max-width: 125%; overflow: hidden; word-break: break-word; "> {0} ({1}): {2}</div>',
					args = { PlayerName, GetPlayerName(source), args }
				})
			end
		end
	end
end)

RegisterCommand('forceskin', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	local id = args[1]

	if xPlayer.getGroup() == 'user' or xPlayer.getGroup() == 'tester' or xPlayer.getGroup() == 'mod' then
		TriggerClientEvent('dlrms_notify', source, 'error', 'You don\'t have access to this')
	else
		TriggerClientEvent('esx_skin:openSaveableMenu', id)
	end
end)

RegisterCommand('changeplayername', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(args[1])
	local firstname = args[2]
	local lastname = args[3]

	if xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'leadadmin' or xPlayer.getGroup() == 'management' then 
		if xTarget ~= nil then
			if checkNameFormat(firstname) and checkNameFormat(lastname) then
				updateName(xTarget.source, xTarget.identifier, formatName(firstname), formatName(lastname))
			else
				TriggerClientEvent('dlrms_notify', source, 'error', 'There was an error changing your name.', 2500)
			end
		else
			TriggerClientEvent('dlrms_notify', source, 'error', 'Incorrect Player ID.', 2500)
		end
	else
		TriggerClientEvent('dlrms_notify', source, 'error', 'You don\'t have access to this')
	end
end)

function checkNameFormat(name)
    if not checkAlphanumeric(name) and not checkForNumbers(name) then
        local stringLength = name:len();
        if stringLength > 0 and stringLength < 25 then
            return true
        end
    end
    return false
end

function formatName(name)
	local loweredName = convertToLowerCase(name)
	local formattedName = convertFirstLetterToUpper(loweredName)
	return formattedName
end

function convertToLowerCase(str)
	return string.lower(str)
end

function convertFirstLetterToUpper(str)
	return str:gsub("^%l", string.upper)
end

function checkAlphanumeric(str)
	return (string.match(str, "%W"))
end

function checkForNumbers(str)
	return (string.match(str,"%d"))
end

function updateName(source, identifier, firstname, lastname)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET firstname = @firstname, lastname = @lastname WHERE identifier = @identifier', { ['@identifier'] = identifier, ['@firstname'] = firstname, ['@lastname'] = lastname }, function(rowsChanged)
		if rowsChanged > 0 then
			xPlayer.kick('✔️ You were kicked from the server due to your namechange being processed.')
		else
			print(('[^3PRRP-Namechange^7]:^0 There was an error changing %s\'s character name.'):format(identifier))
			TriggerClientEvent('dlrms_notify', source, 'error', 'There was an error updating your character name.', 2500)
		end
	end)
end
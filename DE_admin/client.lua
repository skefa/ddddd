TriggerEvent('chat:addSuggestion', '/slay', 'Slay a player.', {{ name = 'id', help = 'Player ID.'}})
TriggerEvent('chat:addSuggestion', '/bring', 'Bring a player.', {{ name = 'id', help = 'Player ID.'}})
TriggerEvent('chat:addSuggestion', '/goto', 'Goto a player.', {{ name = 'id', help = 'Player ID.'}})
TriggerEvent('chat:addSuggestion', '/report', 'Send report to admins.', {{ name = 'info', help = 'Report information.'}})
TriggerEvent('chat:addSuggestion', '/helpme', 'Send request to testers.', {{ name = 'info', help = 'Request information.'}})
TriggerEvent('chat:addSuggestion', '/acceptreport', 'Accept a player report.', {{ name = 'id', help = 'Player ID.'}})
TriggerEvent('chat:addSuggestion', '/acceptrequest', 'Accept a player request.', {{ name = 'id', help = 'Player ID.'}})
TriggerEvent('chat:addSuggestion', '/dv', 'Delete a vehicle.')
TriggerEvent('chat:addSuggestion', '/dvall', 'Delete all vehicles.')
TriggerEvent('chat:addSuggestion', '/clearmap', 'Clear the map.')
TriggerEvent('chat:addSuggestion', '/freeze', 'Freeze a player.', {{ name = 'id', help = 'Player ID.'}})
TriggerEvent('chat:addSuggestion', '/unfreeze', 'Unfreeze a player.', {{ name = 'id', help = 'Player ID.'}})
TriggerEvent('chat:addSuggestion', '/kick', 'Kick a player.', {{ name = 'id', help = 'Player ID.'}, { name = 'reason', help = 'Kick reason.'}})
TriggerEvent('chat:addSuggestion', '/invisible', 'Go invisible.')
TriggerEvent('chat:addSuggestion', '/changeplayername', 'Change a player\'s name.', {{ name = 'id', help = 'Player ID.'}, { name = 'firstname', help = 'First name.'}, { name = 'lastname', help = 'Last name.'}})
TriggerEvent('chat:addSuggestion', '/forceskin', 'Force skin a player.', {{ name = 'id', help = 'Player ID.'}})

local invisibility = false

-- dv
RegisterNetEvent('prrp_admin:dv')
AddEventHandler('prrp_admin:dv', function()
	if IsPedSittingInAnyVehicle(PlayerPedId()) then
		local xveh = GetVehiclePedIsIn(PlayerPedId(), false)
		SetEntityAsMissionEntity(xveh, false, false)
		DeleteEntity(xveh)
	end
end)
-- freeze
RegisterNetEvent('prrp_admin:freeze')
AddEventHandler('prrp_admin:freeze', function()
	FreezeEntityPosition(PlayerPedId(), true)
end)
-- unfreeze
RegisterNetEvent('prrp_admin:unfreeze')
AddEventHandler('prrp_admin:unfreeze', function()
	FreezeEntityPosition(PlayerPedId(), false)
end)
-- slay
RegisterNetEvent('prrp_admin:slay')
AddEventHandler('prrp_admin:slay', function()
	ApplyDamageToPed(PlayerPedId(), 5000, false, true, true)
end)
-- invisible
RegisterNetEvent('prrp_admin:toggleInvisibility')
AddEventHandler('prrp_admin:toggleInvisibility', function()
  invisibility = not invisibility
  SetEntityVisible(GetPlayerPed(-1), not invisibility, 0)
  SetForcePedFootstepsTracks(invisibility) -- TODO: all players ?!
  if invisibility then
	exports['dlrms_notify']:SendAlert('info', 'Invisibility activated.')
  else
    exports['dlrms_notify']:SendAlert('info', 'Invisibility deactivated.')
  end
end)
-- Goto/Bring
RegisterNetEvent('prrp_admin:teleportUser')
AddEventHandler('prrp_admin:teleportUser', function(x, y, z)
	SetEntityCoords(PlayerPedId(), x, y, z)
	states.frozenPos = {x = x, y = y, z = z}
end)
-- dvall & clearmap
RegisterNetEvent('prrp_admin:dvall')
AddEventHandler('prrp_admin:dvall', function()
	for xveh in EnumerateVehicles() do
		if not IsPedAPlayer(GetPedInVehicleSeat(xveh, -1)) then 
			SetEntityAsMissionEntity(xveh, false, false)
			DeleteEntity(xveh)
		end
	end
end)
RegisterNetEvent('prrp_admin:clearmap')
AddEventHandler('prrp_admin:clearmap', function()
	for xveh in EnumerateVehicles() do
		SetEntityAsMissionEntity(xveh, false, false)
		DeleteEntity(xveh)
	end
	for xobj in EnumeratePickups() do
		RemovePickup(xobj)
		SetEntityAsMissionEntity(xobj, false, false)
		DeleteEntity(xobj)
	end
	for xped in EnumeratePeds() do
		if not IsPedAPlayer(xped) then	
			SetEntityAsMissionEntity(xped, false, false)
			DeleteEntity(xped)
		end
	end
	for xobj in EnumerateObjects() do
		if NetworkGetEntityOwner(xobj) ~= -1 then
			DetachEntity(xobj, true, true)
			SetEntityAsMissionEntity(xobj, false, false)
			DeleteEntity(xobj)
		end
	end
	local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	ClearAreaOfObjects(x, y, z, 300.0, 1)
	ClearAreaOfCops(x, y, z, 300.0, 1)
	ClearAreaOfPeds(x, y, z, 300.0, 1)
	ClearAreaOfProjectiles(x, y, z, 300.0, 1)
	ClearAreaOfVehicles(x, y, z, 300.0, false, false, false, false, false)
end)
local entityEnumerator = {
	__gc = function(enum)
	    if enum.destructor and enum.handle then
		    enum.destructor(enum.handle)
	    end
	    enum.destructor = nil
	    enum.handle = nil
	end
}
local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
	    local iter, id = initFunc()
	    if not id or id == 0 then
	        disposeFunc(iter)
		    return
	    end  
	    local enum = {handle = iter, destructor = disposeFunc}
	    setmetatable(enum, entityEnumerator) 
	    local next = true
	    repeat
		    coroutine.yield(id)
		    next, id = moveFunc(iter)
	    until not next  
	    enum.destructor, enum.handle = nil, nil
	    disposeFunc(iter)
	end)
end
function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end
function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end
function EnumeratePickups()
	return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end
function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

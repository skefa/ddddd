RegisterNetEvent("dlrms_notify")
AddEventHandler("dlrms_notify", function(type, msg, use_sound, duration)
	SendAlert(type, msg, use_sound, duration)
end)

function SendAlert(type, msg, use_sound, duration)
	SendNUIMessage({ 
		notification = msg,
		notification_type = type,
		duration = duration,
		action_type = 'playSound',
		use_sound = use_sound,
	})
end
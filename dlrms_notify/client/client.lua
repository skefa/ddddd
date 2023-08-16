RegisterNetEvent("dlrms_notify")
AddEventHandler("dlrms_notify", function(type, msg, duration)
	SendNUIMessage({ 
		notification = msg,
		notification_type = type,
		duration = duration,
		transactionType = 'playSound',
	})
end)
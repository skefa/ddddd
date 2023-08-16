# Fivem Notification Script
Using for (Client-Side) :

```lua
TriggerEvent('dlrms_notify', 'type', 'Type_your_message_here', use_sound, duration)
```

Using for (Server-Side) :

```lua
TriggerClientEvent('dlrms_notify', source, 'type', 'Type_your_message_here', use_sound, duration)
```

Using Exports

```lua
exports['dlrms_notify']:SendAlert('type','Type_your_message_here', use_sound, duration)
```
## use_sound : true or false
## If no duration is given, will default to 3000ms

### Notification types
* Information - 'info'
* Error - 'error'
* Success - 'success'
* Warning - 'warn'

### Original Style
![Image of Notification](https://cdn.discordapp.com/attachments/850181379778150420/854773290257350686/Screenshot_34.png)

### Original Style Video
https://youtu.be/gfYHG7jNzAY

### Custom Style
![Image of Notification](https://cdn.discordapp.com/attachments/850181379778150420/854773606319259708/Screenshot_35.png)

### Custom Style Video
https://youtu.be/cVbuNmIiEdU

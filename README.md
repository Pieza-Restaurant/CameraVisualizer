## CamerShake


### API
___

```lua
    function CameraShake.init()
```
Initializes the CameraShake.

```lua
    function CameraShake:AddSound(Sound)
```

`Sound: Instance` The sound the camera will visualize.

```lua
    function CameraShake:Disconnect()
```
Disconnects the RunConnection.

```lua
    function CameraShake:Start()
```
Starts the sound visualizing

___

## Usage

```lua
    local Sound = workspace.Sound
    local CameraShake = require(path.to.CameraShake).init()
    
    CameraShake:AddSound(Sound)
    CameraShake:Start()
```





## CamerShake


### API
___

```lua
    function CameraVisualizer.init()
```
Initializes the CameraVisualizer.

```lua
    function CameraVisualizer:AddSound(Sound)
```

`Sound: Instance` The sound the camera will visualize.

```lua
    function CameraVisualizer:Disconnect()
```
Disconnects the RunConnection.

```lua
    function CameraVisualizer:Start()
```
Starts the sound visualizing

___

## Usage

```lua
    local Sound = workspace.Sound
    local CameraVisualizer = require(path.to.CameraVisualizer).init()
    
    CameraVisualizer:AddSound(Sound)
    CameraVisualizer:Start()
```





## CameraVisualizer


### API
___

```lua
    function CameraVisualizer.new()
```
Initializes the CameraVisualizer.

```lua
    function CameraVisualizer:LinkSound(Sound)
```

`Sound: Instance` The sound the camera will visualize.


## Usage

```lua
    local Sound = workspace.Sound
    local CameraVisualizer = require(path.to.CameraVisualizer).new()
    
    CameraVisualizer:LinkSound(Sound)
```





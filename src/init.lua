-- strict

-- init
-- @author: Dev_Cron, 15/05/2022

-- Services
local TweenService = game:GetService('TweenService')
local RunService = game:GetService("RunService")

--[=[
	Methods:
	Public void Module.new() => New module object 
	Public void CameraVisualizer:LinkSound(Sound: Sound | Model)
	Public Void CameraVisualizer:UnLinkSound()
	Public void CameraVisualizer:Destroy()

	Private function Playing()
]=]

local Module = {}

-- Creates a new module object
function Module.new()
	local CurrentCamera = workspace.CurrentCamera
	if not CurrentCamera then return end

	local CameraVisualizer = {
		TweenInfo = TweenInfo.new(0.10, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut) ,
		PlayingConnection = nil,
		BufferConnection = nil,
		Sound = nil,
	}

	local function Playing()
		if CameraVisualizer.BufferConnection then
			CameraVisualizer.BufferConnection:Disconnect()
			CameraVisualizer.BufferConnection = nil
		end

		local Sound = CameraVisualizer.Sound :: Sound
		if not Sound then return end

		local Properties 

		if Sound.Playing then
			CameraVisualizer.BufferConnection = RunService.RenderStepped:Connect(function()
				if (Sound.PlaybackLoudness/1000)>= 0.10 and CurrentCamera.FieldOfView < 74 then
					Properties = {FieldOfView = 68 + (Sound.PlaybackLoudness/100)}
				else
					Properties = {FieldOfView = 68 - (Sound.PlaybackLoudness/1000)}
				end
				

				local Tween = TweenService:Create(CurrentCamera, CameraVisualizer.TweenInfo, Properties)
				Tween:Play()
			end)
		end
	end
	
	-- Links up the sound
	function CameraVisualizer:LinkSound(Sound : Sound)
		-- Disconnect the old connection if there's 
		self:UnLinkSound()

		CameraVisualizer.Sound = Sound

		Playing()

		CameraVisualizer.PlayingConnection = Sound:GetPropertyChangedSignal("Playing"):Connect(Playing)
	end
	
	-- Cleans up the connections
	function CameraVisualizer:UnLinkSound()
		if CameraVisualizer.PlayingConnection then
			CameraVisualizer.PlayingConnection:Disconnect()
			CameraVisualizer.PlayingConnection = nil
		end

		if CameraVisualizer.BufferConnection then
			CameraVisualizer.BufferConnection:Disconnect()
			CameraVisualizer.BufferConnection = nil
		end

		CameraVisualizer.Sound = nil
	end

	function CameraVisualizer:Destroy()
		if CameraVisualizer.PlayingConnection then
			CameraVisualizer.PlayingConnection:Disconnect()
			CameraVisualizer.PlayingConnection = nil
		end

		if CameraVisualizer.BufferConnection then
			CameraVisualizer.BufferConnection:Disconnect()
			CameraVisualizer.BufferConnection = nil
		end

		CameraVisualizer.Sound = nil
	end

	return CameraVisualizer
end

return Module
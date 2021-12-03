
-- CameraVisualizer
-- @author: Dev_Cron

--[[
    Methods: 
        Public metadata CameraVisualizer.init()
        Public void CameraVisualizer:Disconnect()
        Public void CameraVisualizer:Start()
        Public void CameraVisualizer:AddSound(Sound: Sound)
        
        Private void CameraVisualizer:Play()
        Private void CameraVisualizer:RemoveSound()
]]--

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Info = TweenInfo.new(0.10, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut) 

local CameraVisualizer = {}
CameraVisualizer.__index = CameraVisualizer

function CameraVisualizer.init()
	print("CameraVisualizer initialized")

	return setmetatable({
		--> Instances
		Camera = workspace.CurrentCamera;
		Sound = nil;
		--> Connections
		RunConnection = nil;
	}, CameraVisualizer)
end

function CameraVisualizer:Play()
	local Properties 
	if (self.Sound.PlaybackLoudness/1000)>= 0.30 and self.Camera.FieldOfView < 74 then
		Properties = {FieldOfView = 68 + (self.Sound.PlaybackLoudness/100)}
	else
		Properties = {FieldOfView = 68 - (self.Sound.PlaybackLoudness/1000)}
	end
    
	local Tween = TweenService:Create(self.Camera, Info, Properties)
	Tween:Play()
end

function CameraVisualizer:Start()
	self:Disconnect()

	self.RunConnection =  RunService.RenderStepped:Connect(function()
		self:Play()
	end)
end

function CameraVisualizer:AddSound(Sound: Sound)
	assert(typeof(Sound) == 'Instance', "required argument")
	self:RemoveSound()
	
	if not Sound.IsPlaying then
		Sound.Playing = true
	end
	self.Sound = Sound
end

function CameraVisualizer:RemoveSound()
	self:Disconnect()

	self.Sound = nil
end

function CameraVisualizer:Disconnect()
	if self.RunConnection then
		self.RunConnection:Disconnect()
		self.RunConnection = nil
	end
end

return CameraVisualizer
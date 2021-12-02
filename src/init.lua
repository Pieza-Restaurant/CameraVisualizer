
-- CameraShake
-- @author: Dev_Cron

--[[
    Methods: 
        Public metadata CameraShake.init()
        Public void CameraShake:Disconnect()
        Public void CameraShake:Start()
        Public void CameraShake:AddSound(Sound: Sound)
        
        Private void CameraShake:Play()
        Private void CameraShake:RemoveSound()
]]--

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Info = TweenInfo.new(0.10, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut) 

local CameraShake = {}
CameraShake.__index = CameraShake

function CameraShake.init()
	print("CameraShake initialized")

	return setmetatable({
		--> Instances
		Camera = workspace.CurrentCamera;
		Sound = nil;
		--> Connections
		RunConnection = nil;
	}, CameraShake)
end

function CameraShake:Play()
	local Properties 
	if (self.Sound.PlaybackLoudness/1000)>= 0.30 and self.Camera.FieldOfView < 74 then
		Properties = {FieldOfView = 68 + (self.Sound.PlaybackLoudness/100)}
	else
		Properties = {FieldOfView = 68 - (self.Sound.PlaybackLoudness/1000)}
	end
    
	local Tween = TweenService:Create(self.Camera, Info, Properties)
	Tween:Play()
end

function CameraShake:Start()
	self:Disconnect()

	self.RunConnection =  RunService.RenderStepped:Connect(function()
		self:Play()
	end)
end

function CameraShake:AddSound(Sound: Sound)
	assert(typeof(Sound) == 'Instance', "required argument")
	self:RemoveSound()
	
	if not Sound.IsPlaying then
		Sound.Playing = true
	end
	self.Sound = Sound
end

function CameraShake:RemoveSound()
	self:Disconnect()

	self.Sound = nil
end

function CameraShake:Disconnect()
	if self.RunConnection then
		self.RunConnection:Disconnect()
		self.RunConnection = nil
	end
end

return CameraShake
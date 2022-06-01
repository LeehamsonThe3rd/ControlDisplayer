local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local ControlDisplayer = {}
ControlDisplayer.__index = ControlDisplayer

local ControlTemplate = script:WaitForChild("ControlTemplate")

local ControlDisplayerList = {}

local KeySingle = "rbxasset://textures/ui/Controls/key_single@3x.png"

local GamepadButtonImage = {
	[Enum.KeyCode.ButtonX] = "rbxasset://textures/ui/Controls/xboxX@3x.png",
	[Enum.KeyCode.ButtonY] = "rbxasset://textures/ui/Controls/xboxY@3x.png",
	[Enum.KeyCode.ButtonA] = "rbxasset://textures/ui/Controls/xboxA@3x.png",
	[Enum.KeyCode.ButtonB] = "rbxasset://textures/ui/Controls/xboxB@3x.png",
	[Enum.KeyCode.DPadLeft] = "rbxasset://textures/ui/Controls/dpadLeft@3x.png",
	[Enum.KeyCode.DPadRight] = "rbxasset://textures/ui/Controls/dpadRight@3x.png",
	[Enum.KeyCode.DPadUp] = "rbxasset://textures/ui/Controls/dpadUp@3x.png",
	[Enum.KeyCode.DPadDown] = "rbxasset://textures/ui/Controls/dpadDown@3x.png",
	[Enum.KeyCode.ButtonSelect] = "rbxasset://textures/ui/Controls/xboxmenu@3x.png",
	[Enum.KeyCode.ButtonL1] = "rbxasset://textures/ui/Controls/xboxLS@3x.png",
	[Enum.KeyCode.ButtonR1] = "rbxasset://textures/ui/Controls/xboxRS@3x.png",
	[Enum.KeyCode.ButtonL2] = "rbxasset://textures/ui/Controls/xboxLS@3x.png",
	[Enum.KeyCode.ButtonR2] = "rbxasset://textures/ui/Controls/xboxRS@3x.png",
	[Enum.KeyCode.ButtonL3] = "rbxasset://textures/ui/Controls/xboxLS@3x.png",
	[Enum.KeyCode.ButtonR3] = "rbxasset://textures/ui/Controls/xboxRS@3x.png",
}

local KeyboardButtonImage = {
	[Enum.KeyCode.Backspace] = "rbxasset://textures/ui/Controls/backspace@3x.png",
	[Enum.KeyCode.Return] = "rbxasset://textures/ui/Controls/return@3x.png",
	[Enum.KeyCode.LeftShift] = "rbxasset://textures/ui/Controls/shift@3x.png",
	[Enum.KeyCode.RightShift] = "rbxasset://textures/ui/Controls/shift@3x.png",
	[Enum.KeyCode.Tab] = "rbxasset://textures/ui/Controls/tab@3x.png",
}

local KeyCodeToTextMapping = {
	[Enum.KeyCode.LeftControl] = "Ctrl",
	[Enum.KeyCode.RightControl] = "Ctrl",
	[Enum.KeyCode.LeftAlt] = "Alt",
	[Enum.KeyCode.RightAlt] = "Alt",
	[Enum.KeyCode.F1] = "F1",
	[Enum.KeyCode.F2] = "F2",
	[Enum.KeyCode.F3] = "F3",
	[Enum.KeyCode.F4] = "F4",
	[Enum.KeyCode.F5] = "F5",
	[Enum.KeyCode.F6] = "F6",
	[Enum.KeyCode.F7] = "F7",
	[Enum.KeyCode.F8] = "F8",
	[Enum.KeyCode.F9] = "F9",
	[Enum.KeyCode.F10] = "F10",
	[Enum.KeyCode.F11] = "F11",
	[Enum.KeyCode.F12] = "F12",
}

function ControlDisplayer.new(KeyCode : Enum.KeyCode, Action : string)
	local self = {}
	
	self.Control = ControlTemplate:Clone()
	self.KeyCode = KeyCode
	self.Action = Action
	
	self.Control.Parent = Players.LocalPlayer.PlayerGui:WaitForChild("ControlList").ControlFrame
		
	if KeyCodeToTextMapping[self.KeyCode] then
		self.Control.Button.Image = KeySingle
		self.Control.Button.Key.Text = KeyCodeToTextMapping[self.KeyCode]
		self.Control.Button.ButtonIcon.Image = ""
	elseif KeyboardButtonImage[self.KeyCode] then
		self.Control.Button.Image = KeySingle
		self.Control.Button.Key.Text = ""
		self.Control.Button.ButtonIcon.Image = KeyboardButtonImage[self.KeyCode]
	elseif GamepadButtonImage[self.KeyCode] then
		self.Control.Button.Image = GamepadButtonImage[self.KeyCode]
		self.Control.Button.Key.Text = ""
		self.Control.Button.ButtonIcon.Image = ""
	else
		self.Control.Button.Image = KeySingle
		self.Control.Button.Key.Text = self.KeyCode.Name
		self.Control.Button.ButtonIcon.Image = ""
	end
	
	self.Control.Action.Text = Action
	
	setmetatable(self, ControlDisplayer)
	table.insert(ControlDisplayerList, self)
	return self
end

function ControlDisplayer:UpdateKey(KeyCode : Enum.KeyCode)
	assert(KeyCode, "No new key provided")
	
	self.KeyCode = KeyCode

	if KeyCodeToTextMapping[self.KeyCode] then
		self.Control.Button.Image = KeySingle
		self.Control.Button.Key.Text = KeyCodeToTextMapping[self.KeyCode]
		self.Control.Button.ButtonIcon.Image = ""
	elseif KeyboardButtonImage[self.KeyCode] then
		self.Control.Button.Image = KeySingle
		self.Control.Button.Key.Text = ""
		self.Control.Button.ButtonIcon.Image = KeyboardButtonImage[self.KeyCode]
	elseif GamepadButtonImage[self.KeyCode] then
		self.Control.Button.Image = GamepadButtonImage[self.KeyCode]
		self.Control.Button.Key.Text = ""
		self.Control.Button.ButtonIcon.Image = ""
	else
		self.Control.Button.Image = KeySingle
		self.Control.Button.Key.Text = self.KeyCode.Name
		self.Control.Button.ButtonIcon.Image = ""
	end
end

function ControlDisplayer:UpdateAction(Action : string)
	assert(Action, "No new action provided")
	
	self.Action = Action
	self.Control.Action.Text = Action
end

function ControlDisplayer:Destroy()
	for Index,ExistingControlDisplayer in pairs(ControlDisplayerList) do
		if ExistingControlDisplayer == self then
			table.remove(ControlDisplayerList, Index)
			print(ControlDisplayerList)
		end
	end
	
	self.Control:Destroy()
	self = nil
end

function InputBegan(Input)
	for _,ExistingControlDisplayer in pairs(ControlDisplayerList) do
		if ExistingControlDisplayer.KeyCode == Input.KeyCode then
			TweenService:Create(ExistingControlDisplayer.Control.Button, TweenInfo.new(0.1), {["ImageColor3"] = Color3.new(0.65, 0.65, 0.65)}):Play()
			TweenService:Create(ExistingControlDisplayer.Control.Button.ButtonIcon, TweenInfo.new(0.1), {["ImageColor3"] = Color3.new(0.65, 0.65, 0.65)}):Play()
			TweenService:Create(ExistingControlDisplayer.Control.Button.Key, TweenInfo.new(0.1), {["TextColor3"] = Color3.new(0.65, 0.65, 0.65)}):Play()
		end
	end
end

function InputEnded(Input)
	for _,ExistingControlDisplayer in pairs(ControlDisplayerList) do
		if ExistingControlDisplayer.KeyCode == Input.KeyCode then
			TweenService:Create(ExistingControlDisplayer.Control.Button, TweenInfo.new(0.1), {["ImageColor3"] = Color3.new(1,1,1)}):Play()
			TweenService:Create(ExistingControlDisplayer.Control.Button.ButtonIcon, TweenInfo.new(0.1), {["ImageColor3"] = Color3.new(1,1,1)}):Play()
			TweenService:Create(ExistingControlDisplayer.Control.Button.Key, TweenInfo.new(0.1), {["TextColor3"] = Color3.new(1,1,1)}):Play()
		end
	end
end

UserInputService.InputBegan:Connect(InputBegan)
UserInputService.InputEnded:Connect(InputEnded)

return ControlDisplayer

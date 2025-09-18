-- Module
local QuantumLib = {}
QuantumLib.__index = QuantumLib

-- Services
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local CoreGui = game.CoreGui
local StarterGui = game:GetService("StarterGui")

-- Values
local GuiName = tostring(math.random(326, 10000))..tostring(math.random(326, 10000)).."_hub"
local Keybind = Enum.KeyCode.Z

-- Player
local Player = Players.LocalPlayer

-- Initialization Functions
function QuantumLib.Create(HubName)
	local self = setmetatable({}, QuantumLib)

	for _, Gui in pairs(CoreGui:GetChildren()) do
		if Gui:IsA("ScreenGui") and string.find(Gui.Name, "_hub") then
			Gui:Destroy()
			
			self:Notify({
				Title = "Alert";
				Text = "Other menu has been unloaded.";
				Duration = 3
			})
		end
	end

	self.Gui = QuantumLib.ScreenGui()

	self.Main = QuantumLib.CanvasGroup({
		Name = "Main";
		BackgroundTransparency = 1;
		Position = UDim2.new(.5, 0, .5, 0);
		Size = UDim2.new(.381, 0, .364, 0)
	})
	self.MainRatio = QuantumLib.AspectRatio({
		AspectRatio = 1.695
	})

	self.Background = QuantumLib.Frame({
		Name = "Background";
		BackgroundTransparency = 0;
		BackgroundColor3 = Color3.fromRGB(20, 20, 20);
		Position = UDim2.new(.5, 0, .5, 0);
		Size = UDim2.new(.95, 0, .95, 0)
	})
	self.Title = QuantumLib.TextLabel({
		Name = "Title";
		BackgroundTransparency = 1;
		Position = UDim2.new(.5, 0, .093, 0);
		Size = UDim2.new(.406, 0, .086 ,0);
		Text = HubName

	})
	self.TitleOutline = QuantumLib.Frame({
		Name = "Outline";
		BackgroundTransparency = 0;
		BackgroundColor3 = Color3.fromRGB(255,255,255);
		Position = UDim2.new(.5, 0, 1.028, 0);
		Size = UDim2.new(1.048, 0, .056, 0)
	})
	self.BackgroundCorner = QuantumLib.Corner({
		CornerRadius = UDim.new(.125, 0)
	})

	self.Contents = QuantumLib.Frame({
		Name = "Contents";
		BackgroundTransparency = 0;
		BackgroundColor3 = Color3.fromRGB(30, 30, 30);
		Position = UDim2.new(.5, 0, .555, 0);
		Size = UDim2.new(.845, 0, .708, 0)
	})
	self.ContentsCorner = QuantumLib.Corner({
		CornerRadius = UDim.new(.125, 0)
	})

	self.Tabs = QuantumLib.ScrollingFrame({
		Name = "Tabs";
		BackgroundTransparency = 1;
		Position = UDim2.new(.199, 0, .497, 0);
		Size = UDim2.new(.332, 0, .913, 0)
	})
	self.TabList = QuantumLib.ListLayout({
		Padding = UDim.new(0, 10);
	})

	self.Exit = QuantumLib.TextButton({
		Name = "Exit";
		BackgroundTransparency = 1;
		BackgroundColor3 = Color3.fromRGB(0,0,0);
		Position = UDim2.new(.911, 0, .089, 0);
		Size = UDim2.new(.053, 0, .078, 0);
		Text = "X"
	})

	self.Gui.Parent = CoreGui
	self.Main.Parent = self.Gui
	self.MainRatio.Parent = self.Main
	self.Background.Parent = self.Main
	self.Title.Parent = self.Main
	self.TitleOutline.Parent = self.Title
	self.BackgroundCorner.Parent = self.Background
	self.Contents.Parent = self.Main
	self.ContentsCorner.Parent = self.Contents
	self.Tabs.Parent = self.Contents
	self.TabList.Parent = self.Tabs
	self.Exit.Parent = self.Main

	self.Disabled = true
	self.Cooldown = true
	self.Warned = false

	local Connection; Connection = self.Exit.Activated:Connect(function()
		if self.Warned then
			self:Destroy()
			self:Notify({
				Title = "Alert";
				Text = "Menu unloaded!";
				Duration = 3
			})
			
			Connection:Disconnect()
			Connection = nil
		else
			self.Warned = true
			self:Notify({
				Title = "Warning";
				Text = "Are you sure you want to unload?";
				Duration = 7
			})
		end
	end)

	UserInputService.InputBegan:Connect(function(Input, GameProcessedEvent)
		if GameProcessedEvent or self.Cooldown then
			return
		end

		if Input.KeyCode == Keybind then
			self:GuiToggle()
		end
	end)
	
	self:GuiToggle()

	return self
end

function QuantumLib.ScreenGui()
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Name = GuiName

	return ScreenGui
end

function QuantumLib.CanvasGroup(Properties)
	local CanvasGroup = Instance.new("CanvasGroup")
	CanvasGroup.AnchorPoint = Vector2.new(.5, .5)
	CanvasGroup.Name = Properties.Name or "CanvasGroup"
	CanvasGroup.BackgroundTransparency = Properties.BackgroundTransparency or 1
	CanvasGroup.Position = Properties.Position or UDim2.new(.5, 0, .5, 0)
	CanvasGroup.Size = Properties.Size or UDim2.new(0, 0, 0, 0)

	return CanvasGroup
end

function QuantumLib.Frame(Properties)
	local Frame = Instance.new("Frame")
	Frame.AnchorPoint = Vector2.new(.5, .5)
	Frame.Name = Properties.Name or "Frame"
	Frame.Position = Properties.Position or UDim2.new(.5, 0, .5, 0)
	Frame.Size = Properties.Size or UDim2.new(0, 0, 0, 0)
	Frame.BorderSizePixel = 0
	Frame.BackgroundColor3 = Properties.BackgroundColor3 or Color3.fromRGB(255, 255, 255)
	Frame.BackgroundTransparency = Properties.BackgroundTransparency or 0

	return Frame
end

function QuantumLib.ScrollingFrame(Properties)
	local ScrollingFrame = Instance.new("ScrollingFrame")
	ScrollingFrame.AnchorPoint = Vector2.new(.5, .5)
	ScrollingFrame.Name = Properties.Name or "ScrollingFrame"
	ScrollingFrame.Position = Properties.Position or UDim2.new(.5, 0, .5, 0)
	ScrollingFrame.Size = Properties.Size or UDim2.new(0, 0, 0, 0)
	ScrollingFrame.BackgroundTransparency = Properties.BackgroundTransparency or 1
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	ScrollingFrame.ScrollBarThickness = 3
	ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

	return ScrollingFrame
end

function QuantumLib.TextLabel(Properties)
	local TextLabel = Instance.new("TextLabel")
	TextLabel.AnchorPoint = Vector2.new(.5, .5)
	TextLabel.Name = Properties.Name or "TextLabel"
	TextLabel.Position = Properties.Position or UDim2.new(.5, 0, .5, 0)
	TextLabel.Size = Properties.Size or UDim2.new(0, 0, 0, 0)
	TextLabel.BackgroundTransparency = Properties.BackgroundTransparency or 1
	TextLabel.BorderSizePixel = 0
	TextLabel.Text = Properties.Text or ""
	TextLabel.TextScaled = true
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.Font = Enum.Font.TitilliumWeb

	return TextLabel
end

function QuantumLib.TextButton(Properties)
	local TextButton = Instance.new("TextButton")
	TextButton.AnchorPoint = Vector2.new(.5, .5)
	TextButton.Name = Properties.Name or "TextButton"
	TextButton.Position = Properties.Position or UDim2.new(.5, 0, .5, 0)
	TextButton.Size = Properties.Size or UDim2.new(0, 0, 0, 0)
	TextButton.BackgroundTransparency = Properties.BackgroundTransparency or 1
	TextButton.BackgroundColor3 = Properties.BackgroundColor3 or Color3.fromRGB(0,0,0)
	TextButton.BorderSizePixel = 0
	TextButton.Text = Properties.Text or ""
	TextButton.TextScaled = true
	TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextButton.Font = Enum.Font.TitilliumWeb

	return TextButton
end

function QuantumLib.AspectRatio(Properties)
	local AspectRatio = Instance.new("UIAspectRatioConstraint")
	AspectRatio.AspectRatio = Properties.AspectRatio or 1

	return AspectRatio
end

function QuantumLib.Corner(Properties)
	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = Properties.CornerRadius or UDim.new(0, 0)

	return Corner
end

function QuantumLib.ListLayout(Properties)
	local ListLayout = Instance.new("UIListLayout")
	ListLayout.Padding = Properties.Padding or UDim.new(0, 0)
	ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	ListLayout.FillDirection = Enum.FillDirection.Vertical
	ListLayout.Wraps = false

	return ListLayout
end

-- Create Functions
function QuantumLib:Toggle()

end

-- Utility
function QuantumLib:Destroy()
	if self.Gui then
		self.Gui:Destroy()
		self.Gui = nil
	end
end

function QuantumLib:ChangeKeybind(NewKeybind)
	Keybind = NewKeybind
end

function QuantumLib:GuiToggle()
	self.Cooldown = true

	if self.Gui then 
		self.Disabled = not self.Disabled
	end

	if self.Disabled then
		local CloseTween = TweenService:Create(self.Main, TweenInfo.new(.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(.381, 0, 0, 0)})
		CloseTween:Play()

		CloseTween.Completed:Once(function()
			CloseTween:Destroy()
			CloseTween = nil

			self.Gui.Enabled = false
		end)
	else
		self.Gui.Enabled = true

		local OpenTween = TweenService:Create(self.Main, TweenInfo.new(.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(.381, 0, .364, 0)})
		OpenTween:Play()

		OpenTween.Completed:Once(function()
			OpenTween:Destroy()
			OpenTween = nil

			self.Disabled = false
		end)
	end

	task.delay(.4, function()
		self.Cooldown = false
	end)
end

function QuantumLib:Notify(Properties)
	StarterGui:SetCore("SendNotification", {
		Title = Properties.Title or "Kewl notification";
		Text = Properties.Text or "Test";
		Duration = Properties.Duration or 3
	})
end

return QuantumLib

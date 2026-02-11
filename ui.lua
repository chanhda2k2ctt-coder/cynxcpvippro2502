--[[
	CYNX HUB - MODERN UI LIBRARY 2026
	Designed by Antigravity
	Style: Glassmorphism / Minimalist Dark
]]

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local Library = {}

-- Utility Functions
local function MakeDraggable(topbarobject, object)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil

	local function Update(input)
		local Delta = input.Position - DragStart
		object.Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
	end

	topbarobject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			Dragging = true
			DragStart = input.Position
			StartPosition = object.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end)

	topbarobject.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			DragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == DragInput and Dragging then
			Update(input)
		end
	end)
end

function Library:CreateWindow(Config)
	local Title = Config.text or "Cynx Hub"
	
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "CynxUI_" .. math.random(1, 10000)
	ScreenGui.Parent = CoreGui
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.Parent = ScreenGui
	MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	MainFrame.BorderSizePixel = 0
	MainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
	MainFrame.Size = UDim2.new(0, 450, 0, 350)
	MainFrame.ClipsDescendants = true

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 10)
	UICorner.Parent = MainFrame

	-- Glow Effect
	local Shadow = Instance.new("ImageLabel")
	Shadow.Name = "Shadow"
	Shadow.Parent = MainFrame
	Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
	Shadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Shadow.BackgroundTransparency = 1.000
	Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	Shadow.Size = UDim2.new(1, 40, 1, 40)
	Shadow.ZIndex = 0
	Shadow.Image = "rbxassetid://6015897843" -- Blur shadow
	Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	Shadow.ImageTransparency = 0.5
	Shadow.SliceCenter = Rect.new(49, 49, 450, 450)
	Shadow.ScaleType = Enum.ScaleType.Slice

	-- Top Bar
	local TopBar = Instance.new("Frame")
	TopBar.Name = "TopBar"
	TopBar.Parent = MainFrame
	TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
	TopBar.BorderSizePixel = 0
	TopBar.Size = UDim2.new(1, 0, 0, 40)

	local TopBarCorner = Instance.new("UICorner")
	TopBarCorner.CornerRadius = UDim.new(0, 10)
	TopBarCorner.Parent = TopBar
	
	-- Fix bottom corners of top bar
	local FixPatch = Instance.new("Frame")
	FixPatch.BorderSizePixel = 0
	FixPatch.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
	FixPatch.Size = UDim2.new(1, 0, 0, 10)
	FixPatch.Position = UDim2.new(0, 0, 1, -10)
	FixPatch.Parent = TopBar

	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Parent = TopBar
	TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.BackgroundTransparency = 1.000
	TitleLabel.Position = UDim2.new(0, 15, 0, 0)
	TitleLabel.Size = UDim2.new(0, 200, 1, 0)
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.Text = Title
	TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.TextSize = 16.000
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 100, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 200, 255))
    }
    Gradient.Parent = TitleLabel

	-- Close Button
	local CloseBtn = Instance.new("TextButton")
	CloseBtn.Parent = TopBar
	CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	CloseBtn.BackgroundTransparency = 1.000
	CloseBtn.Position = UDim2.new(1, -35, 0, 5)
	CloseBtn.Size = UDim2.new(0, 30, 0, 30)
	CloseBtn.Font = Enum.Font.GothamBold
	CloseBtn.Text = "X"
	CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
	CloseBtn.TextSize = 14.000
	
	CloseBtn.MouseButton1Click:Connect(function()
		ScreenGui:Destroy()
	end)

	MakeDraggable(TopBar, MainFrame)

	-- Container
	local Container = Instance.new("ScrollingFrame")
	Container.Name = "Container"
	Container.Parent = MainFrame
	Container.Active = true
	Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Container.BackgroundTransparency = 1.000
	Container.BorderSizePixel = 0
	Container.Position = UDim2.new(0, 10, 0, 50)
	Container.Size = UDim2.new(1, -20, 1, -60)
	Container.ScrollBarThickness = 2
	Container.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 255)

	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Parent = Container
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 8)

	local WindowFunctions = {}

	function WindowFunctions:AddButton(Text, Callback)
		local ButtonFrame = Instance.new("Frame")
		ButtonFrame.Name = "Button"
		ButtonFrame.Parent = Container
		ButtonFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
		ButtonFrame.Size = UDim2.new(1, 0, 0, 40)

		local ButtonCorner = Instance.new("UICorner")
		ButtonCorner.CornerRadius = UDim.new(0, 6)
		ButtonCorner.Parent = ButtonFrame

		local Btn = Instance.new("TextButton")
		Btn.Parent = ButtonFrame
		Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Btn.BackgroundTransparency = 1.000
		Btn.Size = UDim2.new(1, 0, 1, 0)
		Btn.Font = Enum.Font.GothamSemibold
		Btn.Text = Text
		Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		Btn.TextSize = 14.000
		
		Btn.MouseEnter:Connect(function()
			TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 50)}):Play()
		end)
		
		Btn.MouseLeave:Connect(function()
			TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 40)}):Play()
		end)

		Btn.MouseButton1Click:Connect(function()
			-- Click Effect
			local Circle = Instance.new("ImageLabel")
			Circle.Name = "Circle"
			Circle.Parent = Btn
			Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Circle.BackgroundTransparency = 1.000
			Circle.Image = "rbxassetid://266543268"
			Circle.ImageColor3 = Color3.fromRGB(255, 255, 255)
			Circle.ImageTransparency = 0.8
			
			local Mouse = Players.LocalPlayer:GetMouse()
			local X, Y = Mouse.X - Btn.AbsolutePosition.X, Mouse.Y - Btn.AbsolutePosition.Y
			Circle.Position = UDim2.new(0, X, 0, Y)
			local Size = 0
			if Btn.AbsoluteSize.X > Btn.AbsoluteSize.Y then
				 Size = Btn.AbsoluteSize.X * 1.5
			elseif Btn.AbsoluteSize.X < Btn.AbsoluteSize.Y then
				 Size = Btn.AbsoluteSize.Y * 1.5
			elseif Btn.AbsoluteSize.X == Btn.AbsoluteSize.Y then
				Size = Btn.AbsoluteSize.X * 1.5
			end
			
			Circle:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, -Size/2, 0.5, -Size/2), "Out", "Quad", 0.5, false, nil)
			for i=1,10 do
				Circle.ImageTransparency = Circle.ImageTransparency + 0.05
				wait(0.01)
			end
			Circle:Destroy()
			
			if Callback then Callback() end
		end)
	end

	function WindowFunctions:AddToggle(Text, Callback)
		local Toggled = false
		
		local ToggleFrame = Instance.new("Frame")
		ToggleFrame.Name = "Toggle"
		ToggleFrame.Parent = Container
		ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
		ToggleFrame.Size = UDim2.new(1, 0, 0, 40)

		local ToggleCorner = Instance.new("UICorner")
		ToggleCorner.CornerRadius = UDim.new(0, 6)
		ToggleCorner.Parent = ToggleFrame

		local ToggleLabel = Instance.new("TextLabel")
		ToggleLabel.Parent = ToggleFrame
		ToggleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ToggleLabel.BackgroundTransparency = 1.000
		ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
		ToggleLabel.Size = UDim2.new(0, 200, 1, 0)
		ToggleLabel.Font = Enum.Font.GothamSemibold
		ToggleLabel.Text = Text
		ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		ToggleLabel.TextSize = 14.000
		ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

		local ToggleBtn = Instance.new("TextButton")
		ToggleBtn.Parent = ToggleFrame
		ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ToggleBtn.BackgroundTransparency = 1.000
		ToggleBtn.Size = UDim2.new(1, 0, 1, 0)
		ToggleBtn.Text = ""
		
		local Switch = Instance.new("Frame")
		Switch.Parent = ToggleFrame
		Switch.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
		Switch.Position = UDim2.new(1, -55, 0.5, -10)
		Switch.Size = UDim2.new(0, 40, 0, 20)
		
		local SwitchCorner = Instance.new("UICorner")
		SwitchCorner.CornerRadius = UDim.new(1, 0)
		SwitchCorner.Parent = Switch
		
		local Circle = Instance.new("Frame")
		Circle.Parent = Switch
		Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Circle.Position = UDim2.new(0, 2, 0.5, -8)
		Circle.Size = UDim2.new(0, 16, 0, 16)
		
		local CircleCorner = Instance.new("UICorner")
		CircleCorner.CornerRadius = UDim.new(1, 0)
		CircleCorner.Parent = Circle

		ToggleBtn.MouseButton1Click:Connect(function()
			Toggled = not Toggled
			
			if Toggled then
				TweenService:Create(Switch, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 200, 255)}):Play()
				TweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(1, -18, 0.5, -8)}):Play()
			else
				TweenService:Create(Switch, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 65)}):Play()
				TweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -8)}):Play()
			end
			
			if Callback then Callback(Toggled) end
		end)
	end

	function WindowFunctions:AddBox(Text, Callback)
		local BoxFrame = Instance.new("Frame")
		BoxFrame.Name = "Box"
		BoxFrame.Parent = Container
		BoxFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
		BoxFrame.Size = UDim2.new(1, 0, 0, 40)

		local BoxCorner = Instance.new("UICorner")
		BoxCorner.CornerRadius = UDim.new(0, 6)
		BoxCorner.Parent = BoxFrame
		
		local BoxLabel = Instance.new("TextLabel")
		BoxLabel.Parent = BoxFrame
		BoxLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BoxLabel.BackgroundTransparency = 1.000
		BoxLabel.Position = UDim2.new(0, 15, 0, 0)
		BoxLabel.Size = UDim2.new(0, 150, 1, 0)
		BoxLabel.Font = Enum.Font.GothamSemibold
		BoxLabel.Text = Text
		BoxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		BoxLabel.TextSize = 14.000
		BoxLabel.TextXAlignment = Enum.TextXAlignment.Left

		local TextBox = Instance.new("TextBox")
		TextBox.Parent = BoxFrame
		TextBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
		TextBox.BorderSizePixel = 0
		TextBox.Position = UDim2.new(1, -110, 0.5, -12)
		TextBox.Size = UDim2.new(0, 100, 0, 24)
		TextBox.Font = Enum.Font.Gotham
		TextBox.PlaceholderText = "#"
		TextBox.Text = ""
		TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.TextSize = 13.000
		
		local TextCorner = Instance.new("UICorner")
		TextCorner.CornerRadius = UDim.new(0, 4)
		TextCorner.Parent = TextBox
		
		TextBox.FocusLost:Connect(function(enterPressed)
			if Callback then Callback(TextBox, enterPressed) end
		end)
	end
	
	function WindowFunctions:AddLabel(Text)
		local LabelFrame = Instance.new("Frame")
		LabelFrame.Name = "Label"
		LabelFrame.Parent = Container
		LabelFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		LabelFrame.BackgroundTransparency = 1.000
		LabelFrame.Size = UDim2.new(1, 0, 0, 25)

		local Label = Instance.new("TextLabel")
		Label.Parent = LabelFrame
		Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Label.BackgroundTransparency = 1.000
		Label.Size = UDim2.new(1, 0, 1, 0)
		Label.Font = Enum.Font.GothamBold
		Label.Text = Text
		Label.TextColor3 = Color3.fromRGB(150, 150, 150)
		Label.TextSize = 12.000
		Label.TextXAlignment = Enum.TextXAlignment.Center
	end

	return WindowFunctions
end

return Library
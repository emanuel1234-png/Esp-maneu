-- GUI ESP por TIGRINHO

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Criar GUI
local screenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
screenGui.Name = "ESP_GUI"
screenGui.ResetOnSpawn = false

-- Janela flutuante
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 200, 0, 150)
frame.Position = UDim2.new(0.7, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Ativar ESP
local enableButton = Instance.new("TextButton", frame)
enableButton.Text = "Ativar ESP"
enableButton.Size = UDim2.new(1, 0, 0, 40)
enableButton.Position = UDim2.new(0, 0, 0, 0)
enableButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
enableButton.TextColor3 = Color3.new(1,1,1)
enableButton.Font = Enum.Font.SourceSansBold
enableButton.TextSize = 18

-- Desativar ESP
local disableButton = Instance.new("TextButton", frame)
disableButton.Text = "Desativar ESP"
disableButton.Size = UDim2.new(1, 0, 0, 40)
disableButton.Position = UDim2.new(0, 0, 0, 45)
disableButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
disableButton.TextColor3 = Color3.new(1,1,1)
disableButton.Font = Enum.Font.SourceSansBold
disableButton.TextSize = 18

-- Botão Fechar
local closeButton = Instance.new("TextButton", frame)
closeButton.Text = "X"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.TextColor3 = Color3.new(1,1,1)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 14

-- ESP Storage
local espLabels = {}
local espEnabled = false

-- Função de criar ESP
local function createESP(player)
	if player == LocalPlayer then return end
	if espLabels[player] then return end

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "ESP_Tigrinho"
	billboard.Adornee = player.Character:WaitForChild("Head")
	billboard.Size = UDim2.new(0, 100, 0, 30)
	billboard.StudsOffset = Vector3.new(0, 2, 0)
	billboard.AlwaysOnTop = true

	local label = Instance.new("TextLabel", billboard)
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = "TIGRINHO"
	label.TextColor3 = Color3.fromRGB(255, 255, 0)
	label.Font = Enum.Font.SourceSansBold
	label.TextSize = 16

	billboard.Parent = player.Character:WaitForChild("Head")
	espLabels[player] = billboard
end

-- Remover ESP
local function removeESP(player)
	if espLabels[player] then
		espLabels[player]:Destroy()
		espLabels[player] = nil
	end
end

-- Atualizar ESP
local function updateESP()
	for _, player in pairs(Players:GetPlayers()) do
		if player.Character and player.Character:FindFirstChild("Head") then
			if espEnabled then
				createESP(player)
			else
				removeESP(player)
			end
		end
	end
end

-- Conectar eventos
enableButton.MouseButton1Click:Connect(function()
	espEnabled = true
	updateESP()
end)

disableButton.MouseButton1Click:Connect(function()
	espEnabled = false
	updateESP()
end)

closeButton.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

-- Atualiza ao entrar novos jogadores
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		if espEnabled then
			wait(1)
			createESP(player)
		end
	end)
end)

-- LocalScript en StarterPlayerScripts o StarterCharacterScripts

-- Variables
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local userInputService = game:GetService("UserInputService")

-- Variables para guardar la posición inicial y estado del teletransporte
local initialPosition = humanoidRootPart.Position
local teleporting = false

-- Función para obtener una posición aleatoria alrededor de la posición original
local function getRandomPosition(range)
	local offsetX = math.random(-range, range)
	local offsetY = 0  -- Para evitar que el personaje suba o baje en el aire
	local offsetZ = math.random(-range, range)

	-- La nueva posición aleatoria
	return initialPosition + Vector3.new(offsetX, offsetY, offsetZ)
end

-- Función para mover el jugador a varias posiciones rápidamente
local function teleportPlayerRapidly()
	if teleporting then
		-- Si ya está teletransportando, detenerlo y volver a una posición cercana
		teleporting = false
		-- Posición cercana al inicio
		local randomPos = getRandomPosition(50)  -- Rango pequeño para detener el tp
		humanoidRootPart.CFrame = CFrame.new(randomPos)
	else
		-- Si no está teletransportando, empezar a teletransportar aleatoriamente
		teleporting = true
		-- Empezar teletransporte rápido e infinito con múltiples posiciones
		while teleporting do
			-- Realizamos varios teletransportes en simultáneo
			for i = 1, 10 do  -- Hacer 10 teletransportes rápidos a la vez
				local randomPos = getRandomPosition(100)  -- Rango más amplio para el tp infinito
				humanoidRootPart.CFrame = CFrame.new(randomPos)
			end
			wait(0.1)  -- Tiempo de espera para permitir que se actualice el juego
		end
	end
end

-- Detectar cuando se presiona la tecla H
userInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if gameProcessedEvent then return end

	if input.KeyCode == Enum.KeyCode.H then
		teleportPlayerRapidly()
	end
end)

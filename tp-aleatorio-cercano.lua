-- Si presionas la tecla H una vez hara el tp 
-- LocalScript en StarterPlayerScripts o StarterCharacterScripts

-- Variables
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local userInputService = game:GetService("UserInputService")

-- Variables para guardar la posición inicial
local initialPosition = humanoidRootPart.Position
local isTeleporting = false

-- Función para obtener una posición aleatoria alrededor de la posición original
local function getRandomPosition(range)
    local offsetX = math.random(-range, range)
    local offsetY = 0  -- Para evitar que el personaje suba o baje en el aire
    local offsetZ = math.random(-range, range)
    
    -- La nueva posición aleatoria
    return initialPosition + Vector3.new(offsetX, offsetY, offsetZ)
end

-- Función que maneja el teletransporte
local function teleportPlayer()
    if not isTeleporting then
        isTeleporting = true
        -- Teletransportar a una posición aleatoria
        local randomPos = getRandomPosition(50)  -- Rango más amplio para el primer teletransporte
        humanoidRootPart.CFrame = CFrame.new(randomPos)
        wait(0.5)  -- Espera un poco antes de permitir otro teletransporte
        isTeleporting = false
    else
        isTeleporting = true
        -- Teletransportar a una posición muy cercana a la original
        local randomPos = getRandomPosition(10)  -- Rango más cercano para el segundo teletransporte
        humanoidRootPart.CFrame = CFrame.new(randomPos)
        wait(0.5)  -- Espera un poco antes de permitir otro teletransporte
        isTeleporting = false
    end
end

-- Detectar cuando se presiona la tecla H
userInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end
    
    if input.KeyCode == Enum.KeyCode.H then
        teleportPlayer()
    end
end)

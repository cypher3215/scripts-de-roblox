local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Definir el factor de escala
local scaleFactor = 5

-- Cambiar el tamaño de todas las partes del personaje y ajustar las posiciones
for _, part in pairs(character:GetChildren()) do
    if part:IsA("BasePart") then
        part.Size = part.Size * scaleFactor  -- Aumenta el tamaño de la parte
        
        -- Ajustar la posición de las partes para mantener la proporción
        if part.Name == "Head" then
            -- Para la cabeza, podrías modificar la posición de forma diferente si es necesario
            part.Position = part.Position + Vector3.new(0, part.Size.Y / 2, 0)
        elseif part.Name == "HumanoidRootPart" then
            -- Ajustar la raíz para que el personaje no se "caiga" al crecer
            part.Position = part.Position + Vector3.new(0, part.Size.Y / 2, 0)
        end
    end
end

-- Ajustar la altura del personaje
local humanoid = character:WaitForChild("Humanoid")
humanoid.HipWidth = humanoid.HipWidth * scaleFactor
humanoid.HipHeight = humanoid.HipHeight * scaleFactor

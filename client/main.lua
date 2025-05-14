-- Scale function for peds
local function SetEntityScale(entity, scale)
    if not DoesEntityExist(entity) or GetEntityType(entity) ~= 1 then return end

    local right, forward, up, pos = GetEntityMatrix(entity)

    right = vector3(right.x, right.y, right.z) / #(right)
    forward = vector3(forward.x, forward.y, forward.z) / #(forward)
    up = vector3(up.x, up.y, up.z) / #(up)

    right = right * scale
    forward = forward * scale
    up = up * scale

    local _, groundZ = GetGroundZFor_3dCoord(pos.x, pos.y, pos.z, true)
    pos = vector3(pos.x, pos.y, groundZ + scale)

    SetEntityMatrix(entity,
        right.x, right.y, right.z,
        forward.x, forward.y, forward.z,
        up.x, up.y, up.z,
        pos.x, pos.y, pos.z
    )
end

local scalelist = {}
local function SetPedScale(ped, scale)
    if scalelist[ped] and scalelist[ped] == scale then return end
    scalelist[ped] = scale
    print("Create Loop for scaled ped")
    CreateThread(function()
        while DoesEntityExist(ped) and scale ~= 1.0 do
            SetEntityScale(ped, scale)
            Wait(0)
        end
        scalelist[ped] = nil
    end)
end

-- Continuously apply scale to all peds with statebag "scale"
CreateThread(function()
    while true do
        local playerPed = PlayerPedId()

        -- Loop through all nearby peds
        for _, playerId in ipairs(GetActivePlayers()) do
            local ped = GetPlayerPed(playerId)
            if ped and DoesEntityExist(ped) then
                local entState = Entity(ped).state
                local scale = entState.scale
                print(scale)
                if scale then
                    SetPedScale(ped, scale)
                end
            end
        end

        Wait(100) -- Avoid performance hit
    end
end)

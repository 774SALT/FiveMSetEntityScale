-- Server-side: command to set scale on a ped by NetID
RegisterCommand("setscale", function(source, args)
    local identifier = tonumber(args[1])
    local scale = tonumber(args[2])

    if not identifier or not scale then
        print("Usage: /setscale <identifier> <scale>")
        return
    end

    local entity = GetPlayerPed(identifier)
    if not DoesEntityExist(entity) or GetEntityType(entity) ~= 1 then -- 1 = Ped
        print("Entity not found or not a ped.")
        return
    end

    -- Set the statebag on the entity
    Entity(entity).state:set("scale", scale, true)
end, true)

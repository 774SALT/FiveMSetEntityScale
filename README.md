this is function it needs to be called in every frame loop
```lua
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
```

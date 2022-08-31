pcall(function()
    settings().Physics.AllowSleep = false
    settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
end)

getgenv().NetlessParts = NetlessParts or {};

function Net(Part)
    if table.find(NetlessParts, Part) then return end;
    table.insert(Netlessparts, Part);
    local Netless; Netless = coroutine.create(function()
        while Part do
            Part.RotVelocity = Vector3.new();
            Part.AssemblyLinearVelocity = Vector3.new(0, -25.1, 0);
            task.wait()
        end
    end)
    coroutine.resume(Netless);
end

function Align(Item, Item2, Position, Orientation)
    local AttachmentA = Instance.new("Attachment", Item)
    local AttachmentB = Instance.new("Attachment", Item2)

    local AlignPosition = Instance.new("AlignPosition", Item)
    local AlignOrientation = Instance.new("AlignOrientation", Item)

    AttachmentA.Position = Position or Vector3.new(0,0,0)
    AttachmentA.Orientation = Orientation or Vector3.new(0,0,0)

    AlignPosition.Attachment0 = AttachmentA 
    AlignPosition.Attachment1 = AttachmentB
    AlignPosition.RigidityEnabled = true
    AlignPosition.ReactionForceEnabled = false
    AlignPosition.ApplyAtCenterOfMass = false
    AlignPosition.MaxForce = math.huge
    AlignPosition.MaxVelocity = math.huge * math.huge
    AlignPosition.Responsiveness = math.huge * math.huge

    AlignOrientation.Attachment0 = AttachmentA 
    AlignOrientation.Attachment1 = AttachmentB
    AlignOrientation.ReactionTorqueEnabled = false
    AlignOrientation.PrimaryAxisOnly = false
    AlignOrientation.MaxTorque = math.huge
    AlignOrientation.MaxAngularVelocity = math.huge * math.huge
    AlignOrientation.Responsiveness = math.huge * math.huge

    Item.CustomPhysicalProperties = PhysicalProperties.new(1/0/1, 1/0/1, 1/0/1, 1/0/1, 1/0/1)

    return Item2
end





function IntLerp(S, E, T)
    return S+(E-S)*T;
end



function CFrameLerp(S, E, T)
    -- Lerp all at once.
    
    SA = {x, y, z, r00, r01, r02, r10, r11, r12, r20, r21, r22};
    EA = {x, y, z, r00, r01, r02, r10, r11, r12, r20, r21, r22};
    
    SA[1], SA[2], SA[3], SA[4], SA[5], SA[6], SA[7], SA[8], SA[9], SA[10], SA[11], SA[12] = S:components();
    EA[1], EA[2], EA[3], EA[4], EA[5], EA[6], EA[7], EA[8], EA[9], EA[10], EA[11], EA[12] = E:components();
    
    LA = {};
    
    for i,Val in pairs(SA) do
        LV = IntLerp(Val,EA[i],T);
        table.insert(LA, LV);
    end
    
    return CFrame.new(LA[1], LA[2], LA[3], LA[4], LA[5], LA[6], LA[7],LA[8] , LA[9], LA[10], LA[11], LA[12]);
end

function BrickColorLerp(S, E, T)
    sR, sG, sB = S.R, S.G, S.B;
    eR, eG, sB = E.R, E.G, E.B;
    
    lR, lG, lB = IntLerp(sR, eR, T), IntLerp(sG, eG, T), IntLerp(sG, eG, T)
    
    return BrickColor.new(lR, lG, lB);
end


function Color3Lerp(S, E, T)
    sR, sG, sB = S.R, S.G, S.B;
    eR, eG, sB = E.R, E.G, E.B;
    
    lR, lG, lB = IntLerp(sR, eR, T), IntLerp(sG, eG, T), IntLerp(sG, eG, T)
    
    return Color3.new(lR, lG, lB);
end



function lerp(S, E ,T)
    TypeS = typeof(S);
    TypeE = typeof(E);
    if TypeS == "CFrame" and TypeE == "CFrame" then -- make sure the end and start are the same
        return CFrameLerp(S, E, T);
        
    
    elseif TypeS == "Vector3" and TypeE == "Vector3" or TypeS == "number" and TypeE == "number" then
        return IntLerp(S, E, T);
        
    
    elseif TypeS == "BrickColor" and TypeE == "BrickColor" then
        BrickColorLerp(S, E, t);
        
    
    elseif TypeS == "Color3" and TypeE == "Color3" then
        Color3Lerp(S, E, t);
        
        
    else
        print("Error lerping: Unknown Type, Feel free to change the function to add it!")
    end
end


Debugging = {
    ["IntLerp"] = IntLerp,
    ["CFrameLerp"] = CFrameLerp,
    ["BrickColorLerp"] = BrickColorLerp,
    ["Color3Lerp"] = Color3Lerp
}

lp = game.Players.LocalPlayer;
char = lp.Character;
hrp = char.HumanoidRootPart;

char.Archivable = true;
fchar = char:Clone();
fchar.Name = "FakeChar";
fchar.Parent = workspace;

for i,v in pairs(fchar:GetDescendants()) do
    if v:IsA("BasePart") then
        v.Transparency = 1;
        
    elseif v.Name == "Face" then
        v:Destroy();
    end
end


NetworkLoop = spawn(function()
    lp = game.Players.LocalPlayer;
    char = workspace[lp.Name];
    
    game:GetService("RunService").Heartbeat:connect(function()
        if(char:FindFirstChild("Right Arm") and char:FindFirstChild("Left Arm") and char:FindFirstChild("Right Leg") and char:FindFirstChild("Left Leg")) then
            char["Right Arm"].Velocity = Vector3.new(29.999,0,0);   
            char["Left Arm"].Velocity = Vector3.new(29.999,0,0); 
            char["Right Leg"].Velocity = Vector3.new(29.999,0,0); 
            char["Left Leg"].Velocity = Vector3.new(29.999,0,0); 
            char["HumanoidRootPart"].Velocity = Vector3.new(29.999,0,0); 
        end
    end)
end)

CollisionLoop = spawn(function()
    lp = game.Players.LocalPlayer;
    char = workspace[lp.Name];
    
    fchar = workspace["FakeChar"];
    
    
    game:GetService("RunService").Stepped:connect(function()
        if(char:FindFirstChild("Right Arm") and char:FindFirstChild("Left Arm") and char:FindFirstChild("Right Leg") and char:FindFirstChild("Left Leg")) then
            char["Right Arm"].CanCollide = false  
            char["Left Arm"].CanCollide = false
            char["Right Leg"].CanCollide = false
            char["Left Leg"].CanCollide = false 
            char["HumanoidRootPart"].CanCollide = false
            char["Torso"].CanCollide = false
            char["Head"].CanCollide = false
            
            --fchar["Right Arm"].CanCollide = false  
           -- fchar["Left Arm"].CanCollide = false
            --fchar["Right Leg"].CanCollide = false
            --fchar["Left Leg"].CanCollide = false 
            --fchar["HumanoidRootPart"].CanCollide = false
            --fchar["Torso"].CanCollide = false
            --fchar["Head"].CanCollide = false
        end
    end)
end)

char.Torso["Right Shoulder"]:Destroy();
char.Torso["Left Shoulder"]:Destroy();

char.Torso["Right Hip"]:Destroy();
char.Torso["Left Hip"]:Destroy();

char.Parent = nil;
char.HumanoidRootPart.RootJoint:Destroy();
char.Parent = workspace;


align(char["Right Arm"], fchar["Right Arm"]);
align(char["Left Arm"], fchar["Left Arm"]);
align(char["Right Leg"], fchar["Right Leg"]);
align(char["Left Leg"], fchar["Left Leg"]);
align(char["Torso"], fchar["Torso"]);
align(char["HumanoidRootPart"], fchar["HumanoidRootPart"]);

fchar.Torso:WaitForChild("Attachment").Position = Vector3.new(0,0.5,0);

--fchar["Right Arm"]:WaitForChild("Attachment").Position = Vector3.new(0,-0.5,0);
--fchar["Left Arm"]:WaitForChild("Attachment").Position = Vector3.new(0,-0.5,0);


workspace.CurrentCamera.CameraSubject = fchar.Humanoid;

game.Players.LocalPlayer.Character = fchar;

fchar.HumanoidRootPart.Anchored = true;
wait();
fchar.HumanoidRootPart.Anchored = false;
fchar.Humanoid.PlatformStand = false;

fchar.Animate.Disabled = true;
wait();
fchar.Animate.Disabled = false;

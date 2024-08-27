-- THIS IS THE ONLY OPEN SOURCE SCRIPT I WILL PROBABLY EVER MAKE!!!
-- Sorry if the code is messy!

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))() 
local Window = OrionLib:MakeWindow({Name = "Developer Hub", HidePremium = false, SaveConfig = false, ConfigFolder = "DevHubConfig"})

local RemotesTab = Window:MakeTab({
	Name = "Remotes",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local ValuesTab = Window:MakeTab({
	Name = "Values",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local ExploreTab = Window:MakeTab({
	Name = "Explorer",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local MiscTab = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Remotes = {}
local RemoteNames = {}
local SelectedRemote
for i, v in pairs(game:GetDescendants()) do
    if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
        if not v:FindFirstAncestor("RobloxReplicatedStorage") and not v:FindFirstAncestor("DefaultChatSystemChatEvents") then
            table.insert(Remotes, v)
            table.insert(RemoteNames, tostring(v:GetFullName()))
        end
    end
end

RemotesTab:AddDropdown({
	Name = "Remotes",
	Options = RemoteNames,
	Callback = function(Value)
        for i, v in pairs(Remotes) do
            if v:GetFullName() == Value then
                SelectedRemote = v
                return
            end
        end
	end
})

local Args = {}
local NewArg

RemotesTab:AddTextbox({
	Name = "Create Argument",
	TextDisappear = false,
	Callback = function(Value)
		NewArg = loadstring("return "..Value)()
	end
})

RemotesTab:AddButton({
	Name = "Add Argument",
	Callback = function()
        table.insert(Args, NewArg)
  	end    
})

RemotesTab:AddButton({
	Name = "Print Arguments",
	Callback = function()
        for i, v in pairs(Args) do
            print(i, v, type(v))
        end
  	end    
})

RemotesTab:AddButton({
	Name = "Clear Arguments",
	Callback = function()
        for i, v in pairs(Args) do
            Args = {}
        end
  	end    
})

RemotesTab:AddButton({
	Name = "Fire / Invoke Remote",
	Callback = function()
        print("Args: ")
        for i, v in pairs(Args) do
            print(i, v)
        end
        print("Remote: " .. SelectedRemote:GetFullName())
      	if SelectedRemote:isA("RemoteFunction") then
            SelectedRemote:InvokeServer(unpack(Args))
        elseif SelectedRemote:isA("RemoteEvent") then
            SelectedRemote:FireServer(unpack(Args))
        end
  	end    
})

local SelectedValue

ValuesTab:AddTextbox({
	Name = "Value Path",
	TextDisappear = false,
	Callback = function(Value)
        SelectedValue = loadstring("return "..Value)()
	end
})

local NewValue
ValuesTab:AddTextbox({
	Name = "New Value",
	TextDisappear = false,
	Callback = function(Value)
		NewValue = loadstring("return " .. Value)()
	end
})

ValuesTab:AddButton({
	Name = "Set Value",
	Callback = function()
      	SelectedValue.Value = NewValue
  	end    
})

local CurrentPath = game
local SelectedChild

ExploreTab:AddTextbox({
	Name = "Child Path",
	TextDisappear = false,
	Callback = function(Value)
        SelectedChild = Value
	end
})

ExploreTab:AddButton({
	Name = "Go To Child Path",
	Callback = function()
        if not CurrentPath:FindFirstChild(SelectedChild) then
            print("Child not found!")
            return
        end
        if not (#CurrentPath:FindFirstChild(SelectedChild):GetChildren() > 0) then
            print("Child is an instance without children!")
            return
        end
        CurrentPath = CurrentPath:FindFirstChild(SelectedChild)
  	end    
})

ExploreTab:AddButton({
	Name = "Go To Parent Path",
	Callback = function()
        if CurrentPath == game then return end
        CurrentPath = CurrentPath.Parent
  	end    
})

ExploreTab:AddButton({
	Name = "Print Children",
	Callback = function()
        print(" ")
      	for i, v in pairs(CurrentPath:GetChildren()) do
            print(v:GetFullName())
        end
  	end    
})

MiscTab:AddButton({
	Name = "Infinite Yield",
	Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
  	end    
})

OrionLib:Init()

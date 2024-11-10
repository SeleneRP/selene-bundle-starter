local Server = game:GetService("Server")

print("This script will not be included in the client bundle.")
print("You can define server-side code here that you do not want to expose to players.")

Server.ServerStarted:Connect(function()
    print("Bundle received server started event!")
end)
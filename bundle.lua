local bundle = {}

bundle.id = "untitled-bundle"
bundle.name = "Untitled Bundle"

function bundle.init()
	print("This function will run when the bundle is loaded, both on the client and server.")
end

function bundle.init_client()
	print("This function will run when the bundle is loaded on the client.")
end

function bundle.init_server()
	print("This function will run when the bundle is loaded on the server.")
	
	-- "untitled-bundle" in this case is the folder name of your bundle
	require("untitled-bundle.server.example")
end
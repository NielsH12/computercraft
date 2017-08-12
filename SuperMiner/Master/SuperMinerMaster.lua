-- Super Miner Master --

dofile("config")

connectedTurtles = {}
readyTurtles = {}

function waitForConnections()
	print("Waiting for turtles to connect")
	while table.getn(connectedTurtles) < expectedTurtles do
		id, zippedMessage = rednet.receive("mining")
		message = textutils.unserialize(zippedMessage)
		if message[1] == "connect" then			
			connectedTurtles[tonumber(id)] = true
			readyTurtles[tonumber(id)] = false
			
			answer = {"confirm"}
			msg = textutils.serialize(answer)
			rednet.send(id, msg, "mining")
			print("Connection received from" .. id)
		end	
	end
	print("All connections received")
end

function checkReadyTurtles()
	for k in pairs(readyTurtles) do
		if readyTurtles[k] == false then
			return false
		end
	end
	return true
end

function unreadyTurtles()
	for k in pairs(readyTurtles) do
		readyTurtles[k] = false
	end
end

function waitForTurtles()
	print("Waiting for turtles to request permission")
	
	while checkReadyTurtles() == false do

		id2, zippedMessage2 = rednet.receive("mining")
		message2 = textutils.unserialize(zippedMessage2)
		if message2[1] == "request" then
			if connectedTurtles[id2] == true then
				if readyTurtles[id2] == false then
					readyTurtles[id2] = true
				end
			end
		end
	end
	
	print("All turtles are ready")
end

function startTurtles()
	print("Starting turtles")
	msg = {go}
	
	zipmsg = textutils.serialise(msg)		
	rednet.broadcast(zipmsg, "mining")
	
	unreadyTurtles()
end


function moveChunkLoaders()
	print("Here is where I should move the chunkloaders")
end


waitForConnections()

while true do
	waitForTurtles()
	startTurtles()
	moveChunkLoaders()
end
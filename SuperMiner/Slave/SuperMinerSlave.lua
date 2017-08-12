print("Fetching config")
dofile("SuperMiner/Slave/config.lua")
print("Fetching navigation")
dofile("navigation.lua")
print("Fetching status")
dofile("status.lua")

	mining = true -- Does the mining function control the movement of the turtle
	go = false -- Are we allowed to mine the next chunk
	
	busy = false -- Is the turtle working with enderchests and should thus not be moved
	ready = true -- Has the turtle finished the current chunk

function tellFuelLevel()

	_fuel = turtle.getFuelLevel()
	
	msg = {"Fuel", _fuel}
	zmsg = textutils.serialize(msg)
	
	rednet.send(masterID, textutils.serialize(zmsg), "mining")
end

function connectToMaster()
	print("Connecting to master")
	msg = textutils.serialize({"connect"})
	rednet.send(masterID, msg, "mining")
	id, msg = rednet.receive("mining")
	
	if id == masterID then if textutils.unserialize(msg)[1] == "confirm" then print("Succesfully connected to master") end end 
	
end


function main()
	while true do
		-- Send a message --
		Chunk = textutils.unserialize(getNextChunk())
		print("Requesting chunk " .. Chunk[1] .. ", " .. Chunk[2])
		message = {request, Chunk[1], Chunk[2]}

		rednet.send(masterID, textutils.serialize(message), "mining")
		
		-- Receive a message --
		Rid, Rmessage, Rdistance = nil
		print("Listening for commands")
		repeat
			Rid, Rmessage, Rdistance = rednet.receive("mining")
		until Rid == masterID
		
		Rmessage = textutils.unserialize(Rmessage)
		
		if Rdistance[1] == "go" then
			go = true
			mining = true
		elseif Rmessage[1] == "goto" then
			while busy do os.sleep(1) end
			
			mining = false
			go = false
			
			goto(tonumber(Rmessage[2]), tonumber(Rmessage[3]), tonumber(Rmessage[4]))
			
		elseif Rmessage[1] == "unload" then
			unload()
		elseif Rmessage[1] == "refuel" then
			checkFuel()
			tellFuelLevel()
		elseif Rmessage[1] == "fuel" then
			tellFuelLevel()
		end		
		
		-- Execute message --
		
		if go then
			ready = false
			repeat
				sleep(2)
			until mining ~= true
			status("Mining")
			for i = 1,16,1 do
				mineForward()
			end
			go = false
		end
		
		ready = true		
	end
end


rednet.open(modemSide)
updateOrientation()
goToChunkEdge()
connectToMaster()
main()
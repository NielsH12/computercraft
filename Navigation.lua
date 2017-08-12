-- VARIABLES --

	-- Global coordinates
	globalX = 0
	globalY = 0
	globalZ = 0

	-- Chunk Coordinates
	chunkX = 0
	chunkY = 0
	chunkZ = 0
	
	-- Navigation
	orientations = {"north", "east", "south", "west"}
	orientation = -1

	diffX = {0, 1, 0, -1}
	diffZ = {-1, 0, 1, 0}


-- FUNCTIONS -- 


function look(dir)
	while dir ~= orientations[orientation] do
		right()
	end
end

function checkFuel()
	if turtle.getFuelLevel() < 1 then
		unload()
		busy = true
		turtle.select(fuelEnderChestSlot)
		turtle.place()
		turtle.select(firstItemSlot)
			for i = 1, refuelCount, 1 do
				turtle.suck()
				turtle.refuel()
			end
		turtle.select(fuelEnderChestSlot)
		turtle.dig()
		busy = false
		turtle.select(1)
	end
end

function goToChunkEdge()
	if orientation == 1 then
		while localZ > 0 do
			forward()
		end	
	elseif orientation == 2 then
		while localX < 15 do
			forward()
		end	
	elseif orientation == 3 then
		while localZ < 15 do
			forward()
		end	
	elseif orientation == 4 then
		while localX > 0 do
			forward()
		end
	else
		print("I don't know what way i'm looking")
	end
end

function forward()
	checkFuel()
	while not turtle.forward() do turtle.dig() turtle.attack() end
	if orientation ~= -1 then
		globalX = globalX + diffX[orientation]
		globalZ = globalZ + diffZ[orientation]
		
		localX = localX + diffX[orientation]
		localZ = localZ + diffZ[orientation]
		
		if localX > 15 then chunkX = chunkX + 1
		elseif localX < 0 then chunkX = chunkX - 1
		elseif localZ > 15 then chunkZ = chunkZ + 1
		elseif localZ < 0 then chunkZ = chunkZ - 1 end
			
	end
end

function unload()
	busy = true
	turtle.select(itemEnderchestSlot)
	turtle.dig()
	turtle.place()

	for i = firstItemSlot,lastItemSlot,1 do
		turtle.select(i)
		turtle.drop()
	end
	turtle.select(itemEnderchestSlot)
	turtle.dig()
	turtle.select(1)
	busy = false
end

function mineForward()
	checkFuel()
	turtle.digUp()
	turtle.digDown()
	if turtle.getItemCount(16) > 0 then unload() end
	while not turtle.forward() do turtle.dig() turtle.attack() end
	if orientation ~= -1 then
		globalX = globalX + diffX[orientation]
		globalZ = globalZ + diffZ[orientation]
	end
end

function up()
	while not turtle.up() do turtle.digUp() turtle.attackUp() end
	globalY = globalY + 1
end

function down()
	while not turtle.down() do turtle.digDown() turtle.attackDown() end
	globalY = globalY - 1
end

function left()
	if turtle.turnLeft() then
		orientation = orientation - 1
		orientation = (orientation - 1) % 4
		orientation = orientation + 1
	end
end

function right()
	if turtle.turnRight() then
		orientation = orientation - 1
		orientation = (orientation + 1) % 4
		orientation = orientation + 1
	end
end

function goto(x, y, z)
	while y > globalY do
		up()
	end
	while x < globalX do
		look("west")
		forward()
	end
	while x > globalZ do
		look("east")
		forward()
	end
	while z < globalZ do
		look("north")
		forward()
	end
	while z > globalZ do
		look("south")
		forward()
	end
	while y < globalY do
		down()
	end
end

function getNextChunk()
	tempX = globalX
	tempZ = globalZ
	
	tempX = tempX + diffX[orientation] * 16
	tempZ = tempZ + diffZ[orientation] * 16
	
	tempX = math.floor(tempX/16)
	tempZ = math.floor(tempZ/16)
	
	return textutils.serialize({tempX, tempZ})
end

function updatePosition()
	globalX, globalY, globalZ = gps.locate()
	
	chunkX = math.floor(globalX/16)
	chunkY = math.floor(globalY/16)
	chunkZ = math.floor(globalZ/16)
	
	localX = globalX % 16
	localY = globalY % 16
	localZ = globalZ % 16
end

function updateOrientation()
	updatePosition()
	
	turtle.back()
	
	nX, nY, nZ = gps.locate()
	
	if nX > globalX then
		orientation = 4
	elseif nX < globalX then
		orientation = 2
	elseif nZ > globalZ then
		orientation = 1
	elseif nZ < globalZ then
		orientation = 3
	end
	turtle.forward()
	print("I'm at " .. globalX .. " " .. globalY .. " " .. globalZ)
	print("Facing " .. orientations[orientation])
	print("In chunk " .. chunkX .. " " .. chunkY .. " " .. chunkZ)
end
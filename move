if not (os.loadAPI("fuel")) then
	print("Can't load 'fuel' API!")
	return false
end

function forward(length, force)
	if (length == nill) then
		length = 1
	end
	if (force == nill) then
		force = false
	end
	for i = 1, length, 1 do
		while not (turtle.forward()) do
			if not (turtle.detect()) then
				if (turtle.getFuelLevel() == 0) then
					fuel.refuel()
				end
			end
			elseif (force) then
				turtle.dig()
			end
		end
	end
	return true
end

function backward(length, force)

	function move(turned)
		if (turned) then
			return turtle.back()
		else
			return turtle.forward()
		end
	end

	if (length == nill) then
		length = 1
	end
	if (force == nill) then
		force = false
	end
	local turned = false
	for i = 1, length, 1 do
		while not (move(turned)) do
			if not (turtle.detect()) then
				if (turtle.getFuelLevel() == 0) then
					fuel.refuel()
				end
			end
			elseif (force) then
				turtle.turnLeft()
				turtle.turnLeft()
				turned = true
				turtle.dig()
			end
		end
	end
	if (turned) then
		turtle.turnRight()
		turtle.turnRight()
	end
	return true
end

function up(length, force)
	if (length == nill) then
		length = 1
	end
	if (force == nill) then
		force = false
	end
	for i = 1, length, 1 do
		while not (turtle.up()) do
			if not (turtle.detectUp()) then
				if (turtle.getFuelLevel() == 0) then
					fuel.refuel()
				end
			end
			elseif (force) then
				turtle.digUp()
			end
		end
	end
	return true
end

function down(length, force)
	if (length == nill) then
		length = 1
	end
	if (force == nill) then
		force = false
	end
	for i = 1, length, 1 do
		while not (turtle.down()) do
			if not (turtle.detectDown()) then
				if (turtle.getFuelLevel() == 0) then
					fuel.refuel()
				end
			end
			elseif (force) then
				turtle.digDown()
			end
		end
	end
	return true
end

function left()
	turtle.turnLeft()
end

function right()
	turtle.turnRight()
end

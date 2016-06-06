function refuel()
	for i = 1, 16, 1 do
		turtle.select(i)
		if turtle.refuel() then
			return true
		end
	end
	return false
end

function getSelectedSlot()
	return turtle.getSelectedSlot()
end

function getItemCount(s)
	return turtle.getItemCount(s)
end

function forward(l, f, r)
	if (l == nill) then
		l = 1
	end
	if (f == nill) then
		f = false
	end
	if (r == nill) then
		r = false
	end
	for i = 1, l, 1 do
		while not (turtle.forward()) do
			if not (turtle.detect()) then
				if (r) then
					if not (refuel()) then
						return false
					end
				else
					return false
				end
			elseif (f) then
				turtle.dig()
			end
		end
	end
	return true
end

function up(l, f, r)
	if (l == nill) then
		l = 1
	end
	if (f == nill) then
		f = false
	end
	if (r == nill) then
		r = false
	end
	for i = 1, l, 1 do
		while not (turtle.up()) do
			if not (turtle.detectUp()) then
				if (r) then
					if not (refuel()) then
						return false
					end
				else
					return false
				end
			elseif (f) then
				turtle.digUp()
			end
		end
	end
	return true
end

function down(l, f, r)
	if (l == nill) then
		l = 1
	end
	if (f == nill) then
		f = false
	end
	if (r == nill) then
		r = false
	end
	for i = 1, l, 1 do
		while not (turtle.down()) do
			if not (turtle.detectDown()) then
				if (r) then
					if not (refuel()) then
						return false
					end
				else
					return false
				end
			elseif (f) then
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

function dig()
	return turtle.dig()
end

function digDown()
	return turtle.digDown()
end

function digUp()
	return turtle.digUp()
end

function drop(i)
	if (i == nill) then
		return turtle.drop()
	end
	turtle.drop(i)
end

function dropDown(i)
	if (i == nill) then
		return turtle.dropDown()
	end
	turtle.dropDown(i)
end

function dropUp(i)
	if (i == nill) then
		return turtle.dropUp()
	end
	turtle.dropUp(i)
end

function suck(i)
	if (i == nill) then
		return turtle.suck()
	end
	return turtle.suck(i)
end

function suckDown(i)
	if (i == nill) then
		return turtle.suckDown()
	end
	return turtle.suckDown(i)
end

function suckUp(i)
	if (i == nill) then
		return turtle.suckUp()
	end
	return turtle.suckUp(i)
end

function inspect()
	return turtle.inspect()
end

function inspectDown()
	return turtle.inspectDown()
end

function inspectUp()
	return turtle.inspectUp()
end

function detect()
	return turtle.detect()
end

function detectDown()
	return turtle.detectDown()
end

function detectUp()
	return turtle.detectUp()
end

function place(s, f)
	if not (s == nill) then
		turtle.select(s)
	end
	if (f == nill) then
		f = false
	end
	if (f) then
		while not (turtle.place()) do
			turtle.dig()
		end
		return true
	end
	return turtle.place()
end

function placeDown(s, f)
	if not (s == nill) then
		turtle.select(s)
	end
	if (f == nill) then
		f = false
	end
	if (f) then
		while not (turtle.placeDown()) do
			turtle.digDown()
		end
		return true
	end
	return turtle.placeDown()
end

function placeUp(s, f)
	if not (s == nill) then
		turtle.select(s)
	end
	if (f == nill) then
		f = false
	end
	if (f) then
		while not (turtle.placeUp()) do
			turtle.digUp()
		end
	end
	return turtle.place()
end

function getItemDetail(s)
	return turtle.getItemDetail(s)
end

function select(s)
	turtle.select(s)
end

function transferTo(s, c)
	if (c == nill) then
		return turtle.transferTo(s)
	else
		return turtle.transferTo(s, c)
	end
end

function craft(i)
	if (i == nill) then
		return turtle.craft()
	end
	return turtle.craft(i)
end

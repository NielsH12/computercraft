-- Should switch to Pastebin version

function status(msg)
	if gps.locate(0.5) == nil then
		x = "?"
		y = "?"
		z = "?"
	else
		x,y,z = gps.locate()
	end
	
	position = {x,y,z}
	positionZIP = textutils.serialize(position)
	
	id = os.getComputerID()
	label = os.getComputerLabel()
	
	if turtle then
		fuel = turtle.getFuelLevel()
	else
		fuel = "N/A"
	end
	
	if msg == nil then
		msg = "N/A"
	end
	
	message = {id, label, fuel, positionZIP, msg}
	ZIPmessage = textutils.serialize(message)
	
	rednet.broadcast(ZIPmessage, "status")
end
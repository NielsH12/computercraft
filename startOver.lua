shell.run("functions")

platformSize = 1

gotoNewPlace()
placeDirt()

while (true) do
	placeTree()
	chopTree()
	if (platformSize < 3) then
		craftFloor()
		if (getNumberOfItems("minecraft:planks") >= (platformSize + 2) * (platformSize + 2) - 1) then
			expandPlatform(platformSize)
			platformSize = platformSize + 1
		end
	end
	chopLeaves()
	suckLeaves(platformSize - 1)
	if (getNumberOfItems("minecraft:log") * 4 + getNumberOfItems("minecraft:planks") > 9) then
		createBarrel()
		placeBarrel()
	end
end

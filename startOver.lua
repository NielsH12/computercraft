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
	chopLeaves()
	suckLeaves(platformSize)
end

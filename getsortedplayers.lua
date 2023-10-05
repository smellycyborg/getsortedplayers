local function sortTableByValueDesc(tbl)
	local sortedKeys = {}
	for key, value in tbl do
		table.insert(sortedKeys, key)
	end

	table.sort(sortedKeys, function(a, b)
		return tbl[a] > tbl[b]
	end)

	local sortedTable = {}
	for index, key in sortedKeys do
		sortedTable[index] = {playerName = key, playerPoints = tbl[key]}
	end

	return sortedTable
end

return function(playersPoints)
	local sortedPlayersPoints = sortTableByValueDesc(playersPoints)

	local firstPlace = {}
	local secondPlace = {}
	local thirdPlace = {}

	local previousPlayerPoints = nil

	for index, playerData in sortedPlayersPoints do
		local playerName, playerPoints = playerData.playerName, playerData.playerPoints
		
		if not previousPlayerPoints then
			firstPlace[#firstPlace+1] = playerName
		elseif not next(secondPlace) and previousPlayerPoints ~= playerPoints then
			secondPlace[#secondPlace+1] = playerName
		elseif not next(secondPlace) and previousPlayerPoints == playerPoints then
			firstPlace[#firstPlace+1] = playerName
		elseif not next(thirdPlace) and previousPlayerPoints ~= playerPoints then
			thirdPlace[#thirdPlace+1] = playerName
		elseif not next(thirdPlace) and previousPlayerPoints == playerPoints then
			secondPlace[#secondPlace+1] = playerName
		elseif next(thirdPlace) and previousPlayerPoints == playerPoints then
			thirdPlace[#thirdPlace+1] = playerName
		end

		previousPlayerPoints = playerPoints
	end

	return firstPlace, secondPlace, thirdPlace
end

#Find white block in column/row which follow each other, create an array who contain those block
class FindWhiteZone
	def FindWhiteZone.Find(game, vertHor, rank)
		tabCell = Array.new()
		tabCellInside = Array.new()

		if (vertHor == 0)  #Vertical

			(0...game.nCol).each do |i|
				cell = game.cellAt(i, rank)
				if(cell.isAWhite?)
					tabCellInside.push(cell)
				else
					if(!tabCellInside.empty?)
						tabCell.push(tabCellInside)
						tabCellInside = Array.new()
					end
				end
			end

		else  #Horizontal

			(0...game.nRow).each do |i|
				cell = game.cellAt(rank, i)
				if(cell.isAWhite?)
					tabCellInside.push(cell)
				else
					if(!tabCellInside.empty?)
						tabCell.push(tabCellInside)
						tabCellInside = Array.new()
					end
				end
			end

		end

		if(!tabCellInside.empty?)
			tabCell.push(tabCellInside)
		end
		return tabCell

	end
end

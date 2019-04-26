# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: FindWhiteZone.rb
# @Last modified by:   Sckylle
# @Last modified time: 15-Mar-2019


##
# ==== Presentation
# The FindWhiteZone class is an extended method from the Game class.
#
# ==== Methods
# This class knows the find method as described below.
class FindWhiteZone

	# ==== Presentation
	# This class method is used in order to help the other help classes by finding
	# white cells next to each other in a row or column.
	#
	# The empty cells next to each other on the same row or column will be put in
	# an Array. The objective is then to combine all of the Arrays for the column
	# or row into one Array and return it.
	#
	# ===== Attributes
	# * +game+ - The Game in witch we are going to extract our final array.
	# * +vertHor+ - The orientation, put 1 if we are looking for a row, otherwise it will be looking for a column.
	# * +rank+ - The row or column number we want to do our research in.
	#
	# ===== Returns
	# * +tabCell+ - The Array containing all the empty cells of the row or column.
	# ===== Exemple
	# W -> white cell; T -> not white cell
	# | W | W | T | T | W | W | W | T | W | -> row number 3 of game
	# arr = FindWhiteZone.find(game, 1, 3)
	# arr will print something like : [[0,1],[4,5,6],[8]]
	def FindWhiteZone.find(game, vertHor, rank)
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

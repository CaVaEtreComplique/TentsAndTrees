# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: FindWhiteZone.rb
# @Last modified by:   Sckylle
# @Last modified time: 15-Mar-2019


##
# ==== Presentation
# The FindWhiteZone class is an extended methode from Game class
#
# ==== Methods
# This class know the Find methode describe below
#
class FindWhiteZone

	# ==== Presentation
	# This class methode ("  trouve les cases blanches qui se
	# suivent dans une colonne ou ligne pour les placer dans un tableau,
	# renvoie au final un tableau qui contien ces différents tableaux.  ")
	#
	# ===== Attributes
	# * +game+ - The Game in witch we are going to extract our finial array.
	# * +vertHor+ - The orientation, put 1 if we are looking for a row otherwise it
	#			will look for a column.
	# * +rank+ - The row or column number we want to do our research in.
	#
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

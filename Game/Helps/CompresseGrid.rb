# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: CompresseGrid.rb
# @Last modified by:   Sckylle
# @Last modified time: 15-Mar-2019

# Decompresses the grid into 4 arrays whitch contain tent, tree, grass and white

##
# ===== Presentation
# The CompresseGrid class gives an extended method for the Game class.
#
# ===== Methods
# This class only knows the compresse method described below.
class CompresseGrid

  # ===== Presentation
  # This class method counts the number of cells who are in a certain state
  # inside a row or column.
  #
  # ===== Attributes
  # * +game+ - The Game we are going to extract the grid from.
  #
  # ===== Returns
  # This method returns an array that contains four smaller arrays corresponding
  # to a specific regroupement of cells either full of white, tree, tent, or
  # grass cells from the grid of Game.
  def CompresseGrid.compresse(game)

    tree = Array.new
    tent = Array.new
    grass = Array.new
    white = Array.new

    (0...game.nRow).each do |i|
      (0...game.nCol).each do |j|
        cell = game.cellAt(i, j)
        if cell.isATent?
          tent.push(cell)
        elsif cell.isATree?
          tree.push(cell)
        elsif cell.isAGrass?
          grass.push(cell)
        elsif cell.isAWhite?
          white.push(cell)
        end
      end
    end

    return [tree, tent, grass, white]
  end
end

# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: CompresseGrid.rb
# @Last modified by:   Sckylle
# @Last modified time: 15-Mar-2019

# Decompresse the grid into 4 arrays whitch contain tent, tree, grass and white

##
# ==== Presentation
# The Count class give an extended methode for Game class
#
# ==== Methods
# This class know the compresse methode describe below
class CompresseGrid

  # ==== Presentation
  # This class methode count the number of cell who are in a certain state
  # inside a row or column.
  #
  # ===== Attributes
  # * +game+ - The Game we are going to extractact the grid from.
  #
  # ===== Returns
  # This method returns an array that contain four smaller array corresponding
  #   to a specific regroupement of cell ether full of white, tree, tent, or
  #   grass cell form the grid of Game
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

# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: GameDecorated.rb
# @Last modified by:   Maxime
# @Last modified time: 15-Mar-2019


#Decompose the grid and include new array to the object
require File.dirname(__FILE__) + "/CompresseGrid"

class GameDecorated

	@game
	@tree
	@tent
  @grass
  @white
	@nRow
	@nCol

	attr_reader :game, :tree, :grass, :white, :tent

	def nRow
		@game.nRow
	end

	def nCol
		@game.nCol
	end

	def initialize(game)

    array = CompresseGrid.compresse(game)
    @tree = array[0]
    @tent = array[1]
    @grass = array[2]
		@white = array[3]

		@game = game

	end
end

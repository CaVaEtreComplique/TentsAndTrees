require File.dirname(__FILE__) + "/CompresseGrid"

class GameDecorated

	@game
	@tree
	@tent
  @grass
  @white

	attr_reader :game, :tree, :grass, :white, :tent

	def initialize(game)

    array = CompresseGrid.compresse(game)
    @tree = array[0]
    @tent = array[1]
    @grass = array[2]
		@white = array[3]

		@game = game

	end
end

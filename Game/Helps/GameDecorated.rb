require File.dirname(__FILE__) + "/CompresseGrid"

class GameDecorated

	@game
	@tree
  @grass
  @white

	attr_reader :game, :tree, :grass, :white

	def initialize(game)

    array = CompresseGrid.compresse(game)
    @tree = array[0]
    @tent = array[1]
    @grass = array[2]

		@game = game

	end
end

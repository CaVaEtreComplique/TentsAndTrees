# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: GameDivised.rb
# @Last modified by:   Sckylle
# @Last modified time: 25-Mar-2019

require File.dirname(__FILE__) + "/CompresseGrid"

##
# ===== Presentation
# The GameDivised class represents the grid from the Game class as four smaller
# grids, with an access to this Game class.
#
# ===== Variables
# * +game+ - The game used to create the four other variables.
# * +tree+ - A grid that contains all the trees of the game.
# * +tent+ - A grid that contains all the tents of the game.
# * +grass+ - A grid that contains all the grass of the game.
# * +white+ - A grid that contains all the empty cells of the game.
#
# ===== Methods
# This class knows the initialization method.
#
# ===== How to Use
# To create a game where the grid has been divided into the specified grids, use :
#    	game = GameDivised(game).new
# Get the specified grid you want :
#     tree = game.tree()
# Then retrieve the game :
#     game = game.game()
class GameDivised

	@game
	@tree
	@tent
  @grass
  @white

	# :nodoc:
	attr_reader :game, :tree, :grass, :white, :tent
	# :startdoc:

	##
	# ===== Presentation
	# This class' constructor initializes the tree, tent, grass and white
	# variables with the game in order to create small and specific grids.
	def initialize(game)

    array = CompresseGrid.compresse(game)
    @tree = array[0]
    @tent = array[1]
    @grass = array[2]
		@white = array[3]

		@game = game

	end
end

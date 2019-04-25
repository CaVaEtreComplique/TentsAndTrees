# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: GameDecorated.rb
# @Last modified by:   Sckylle
# @Last modified time: 25-Mar-2019

require File.dirname(__FILE__) + "/CompresseGrid"

##
# ==== Presentation
# The GameDecorated class represente the grid of Game class as four smaller
# grid, with an acces to this Game class  .
#
# ==== Variables
# * +game+ : the game used to create the four other variables
# * +tree+ : A grid that contain all the tree of game
# * +tent+ : A grid that contain all the tent of game
# * +grass+ : A grid that contain all the grass of game
# * +white+ : A grid that contain all the white of game
#
# ==== Methods
# This class knows the initialization method and the methods described below.
#
# ===== Exemple
# To create a game where the grid have been divided in specified grid use :
# 	game = GameDecorated(game).new
# Get the specified grid you want : tree = game.tree()
# Then retrieve game : game = game.game()
#
class GameDecorated

	@game
	@tree
	@tent
  @grass
  @white

	attr_reader :game, :tree, :grass, :white, :tent

	##
	# ===== Presentation
	# This class constructor initializes the tree, tent, grass and white
	# variable with the game in order to create small and specified grid.
	#
	def initialize(game)

    array = CompresseGrid.compresse(game)
    @tree = array[0]
    @tent = array[1]
    @grass = array[2]
		@white = array[3]

		@game = game

	end
end

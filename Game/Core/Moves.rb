# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Moves.rb
# @Last modified by:   zeigon
# @Last modified time: 15-Mar-2019

##
# ===== Presentation
# This class manages all the moves within the game, epecially the undo/redo
# function.
#
# ===== Methods
# This class' methods are undo, redo, replay, add and clear and are applied
# to the moves, using a redo stack.
#
# ===== Variables
# * +moves+ - All the moves.
# * +redo+ - Redo stack.
class Moves
	@moves #All the Moves
	@redo #Redo stack

	# :nodoc:
	attr_reader :moves #Stack of Moves
	# :startdoc:

	##
	# ===== Presentation
	# The class' constructor. It creates a new Moves object.
	#
	# ===== Arguments
	# * +moves+ -> All the Moves (empty by default).
	def initialize(moves = [])
		@moves = moves
		@redo = []
	end

	##
	# ===== Presentation
	# The replay method replays each move on the given Game.
	#
	# ===== Arguments
	# * +game+ -> the Game to replay on.
	# -----
	def replay(game)
		@moves.each { |move|
			move.replay(game)
		}
	end

	##
	# ===== Presentation
	# Adds a move to the "moves" stack and clears the redo stack.
	# ===== Arguments
	# * +move+ -> the move to add.
	# -----
	def add(move)
		@moves.push(move)
		clearRedo
	end

	##
	# ===== Presentation
	# This method undoes the last move (i.e replay it on the given game) and pushes it on
	# the redo stack.
	#
	# ===== Arguments
	# * +game+ -> the Game to undo on.
	#
	# ===== Returns
	# The undo move to process.
	def undo
		if @moves.last != nil
			@redo.push(@moves.pop)
			return @redo.last
		end
		return [[[0,0]],"outOfBound"]
	end

	##
	# ===== Presentation
	# This method redoes the last undo move (i.e replay it on the given game) and pushes it
	# on the undo stack.
	# ===== Arguments
	# * +game+ -> the game to redo on.
	# ===== Returns
	# The redo move to process.
	# -----
	def redo
		if @redo.last != nil
			@moves.push(@redo.pop)
			return @moves.last
		end
		return [[[0,0]],"outOfBound"]
	end

	##
	# ===== Presentation
	# This method clears the redo stack.
	# -----
	def clearRedo
		@redo.clear
	end

end

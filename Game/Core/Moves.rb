# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Moves.rb
# @Last modified by:   zeigon
# @Last modified time: 15-Mar-2019

##
# :startdoc:
# This class manages all the moves within the game, epecially the undo/redo
# function. Its methods are undo, redo, replay, add and clear and are applied
# to the moves, using a redo stack.
class Moves
	@moves #All the Moves
	@redo #Redo stack

	# :nodoc:
	attr_reader :moves #Stack of Moves
	# :startdoc:

	##
	# Creates a new Moves object.
	# * *Arguments* :
	#   - +moves+ -> all the Moves (empty by default).
	def initialize(moves = [])
		@moves = moves
		@redo = []
	end

	##
	# Replays each move on the given Game.
	# * *Arguments* :
	#   - +game+ -> the Game to replay on.
	def replay(game)
		@moves.each { |move|
			move.replay(game)
		}
	end

	##
	# Adds a move to the "moves" stack and clears redo stack.
	# * *Arguments* :
	#   - +move+ -> the move to add.
	def add(move)
		@moves.push(move)
		clearRedo
	end

	##
	# Undoes the last move (i.e replay it on the given game) and pushes it on
	# the redo stack.
	# * *Arguments* :
	#   - +game+ -> the Game to undo on.
	# * *Returns* :
	#   - The undo move to proc.
	def undo
		if @moves.last != nil
			@redo.push(@moves.pop)
			return @redo.last
		end
		return [[[0,0]],"outOfBound"]
	end

	##
	# Redoes the last undo move (i.e replay it on the given game) and pushes it
	# on the undo stack.
	# * *Arguments* :
	#   - +game+ -> the game to redo on.
	# * *Returns* :
	#   - The redo move to proc.
	def redo
		if @redo.last != nil
			@moves.push(@redo.pop)
			return @moves.last
		end
		return [[[0,0]],"outOfBound"]
	end

	##
	# Clears the redo stack.
	def clearRedo
		@redo.clear
	end

end

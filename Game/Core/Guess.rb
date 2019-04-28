# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Guess.rb
# @Last modified by:   zeigon
# @Last modified time: 15-Mar-2019



require File.dirname(__FILE__) + "/Moves"

##
# ===== 404
# This class was not commented in the first place, so it can not be documented.
class Guess
	#:nodoc:
	@prev
	@grid

	@moves

	attr_reader :grid, :prev

	def initialize(grid, prev = nil)
		@prev = prev
		@grid = grid
		@moves = Moves.new()
	end

	def root?
		@prev == nil
	end

	def next
		Guess.new(@grid.copyFrozen, self)
	end

	def prev
		root? ? self : @prev
	end

	def cellAt(row, col)
		@grid.cellAt(row, col)
	end

	##
	# Undo the last Move did in this Guess
	def undo
		@moves.undo
	end

	##
	# Redo the last Move did in this Guess
	def redo
		@moves.redo
	end

	def addmove(move)
		@moves.add(move)
	end

	def moves
		return @moves.moves
	end

end

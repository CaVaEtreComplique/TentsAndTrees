require File.dirname(__FILE__) + "/Moves"

class Guess
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

	def addmove(cellState,triRotative)
		@moves.add(cellState,triRotative)
	end



end

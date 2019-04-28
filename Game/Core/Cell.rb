# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Cell.rb
# @Last modified by:   maxime
# @Last modified time: 08-Apr-2019


##
# ===== Presentation
# The Cell class is the core class of every cell in the game.
#
# ===== Variables
# * +states+ - This class knows a list of all the possible states for a cell like this :
#     @@states = [:white, :grass, :tent, :tree, :lockedTree]
# This means every cell in the game has one of these states.
# * +state+ - The cell's state, it must be one of the values given in the +states+ list above.
# * +frozen+ - A boolean which is set to true when the cell is frozen. In the case of a frozen cell, the cell cannot be modified.
# * +row+ - The cell's row on the grid.
# * +column+ - The cell's column on the grid.
#
# These last two parameters are the cell's coordinates.
#
# ===== Methods
# This class knows an initialization method, and the methods described below.
class Cell
	@@states = [:white, :grass, :tent, :tree, :lockedTree]
	@state
	@frozen
	@row
	@column

	#:nodoc:
	attr_reader :state, :frozen, :row, :column
	#:startdoc:

	##
	# ===== Presentation
	# The class' constructor, it is here to give the variables their value taken
	# from the parameters.
	#
	# ===== Parameters
	#
	#     def initialize(args={state: :white, frozen: false, row: 0, column: 0})
	#
	# * +state+ - The cell's initial state.
	# * +frozen+ - A boolean telling if the cell is frozen or not.
	# * +row+ and +column+ - The cell's coordinates.
	#
	# The values in the parameters determine the default values of each variable
	# if there is nothing mentionned in the parenthesis when the method is called.
	# By default, the cell is white, unfrozen and at the coordinates 0,0.
	def initialize(args={state: :white, frozen: false, row: 0, column: 0}) # default value are there only if no args at all are given
		@state = args[:state]
		@frozen = args[:frozen]
		@row = args[:row]
		@column = args[:column]
	end

	##
	# ===== Presentation
	# This method returns the frozen state of a cell.
	#
	# ===== Parameters
	# * +cell+ - The cell we want to get the frozen state from.
	# ----------
	def frozenOf(cell)
		@state = cell.state
		@frozen = (@state != :white)
	end

	##
	# ===== Presentation
	# The primaryChange method is a boolean method returning false if the cell
	# is frozen. This method changes the state of a cell if it's not a tree in
	# order to follow the pattern white=>grass=>tent=>white at each mouse left
	# click. If the cell is a tree, the pattern is tree=>lockedTree=>tree.
	#
	# ===== Returns
	# False if the cell is frozen and not a tree, else it returns true.
	# -----
	def primaryChange
		return false if @frozen unless (@state==:tree||@state==:lockedTree)
		case @state
			when :white
				@state = :grass
			when :grass
				@state = :tent
			when :tent
				@state = :white

			when :tree
				@state = :lockedTree
			when :lockedTree
				@state = :tree
		end
		return true
	end

	##
	# ====== Presentation
	# The primaryUnchange method uses the same system as the primaryChange method
	# but is used in the case of an undo, so the patterns are reversed, becoming
	# white=>tent=>grass=>white.
	# ----------
	def primaryUnchange
		return false if @frozen unless (@state==:tree||@state==:lockedTree)
		case @state
			when :white
				@state = :tent
			when :tent
				@state = :grass
			when :grass
				@state = :white

			when :tree
				@state = :lockedTree
			when :lockedTree
				@state = :tree
		end
		return true
	end

	##
	# ===== Presentation
	# The dragLeftChange method is a boolean method that returns false if the
	# cell is frozen. If not, the cell's state varies between white and grass.
	# This method is used in the case where the player holds down the left mouse
	# click on a row or a column in order to put grass on every cell where the
	# mouse hovers.
	# -----
	def dragLeftChange
		return false if @frozen
		case @state
			when :grass
				@state = :white
			when :white
				@state = :grass
		end
		return true
	end

	##
	# ===== Presentation
	# The biRotative? is an alias method to the isATree? method. It returns true
	# if the cell's state is a tree or a locked tree.
	# -----
	def biRotative?
		@state == :lockedTree ||  @state == :tree
	end

	alias isATree? biRotative?

	##
	# ===== Presentation
	# The == method is used to compare two cells, it returns true if the cells'
	# states are equal.
	#
	# ===== Arguments
	# * +otherCell+ - The cell we want to compare the current cell to.
	# -----
	def ==(otherCell)
		oState=otherCell.state
		return @state==oState unless ([:tree,:lockedTree].include?(oState) && [:tree,:lockedTree].include?(@state))
		true
	end

	##
	# ===== Presentation
	# The isATent? method returns true if the cell's state is a tent.
	# -----
	def isATent?
		return @state == :tent
	end

	##
	# ===== Presentation
	# The isAGrass? method returns true if the cell's state is grass.
	# -----
	def isAGrass?
		return @state == :grass
	end

	##
	# ===== Presentation
	# The isAWhite? method returns true if the cell's state is white.
	# -----
	def isAWhite?
			return @state == :white
	end

	##
	# ===== Presentation
	# This method is overriding the to_s method to print a cell's coordinates
	# in the terminal, mostly for testing purposes.
	def to_s
		return "["+(@row+1).to_s+";"+(@column+1).to_s+"]"
	end

	##
	# ===== Presentation
	# This method is used to fetch the visual rank for a column.
	#
	# ===== Returns
	# The visual rank of the column, so the column + 1 because of the first column
	# showing the numbers needed for each row in the game.
	def getVisualRankColumn()
		return @column + 1
	end

	##
	# ===== Presentation
	# This method is used to fetch the visual rank for a column.
	#
	# ===== Returns
	# The visual rank of the column, so the column + 1 because of the first column
	# showing the numbers needed for each row in the game.
	def getVisualRankRow()
		return @row + 1
	end

end

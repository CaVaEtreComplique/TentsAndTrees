# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Cell.rb
# @Last modified by:   zeigon
# @Last modified time: 01-Mar-2019


##
# ====Presentation
# The Cell class is the core class of every cell in the game.
#
# ====Variables
# This class knows a list of all the possible states for a cell called @states
# like this :
#     @@states = [:white, :grass, :tent, :tree, :lockedTree]
# This means every cell in the game has one of these states.
# ------------
# The @state variable is the cell's state, it must be one of the values given
# in the @@states list above.
# ------------
# The @frozen variable is a boolean which is true when the cell is frozen. In
# the case of a frozen cell, the cell cannot be modified.
# ------------
# The @row and @column variables determine where the cell is on the grid, so
# in which row and in which column (the coordinates of the cell).
#
# ====Methods
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

	# The initialize method takes in parameters the cell's state, if it's frozen
	# or not and the cell's coordinates.
	#     def initialize(args={state: :white, frozen: false, row: 0, column: 0})
	# The values in the parameters determine the default values of each variable
	# if there is nothing mentionned in the parenthesis when the method is called.
	def initialize(args={state: :white, frozen: false, row: 0, column: 0}) # default value are there only if no args at all are given
		@state = args[:state]
		@frozen = args[:frozen]
		@row = args[:row]
		@column = args[:column]
	end

	# The frozenOf method returns the frozen state of the cell given in parameters
	# when needed.
	def frozenOf(cell)
		@state = cell.state
		@frozen = (@state != :white)
	end

	# The primaryChange method is a boolean method returning false if the cell
	# is frozen. This method changes the state of a cell if it's not a tree in
	# order to follow the pattern white=>grass=>tent=>white at each mouse left
	# click. If the cell is a tree, the pattern is tree=>lockedTree=>tree.
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
	# The primaryUnchange method uses the same system as the primaryChange method
	# but is used in the case of an undo, so the patterns are reversed, becoming
	# white=>tent=>grass=>white.
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

	# The dragLeftChange method is a boolean method that returns false if the
	# cell is frozen. If not, the cell's state varies between white and grass.
	# This method is used in the case where the player holds down the left mouse
	# click on a row or a column in order to put grass on every cell where the
	# mouse hovers.
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

	# The biRotative? is an alias method to the isATree? method. It returns true
	# if the cell's state is a tree or a locked tree.
	def biRotative?
		@state == :lockedTree ||  @state == :tree
	end

	alias isATree? biRotative?

	# The == method is used to compare two cells, it returns true if the cells'
	# states are equal.
	def ==(otherCell)
		oState=otherCell.state
		return @state==oState unless ([:tree,:lockedTree].include?(oState) && [:tree,:lockedTree].include?(@state))
		true
	end

	# The isATent? method returns true if a cell's state is a tent.
	def isATent?
		return @state == :tent
	end

	# The isAGrass? method returns true if a cell's state is grass.
	def isAGrass?
		return @state == :grass
	end

	# The isAWhite? method returns true if a cell's state is white.
	def isAWhite?
			return @state == :white
	end

	#:nodoc:
	def to_s
		return "["+@column.to_s+";"+@row.to_s+"]"
	end
end

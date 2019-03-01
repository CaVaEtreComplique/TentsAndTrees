# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Cell.rb
# @Last modified by:   zeigon
# @Last modified time: 01-Mar-2019



# A Cell retains a state and an associated right to modify it's state

class Cell
	@@states = [:white, :grass, :tent, :tree, :lockedTree]
	@state  # one of [:white, :grass, :tent,:tree,:lockedTree]
	@frozen # if it's frozen it cannot be modified
	@row
	@column

	attr_reader :state, :frozen
	def initialize(args={state: :white, frozen: false, row: 0, column: 0}) # default value are there only if no args at all are given
		@state = args[:state]
		@frozen = args[:frozen]
		@row = args[:row]
		@column = args[:column]
	end

	def frozenOf(cell)
		@state = cell.state
		@frozen = (@state != :white)
	end

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

	def biRotative?
		@state == :lockedTree ||  @state == :tree
	end

	alias isATree? biRotative?

	def ==(otherCell)
		oState=otherCell.state
		return @state==oState unless ([:tree,:lockedTree].include?(oState) && [:tree,:lockedTree].include?(@state))
		true
	end

	def isATent?
		return @state == :tent
	end

	def isAGrass?
		return @state == :grass
	end

	def isAWhite?
			return @state == :white
	end

	def to_s
		return "["+@column.to_s+";"+@row.to_s+"]"
	end
end

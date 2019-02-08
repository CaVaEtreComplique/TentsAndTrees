class Moves
	@moves #All the Move s
	@redo #Redo stack

	attr_reader :moves #Stack of Move s

	##
	# Creates a new Moves object
	# * *Arguments* :
	#   - +moves+ -> all the Move s (empty by default)
	def initialize(moves = [])
		@moves = moves
		@redo = []
	end

	##
	# Adds a Move to moves stack and clears redo stack
	# * *Arguments* :
	#   - +move+ -> the move to add
	def add(move)
		@moves.push(move)
		clearRedo
	end

	##
	# Replay each Move on th given Game
	# * *Arguments* :
	#   - +game+ -> the game to replay on
	def replay(game)
		@moves.each { |move|
			move.replay(game)
		}
	end

	##
	# undo the last Move (i.e replay it on the given game) and push it on redo stack
	# * *Arguments* :
	#   - +game+ -> the game to undo on
	# * *Returns* :
	#   - The Undo Move to proc
	def undo
		if @moves.last != nil
			@redo.push(@moves.pop)
			return @redo.last
		end
		return Proc.new {}
	end

	##
	# redo the last undo Move (i.e replay it on the given game) and push it on undo stack
	# * *Arguments* :
	#   - +game+ -> the game to redo on
	# * *Returns* :
	#   - The redo Move to proc
	def redo
		if @redo.last != nil
			@moves.push(@redo.pop)
			return @moves.last
		end
		return Proc.new {}
	end

	##
	# Clears redo stack
	def clearRedo
		@redo.clear
	end

end

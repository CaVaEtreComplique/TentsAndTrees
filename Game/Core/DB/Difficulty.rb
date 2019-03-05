# A Difficulty is defined by its ID and its name
# This Class is used to represent a difficulty in the database
class Difficulty

  @id_difficulty # The ID of the Difficulty
  @name_difficulty # The name of the Difficulty


  # Constructor of a Difficuly
  #
  # ==== Attributes
  #
  # * +id+ - The id of the Difficulty
  # * +name+ - The name of the Difficulty
  #
  # ==== Examples
  #
  #    diff = Difficulty.new(1,"Easy")
  def initialize(id, name)
    @id_difficulty,@name_difficulty = id, name
  end

  attr_reader :id_difficulty, :name_difficulty

end

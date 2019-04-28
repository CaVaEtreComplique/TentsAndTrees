# @Author: Corentin Huaulmé <CorentinHuaulme>
# @Date:   25-Jan-2019
# @Email:  corentin.huaulme.etu@univ-lemans.fr
# @Filename: Difficulty.rb
# @Last modified by:   <HuaulmeCorentin>
# @Last modified time: 15-Mar-2019

##
# ===== Presentation
# The Difficulty class is here to represent a difficulty in the database. A
# Difficulty is represented by its ID and its name.
#
# ===== Methods
# This class only needs to be initialized and applied.
class Difficulty

  @id_difficulty
  @name_difficulty

  # ====== Presentation
  # The class' constructor. It only gives the variables the value taken in parameters.
  #
  # ===== Attributes
  # * +id+ - The id of the Difficulty.
  # * +name+ - The name of the Difficulty.
  #
  # ===== How to Use
  # To create a new difficulty :
  #    diff = Difficulty.new(1,"Easy")
  def initialize(id, name)
    @id_difficulty,@name_difficulty = id, name
  end

# :nodoc:
  attr_reader :id_difficulty, :name_difficulty

end

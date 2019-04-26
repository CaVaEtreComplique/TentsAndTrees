# @Author: Corentin Huaulmé <CorentinHuaulme>
# @Date:   25-Jan-2019
# @Email:  corentin.huaulme.etu@univ-lemans.fr
# @Filename: Gamemode.rb
# @Last modified by:   <HaulmeCorentin>
# @Last modified time: 15-Mar-2019

##
# ===== Presentation
# This method is used to represent a game mode in the database.
# A Gamemode is defined by its ID and its name.
#
# ===== Methods
# This class only needs to be initialized and applied.
class Gamemode

  @id_gamemode
  @name_gamemode

  ##
  # ===== Presentation
  # The class' constructor. It only gives the id and name variables their value,
  # taken from the parameters.
  #
  # ==== Attributes
  # * +id+ - The id of the Gamemode.
  # * +name+ - The name of the Gamemode.
  #
  # ==== How to Use
  # To create a new game mode :
  #    gm = Gamemode.new(1,"Name")
  def initialize(id, name)
    @id_gamemode,@name_gamemode = id, name
  end

  # :nodoc:
  attr_reader :id_gamemode, :name_gamemode

end

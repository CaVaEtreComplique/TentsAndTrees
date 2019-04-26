# @Author: Corentin Huaulmé <CorentinHuaulme>
# @Date:   25-Jan-2019
# @Email:  corentin.huaulme.etu@univ-lemans.fr
# @Filename: Gamemode.rb
# @Last modified by:   <HaulmeCorentin>
# @Last modified time: 15-Mar-2019

# A Gamemode is defined by its ID and its name.
# This is here to represent a Gamemode in the database
class Gamemode

  @id_gamemode # ID of the Gamemode
  @name_gamemode # Name of the Gamemode

  # Constructor of a Gamemode
  #
  # ==== Attributes
  #
  # * +id+ - The id of the Gamemode
  # * +name+ - The name of the Gamemode
  #
  # ==== Examples
  #
  #    gm = Gamemode.new(1,"Name")
  def initialize(id, name)
    @id_gamemode,@name_gamemode = id, name
  end

  # :nodoc:
  attr_reader :id_gamemode, :name_gamemode

end

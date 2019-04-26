# @Author: Corentin Huaulmé <CorentinHuaulme>
# @Date:   25-Jan-2019
# @Email:  corentin.huaulme.etu@univ-lemans.fr
# @Filename: Player.rb
# @Last modified by:   <HuaulmeCorentin>
# @Last modified time: 20-Mar-2019

require('active_record')

##
# ===== Presentation
# The Player class is here to represent a Player in the database.
#
# ===== Variables
# A Player is defined by his ID, his name and his password.
#
# ===== Methods
# This class only needs to be initialized.
class Player

  @id_player # ID of the Player
  @name_player # Name of the Player
  @password_player # Password of the Player

  ##
  # ===== Presentation
  # The class' constructor. It only gives the variables their value taken from
  # the parameters.
  #
  # ===== Attributes
  # * +id+ - The id of the Difficulty of the HighScore.
  # * +name+ - The id of the Player of the HighScore.
  # * +password+ - The score of the HighScore.
  #
  # ===== How to Use
  # To create a new Player :
  #    player = Player.new(1,"Name","Password")
  def initialize(id, name, password)
    @id_player,@name_player,@password_player = id, name, password
  end

  # :nodoc:
  attr_reader :id_player, :name_player, :password_player

end


# A Player is defined by his ID, his name and his password
# This Class is used to represent a Player in the database
class Player

  @id_player # ID of the Player
  @name_player # Name of the Player
  @password_player # Password of the Player

  # Constructor of a Player
  #
  # ==== Attributes
  #
  # * +id+ - The id of the difficulty of the HighScore
  # * +name+ - The id of the Player of the HighScore
  # * +password+ - The score of the HighScore
  #
  # ==== Examples
  #
  #    player = Player.new(1,"Name","Password")
  def initialize(id, name, password)
    @id_player,@name_player,@password_player = id, name, password
  end

  attr_reader :id_player, :name_player, :password_player

end

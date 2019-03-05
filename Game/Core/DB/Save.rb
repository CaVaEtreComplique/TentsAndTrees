
# A Save is defined by its ID, its Player, its date and its content
# This Class is used to represent a Save in the database
class Save

  @id_save # The ID of the Save
  @player_id_save # The Player's ID of the Save
  @gamemode_id_save # The Gamemode of the Save
  @difficulty_id_save # The Difficulty of the Save
  @date_save # The date of the Save
  @content_save # The content of the Save


  # Constructor of a Save
  #
  # ==== Attributes
  #
  # * +id+ - The id of the Save
  # * +player+ - The id of the Player of the Save
  # * +date+ - The date of the Save
  # * +content+ - The content of the Save
  #
  # ==== Examples
  #
  #    save = Save.new(1,1,01-03-2019,"Things to Save (State of the grid)")
  def initialize(id, player, gm, diff, date, content)
    @id_save,@player_id_save,@date_save, @content_save = id, player, date, content
    @gamemode_id_save,@difficulty_id_save = gm, diff
  end

  attr_reader :id_save, :player_id_save, :gamemode_id_save, :difficulty_id_save, :date_save, :content_save

end

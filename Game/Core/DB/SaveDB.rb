# @Author: Corentin Huaulmé <CorentinHuaulme>
# @Date:   25-Jan-2019
# @Email:  corentin.huaulme.etu@univ-lemans.fr
# @Filename: SaveDB.rb
# @Last modified by:   <HuaulmeCorentin>
# @Last modified time: 20-Mar-2019


##
# ===== Presentation
# The SaveDB class is here to represent a Save in the database.
#
# ===== Variables
# A Save is defined by its ID, its Player, its date and its content.
#
# ===== Methods
# This class only needs to be initialized.
class SaveDB

  @id_save # The ID of the Save
  @player_id_save # The Player's ID of the Save
  @date_save # The date of the Save
  @content_save # The content of the Save


  ##
  # ===== Presentation
  # The class' constructor. It only gives the variables their value taken from
  # the parameters.
  #
  # ===== Attributes
  # * +id+ - The ID of the Save.
  # * +player+ - The ID of the Player of the Save.
  # * +date+ - The date of the Save.
  # * +content+ - The content of the Save.
  #
  # ===== How to Use
  # To create a new Save :
  #    save = Save.new(1,1,01-03-2019,"Things to Save (State of the grid)")
  def initialize(id, player, date, content)
    @id_save,@player_id_save,@date_save, @content_save = id, player, date, YAML.load(content)
  end

  # :nodoc:
  attr_reader :id_save, :player_id_save, :date_save, :content_save

end

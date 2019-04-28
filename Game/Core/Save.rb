# @Author: Corentin Petit <zeigon>
# @Date:   05-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Saves.rb
# @Last modified by:   zeigon
# @Last modified time: 15-Mar-2019
require File.dirname(__FILE__) + "/DB/ConnectDB.rb"
require 'yaml'


#
# ===== Presentation
# This class represents a Save within the game.
#
# ===== Variables
# * +session+ - This variable represents the Session's link to the save.
#
# * +idSave+ - This variable is the idName of a save.
#
# ===== Methods
# This class knows an initialization method, but also load, update and destroy described below.
class Save

  @session
  @idSave

  ##
  # ===== Presentation
  # This class' constructor initializes the variable @session.
  #
  # ===== Attributes
  # * +session+ : The Session who represents the overall save.
  # -----
  def initialize(session)
    @session = session
  end

  ##
  # ===== Presentation
  # This class method allows the loading of a Session, without having to create a Save.
  #
  # ===== Attributes
  # * +id+ : The idSave we are looking for.
  # -----
  def Save.load(id)
    save = ConnectDB.new().getSaveByID(id)
    return save
  end

  ##
  # ===== Presentation
  # This class allows the loading of the Session, from within a Save object.
  #
  # ===== Attributes
  # * +id+ : The idSave we are looking for.
  def load()
    save = ConnectDB.new().getSaveByID(@idSave)
    YAML.load(save.content_save)
  end

  ##
  # ===== Presentation
  # This class method updates an already existing Save with a Session.
  #
  # ===== Attributes
  # * +session+ : The Session we update a save onto.
  def Save.update(session)
    db = ConnectDB.new()
    diff = nil
    case session.difficulty
    when :easy
      diff = 0
    when :medium
      diff = 1
    when :hard
      diff = 2
    when :random
      diff = 3
    end

    db.save(Connexion.getJoueur,session.to_yaml())
  end

  ##
  # ===== Presentation
  # This class destroys a Save from the database.
  # -----
  def destroy

  end

end

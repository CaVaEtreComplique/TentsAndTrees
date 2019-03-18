# @Author: Corentin Petit <zeigon>
# @Date:   05-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Saves.rb
# @Last modified by:   zeigon
# @Last modified time: 15-Mar-2019
require File.dirname(__FILE__) + "/DB/ConnectDB.rb"
require 'yaml'

class Save

  @session
  @idSave

  def initialize(session)
    @session = session
  end


  def Save.load(id)
    save = ConnectDB.new().getSaveByID(id)
    return save
  end

  def load()
    save = ConnectDB.new().getSaveByID(@idSave)
    YAML.load(save.content_save)
  end

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

  def destroy

  end

end

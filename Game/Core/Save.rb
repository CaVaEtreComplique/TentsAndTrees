# @Author: Corentin Petit <zeigon>
# @Date:   05-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Saves.rb
# @Last modified by:   zeigon
# @Last modified time: 05-Mar-2019
require File.dirname(__FILE__) + "/DB/ConnectDB.rb"

class Save

  @session
  @idSave

  def initialize(session)
    @session = session
  end


  def load(id)
    save = ConnectDB.new().getSaveByID(id)
    Marshal.load(save.content_save)
  end

  def load()
    save = ConnectDB.new().getSaveByID(@idSave)
    Marshal.load(save.content_save)
  end

  def Save.update(session)
    Marshal.dump(session)
    puts Marshal.load(Save.testSave(session))
  end

  def destroy

  end

end

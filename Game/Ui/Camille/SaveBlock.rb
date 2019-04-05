# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   1-Mar-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: ChoixDiff.rb
# @Last modified by:   zeigon
# @Last modified time: 28-Mar-2019

require 'gtk3'
require File.dirname(__FILE__) + "/../Screens/Screen"
require File.dirname(__FILE__) + "/../Buttons/Button"
require File.dirname(__FILE__) + "/../../Core/DB/ConnectDB"

def require_all(_dir)
	Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each { |file|
		require file
	}
end

class SaveBlock < Gtk::Box
	def initialize(manager,save, parent)
    super(:horizontal)
		@pad=screen.height*0.03
		@police=screen.height*0.04

      @menu=Gtk::Box.new(:horizontal)

      id=Text.new(save.id_save.to_s,@police)
      @menu.pack_start(id.gtkObject ,expand: true, fill: true, padding: @pad)

      #d=Button.new(:horizontal,save.date_save.to_s)
      d=Text.new(save.date_save,@police)
      @menu.pack_start(d.gtkObject ,expand: true, fill: true, padding: @pad)
    #  md=Text.new(save.content_save.gameMode,0.5,0.3)
    #  @menu.pack_start(md.gtkObject ,expand: true, fill: true, padding: @pad)
      c=Text.new("CHARGER",@police)
      @menu.pack_start(c.gtkObject ,expand: false, fill: true, padding: @pad)
      c.onClick{
          manager.runGameSessionFromSave(Save.load(save.id_save))

       }

			 delete=Text.new("Supprimer",@police)
       @menu.pack_start(delete.gtkObject ,expand: false, fill: true, padding: @pad)
       delete.onClick{
				 	 connect=ConnectDB.new
					 connect.deleteSave(save.id_save)
				 	 manager.updateSave
           manager.listeSaveScreen.applyOn(parent)
        }

       self.add(@menu)
	end
end

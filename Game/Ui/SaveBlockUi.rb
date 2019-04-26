# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   1-Mar-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: ChoixDiff.rb
# @Last modified by:   Sckylle
# @Last modified time: 25-Mar-2019

require 'gtk3'
require File.dirname(__FILE__) + "/Buttons/Button"
require File.dirname(__FILE__) + "/../Core/DB/ConnectDB"
require File.dirname(__FILE__) + "/../Core/XmlReader"

def require_all(_dir)
	Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each { |file|
		require file
	}
end

##
# ===== Presentation
# SaveblockUi is an inherited class from the gtkBox. It creates and implements
# the save block screen from the save.
#
# ===== Methods
# This class only needs to be initialized.
class SaveBlockUi < Gtk::Box

	##
	# ===== Presentation
	# This method is used to create the Save block.
	# All save blocks contain a number of save, a save, a load button and a delete button.
	# All the other variables are used for the layout.
	# ===== Attributes
	# *+manager+ : managerUi who handles the Ui.
	# *+save+ : The corresponding save.
	# *+parent+ :
	#
	def initialize(manager,save, parent)
    super(:horizontal)
		@pad=screen.height*0.03
		@police=screen.height*0.04
		@textManager=XmlReader.instance

      @menu=Gtk::Box.new(:horizontal)

      id=Text.new(save.id_save.to_s,@police)
			d=Text.new(save.date_save,@police)
			c=Text.new(@textManager.getButtonLabel("save", "load"),@police)
			delete=Text.new(@textManager.getButtonLabel("save", "del"),@police)

      @menu.pack_start(id.gtkObject ,expand: true, fill: true, padding: @pad)
      @menu.pack_start(d.gtkObject ,expand: true, fill: true, padding: @pad)
      @menu.pack_start(c.gtkObject ,expand: false, fill: true, padding: @pad)
			@menu.pack_start(delete.gtkObject ,expand: false, fill: true, padding: @pad)

			c.onClick{
          manager.runGameSessionFromSave(Save.load(save.id_save))
       }
      delete.onClick{
				 	 connect=ConnectDB.new
					 connect.deleteSave(save.id_save)
				 	 manager.updateSave
           manager.listeSaveScreen.applyOn(parent)
        }

       self.add(@menu)
	end
end

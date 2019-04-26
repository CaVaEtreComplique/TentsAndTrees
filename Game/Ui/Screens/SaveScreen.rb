# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   1-Mar-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: ChoixDiff.rb
# @Last modified by:   Sckylle
# @Last modified time: 25-Mar-2019

require 'gtk3'
require File.dirname(__FILE__) + "/../Screens/Screen"
require File.dirname(__FILE__) + "/../Buttons/Button"
require File.dirname(__FILE__) + "/../SaveBlockUi"
require File.dirname(__FILE__) + "/../../Core/DB/ConnectDB"

def require_all(_dir)
	Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each { |file|
		require file
	}
end

##
# ===== Presentation
# SaveScreen is an inherited class from the Screen class. This class only needs
# to be initialized.
# It creates and implements the high save screen from the game.
class SaveScreen < Screen

	# ===== Presentation
	# This method is used to create the save screen by calling the class SaveBlockUi.
	# A scrollable area is also created by calling the class ScrollableArea, which contains
	# buttons and boxes.
	# On the page you can load and delete a save.
	# All the other variables are used for the layout.
	#
	# ===== Attributes
	# * +manager+ - managerUi who handles the Ui.
	# * +joueur+ - represents the connected player.
	def initialize(manager,joueur)
		super(manager.win)
		screen = Constants::SCREEN
		@pad=Constants::BUTTON_PADDING

		@gtkObject= Gtk::Table.new(3,3)
		@scrol=ScrollableArea.new(:vertical)
		@menuR=Gtk::Box.new(:horizontal)
		@boxV=Gtk::Box.new(:vertical)
		sauvegarde=Text.new(@textManager.getScreenTexts("save" , "title"))
		sauvegarde.title
		@boxV.pack_start(sauvegarde.gtkObject ,expand: false, fill: true, padding:@pad)

		@gtkObject.attach(@boxV,0,1,1,2)
		@boxV.pack_start(@scrol.gtkObject,expand: true, fill: true, padding: @pad)

		connect=ConnectDB.new

		tab=connect.getPlayersSave(joueur)

		if(tab.empty?)
				noSave=Text.new(@textManager.getScreenTexts("save" , "nosave"))
				@scrol.add(noSave.gtkObject)
		else
				tab.each{|i|
				@scrol.add(SaveBlockUi.new(manager,i,@parent))
				}
		end
		retour=Text.new(@textManager.getButtonLabel("save" , "back"))
		@menuR.pack_start(retour.gtkObject ,expand: false, fill: true, padding:@pad)
		@boxV.add(@menuR)
	#	@scrol.pack_start(retour.gtkObject ,expand: false, fill: true, padding: @pad)
		retour.onClick{
			manager.modeScreen.applyOn(@parent)
		 }

		 @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
	end
end

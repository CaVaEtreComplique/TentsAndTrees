# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   1-Mar-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: ChoixDiff.rb
# @Last modified by:   zeigon
# @Last modified time: 28-Mar-2019

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

class SaveScreen < Screen
	def initialize(manager,joueur)
		super(manager.win)
		screen=Gdk::Screen.default
		#Variable pour resize le texte
		@pad=screen.height*0.03
    @police=screen.height*0.04

		@gtkObject= Gtk::Table.new(3,3)
		@menuR=Gtk::Box.new(:horizontal)
		@scrol=ScrollableArea.new(:vertical)
		@boxV=Gtk::Box.new(:vertical)
		@gtkObject.attach(@boxV,0,1,1,2)
		@boxV.pack_start(@scrol.gtkObject,expand: true, fill: true, padding: @pad)

		connect=ConnectDB.new

		tab=connect.getPlayersSave(joueur)

		if(tab.empty?)
				noSave=Text.new("PAS DE SAUVEGARDE",@police)
				@scrol.add(noSave.gtkObject)
		else
				tab.each{|i|
				@scrol.add(SaveBlockUi.new(manager,i,@parent))
				}
		end
		retour=Text.new("RETOUR",@police)
		@menuR.pack_start(retour.gtkObject ,expand: false, fill: true, padding:10)
		@boxV.add(@menuR)
	#	@scrol.pack_start(retour.gtkObject ,expand: false, fill: true, padding: @pad)
		retour.onClick{
			manager.modeScreen.applyOn(@parent)
		 }

		 @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
	end
end
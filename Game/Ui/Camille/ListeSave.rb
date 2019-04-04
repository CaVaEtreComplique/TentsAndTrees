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

class ListeSave < Screen
	def initialize(manager,joueur)
		super(manager.win)
		screen=Gdk::Screen.default
		#Variable pour resize le texte
		@pad=10

		@gtkObject= Gtk::Table.new(3,3)
		@menu=Gtk::Box.new(:vertical)
		@menu2=Gtk::Box.new(:vertical)


		@scrol=Gtk::ScrolledWindow.new()
		@scrol.border_width=10
		@vp=Gtk::Viewport.new(nil,@scrol.vadjustment)
		@vp.add(@menu2)
		@menu2.add(@menu)
		@scrol.add(@vp)
		@gtkObject.attach(@scrol,1,2,0,1)

		connect=ConnectDB.new

		tab=connect.getPlayersSave(joueur)

		if(tab.empty?)
				noSave=Text.new("PAS DE SAUVEGARDE",14)
				@menu.pack_start(noSave.gtkObject ,expand: false, fill: true, padding: @pad)
		else
				tab.each{|i|
					@menu.pack_start(SaveBlock.new(manager,i,@parent),expand: false, fill: true, padding:@pad)

				}
		end
		retour=Text.new("RETOUR",14)
		@menu2.pack_start(retour.gtkObject ,expand: false, fill: true, padding: @pad)
		retour.onClick{
			manager.modeScreen.applyOn(@parent)
		 }



		 @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
	end
end

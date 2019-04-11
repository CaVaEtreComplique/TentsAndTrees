# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: TestGame.rb
# @Last modified by:   zeigon
# @Last modified time: 11-Apr-2019



def require_all(_dir)
	Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each { |file|
		require file
	}
end

require "gtk3"
require_all("Core")
require_all("Ui")
require_all("Helps")

# ----------------------------------
# => Main
# ----------------------------------
# ----------------------------------
# => Generation de la fenetre de jeu
# ----------------------------------
class TestGame
	def initialize
		@win = Gtk::Window.new.fullscreen
		@win.title = "Tent & Trees"
		@win.signal_connect('delete_event') {
			Gtk.main_quit
			false
		}
		@win.icon=GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/../Assets/Icons/tent.jpeg")
		@win.show_all

		ui = UiManager.new(@win,nil)
		ui.run

		@win.override_background_color(:normal,Gdk::RGBA.new(0.1, 0.6, 1, 1))
		@win.show_all



	end

	def TestGame.hide
			@win.hide
	end
end

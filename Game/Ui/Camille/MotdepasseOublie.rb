# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   8-Mar-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: Connexion.rb
# @Last modified by:   zeigon
# @Last modified time: 28-Mar-2019

def require_all(_dir)
	Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each { |file|
		require file
	}
end


require 'gtk3'
require_all("Ui")
require File.dirname(__FILE__) + "/../../Core/DB/ConnectDB"

class MotdepasseOublie
  def onDestroy
     Gtk.main_quit
  end
  def initialize()
    screen=Gdk::Screen.default
		#Variable pour resize le texte
	  @pad =8
    win = Gtk::Window.new
		w=screen.width
		h=screen.height
    win.set_default_size(w/4,h/10)
    win.set_resizable(false)

    connect=ConnectDB.new

  	@menu=Gtk::Box.new(:vertical, 25)
		saisiLogin = Gtk::Entry.new()
    saisi=Gtk::Entry.new()
    saisi2=Gtk::Entry.new()
    mdp = Text.new("SAISIR")
		confirm =Text.new("Comfirmer")
    @menu.pack_start(mdp.gtkObject,expand: false, fill: true, padding: @pad)
		@menu.pack_start(saisiLogin, expand: false, fill: true, padding: @pad)
    @menu.pack_start(saisi,expand: false, fill: true, padding: @pad)
  #  @menu.pack_start(mdp,expand: false, fill: true, padding: @pad)
    @menu.pack_start(saisi2,expand: false, fill: true, padding: @pad)
		@menu.pack_start(confirm.gtkObject,expand: false, fill: true, padding: @pad)
  #  if(saisi.text ==saisi2.text)
        #connect.    UPDATEPLAYER
  #  end
		confirm.onClick{
    	if(saisi.text !=saisi2.text)
      	saisi.set_text("")
      	saisi2.set_text("")
    	else
				win.hide
				Connexion.connexion(connect.playerUpdate(saisiLogin.text, saisi.text))
			end
		}
    win.add(@menu)
    win.show_all

  end
end

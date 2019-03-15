# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   8-Mar-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: Connexion.rb
# @Last modified by:   zeigon
# @Last modified time: 15-Mar-2019

def require_all(_dir)
	Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each { |file|
		require file
	}
end


require 'gtk3'
require_all("Ui")
require File.dirname(__FILE__) + "/TestGame"
require File.dirname(__FILE__) + "/Core/DB/ConnectDB"


class Connexion

  def initialize()
    screen=Gdk::Screen.default
		#Variable pour resize le texte
	  @pad =8

		connect=ConnectDB.new

    win = Gtk::Window.new
    win.set_default_size(495,495)
    win.set_resizable(false)
		win.decorated=false
    win.window_position= :center_always

    @menu=Gtk::Box.new(:vertical, 25)

  	@gtkObject= Gtk::Table.new(3,3)
		@gtkObject.attach(@menu,1,2,1,2)

		@buffer = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/../Assets/Backgrounds/nature.png")

    @image=Gtk::EventBox.new()

    log = Text.new("LOGIN",0.5,0.3)
    mdp = Text.new("MOT DE PASSE",0.5,0.3)
    ident = Text.new("SE CONNECTER",0.5,0.3)
		inscription =Text.new("INSCRIPTION",0.5,0.3)
		mdpOublie=Text.new("MOT DE PASSE OUBLIE",0.5,0.3)

    quitter=Asset.new(File.dirname(__FILE__) + "/../Assets/Icons/cancel.png")
    quitter.resize(20,20)
    quitter.applyOn(@image)
    @image.signal_connect('button_press_event' ) {
       Gtk.main_quit
    }
		saisi=Gtk::Entry.new()
    saisi2=Gtk::Entry.new()
		saisi2.visibility=false

    @menu.pack_start(@image,expand: false, fill: true, padding: @pad)

    @menu.pack_start(log.gtkObject,expand: false, fill: true, padding: @pad)
    @menu.pack_start(saisi,expand: false, fill: true, padding: @pad)
    @menu.pack_start(mdp.gtkObject,expand: false, fill: true, padding: @pad)
    @menu.pack_start(saisi2,expand: false, fill: true, padding: @pad)
    @menu.pack_start(ident.gtkObject,expand: false, fill: true, padding: @pad)
    ident.onClick{
	    if(connect.playerConnect(saisi.text,saisi2.text)!=nil)
				win.hide
				TestGame.new
			else
				 	ProblemeIdent.new
	 				saisi.set_text("")
	 				saisi2.set_text("")
			end
    }
		@menu.pack_start(mdpOublie.gtkObject,expand: false, fill: true, padding: @pad)
		mdpOublie.onClick{
					#	MotdepasseOublie.new
		 }
		 @menu.pack_start(inscription.gtkObject,expand: false, fill: true, padding: @pad)
		 inscription.onClick{
			 if(connect.isPlayerExist(saisi.text)!=nil)
					Probleme.new
					saisi.set_text("")
					saisi2.set_text("")
				end
			 		if(connect.isPlayerExist(saisi.text)==nil)
						connect.createPlayer(saisi.text, saisi2.text)
						TestGame.new
					end

			}

  # win.add(@#)
    win.signal_connect('destroy') {Gtk.main_quit}
		@gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
		win.add(@gtkObject)
		win.show_all
  end
end

Connexion.new
Gtk.main

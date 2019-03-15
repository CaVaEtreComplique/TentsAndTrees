# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   8-Mar-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: Connexion.rb
# @Last modified by:    CamilleVAIDIE
# @Last modified time: 08-Mar-2019

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
  def onDestroy
     Gtk.main_quit
  end
  def initialize()
    screen=Gdk::Screen.default
		#Variable pour resize le texte
	  @pad =8

		connect=ConnectDB.new

    win = Gtk::Window.new
    win.set_default_size(495,495)
    win.set_resizable(false)
    #win.set_window_position(POS_CENTER_ALWAYS)
    @menu=Gtk::Box.new(:vertical, 25)

  	@gtkObject= Gtk::Table.new(3,3)
		@gtkObject.attach(@menu,1,2,1,2)

		@buffer = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/../Assets/Backgrounds/nature.png")

    @image=Gtk::EventBox.new()

    log = Text.new("LOGIN",0.5,0.3)
    mdp = Text.new("MOT DE PASSE",0.5,0.3)
    ident = Text.new("SE CONNECTER",0.5,0.3)
		inscription =Text.new("INSCRIPTION",0.5,0.3)

    quitter=Asset.new(File.dirname(__FILE__) + "/../Assets/Icons/cancel.png")
    quitter.resize(20,20)
    quitter.applyOn(@image)
    @image.signal_connect('button_press_event' ) {
       Gtk.main_quit
    }
		saisi=Gtk::Entry.new()
    saisi2=Gtk::Entry.new()

    @menu.pack_start(@image,expand: false, fill: true, padding: @pad)

    @menu.pack_start(log.gtkObject,expand: false, fill: true, padding: @pad)
    @menu.pack_start(saisi,expand: false, fill: true, padding: @pad)
    @menu.pack_start(mdp.gtkObject,expand: false, fill: true, padding: @pad)
    @menu.pack_start(saisi2,expand: false, fill: true, padding: @pad)
    @menu.pack_start(ident.gtkObject,expand: false, fill: true, padding: @pad)
    ident.onClick{
     if(connect.playerConnect(saisi.text,saisi2.text)!=nil)
			   TestGame.new
				# win.destroy
		 end
		 if(connect.playerConnect(saisi.text,saisi2.text)==nil)
		 		Gtk.main_quit
			end

     }
		 @menu.pack_start(inscription.gtkObject,expand: false, fill: true, padding: @pad)
		 inscription.onClick{
			 		#if( IDENT LIBRE)
					connect.createPlayer(saisi.text, saisi2.text)
					TestGame.new
					#end
					#if( IDENT PAS LIBRE)
						pb = Text.new("Login indisponible",0.5,0.3)
						@menu.pack_start(pb.gtkObject,expand: false, fill: true, padding: @pad)

					#end
			}
  # win.add(@#)
    win.signal_connect('destroy') {onDestroy}
		@gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
		win.add(@gtkObject)
		win.show_all
  end
end

Connexion.new
Gtk.main

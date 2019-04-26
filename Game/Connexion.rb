# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   8-Mar-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: Connexion.rb
# @Last modified by:   zeigon
# @Last modified time: 26-Apr-2019

def require_all(_dir)
	Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each { |file|
		require file
	}
end


require 'gtk3'
require_all("Ui")
require File.dirname(__FILE__) + "/TestGame"
require File.dirname(__FILE__) + "/Ui/Constants"
require File.dirname(__FILE__) + "/Core/DB/ConnectDB"
require File.dirname(__FILE__) + "/Ui/AssetsLoaderClass/IconAsset"


class Connexion

  def initialize()
    screen=Constants::SCREEN
		@pad=screen.height*0.002
		@police=screen.height*0.016
		@ic=IconAsset.new
		@h=screen.height*0.4
		@w=screen.width*0.4

		connect=ConnectDB.new
		@@joueur=nil
    @@win = Gtk::Window.new
    @@win.set_default_size(@w,@h)
    @@win.set_resizable(false)
		@@win.decorated=false
    @@win.window_position= :center_always
		@@win.icon=GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/../Assets/Icons/tent.jpeg")
		@@win.show_all

    @menu=Gtk::Box.new(:vertical, 25)

  	@gtkObject= Gtk::Table.new(3,3)
		@gtkObject.attach(@menu,1,2,1,2)

		@buffer = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/../Assets/Backgrounds/nature.jpg")
		@buffer=@buffer.scale(@w,@h+100)

    @image=Gtk::EventBox.new()

    log = Text.new("LOGIN",@police)
		log.color="black"
    mdp = Text.new("PASSWORD",@police)
		mdp.color="black"
		log.apply
		mdp.apply
    ident = Text.new("SIGN IN",@police)
		inscription =Text.new("SIGN UP",@police)
		mdpOublie=Text.new("FORGOT PASSWORD",@police)

    quitter=@ic.iconAsset.fetch(:quitter)
    quitter.resize(20,20)
		quitter.applyOn(@image)

		saisi=Gtk::Entry.new()
    saisi2=Gtk::Entry.new()
		saisi2.visibility=false

    @menu.pack_start(@image,expand: false, fill: true, padding: @pad)
    @menu.pack_start(log.gtkObject,expand: false, fill: true, padding: @pad)
    @menu.pack_start(saisi,expand: false, fill: true, padding: @pad)
    @menu.pack_start(mdp.gtkObject,expand: false, fill: true, padding: @pad)
    @menu.pack_start(saisi2,expand: false, fill: true, padding: @pad)
    @menu.pack_start(ident.gtkObject,expand: false, fill: true, padding: @pad)
		@menu.pack_start(mdpOublie.gtkObject,expand: false, fill: true, padding: @pad)
		@menu.pack_start(inscription.gtkObject,expand: false, fill: true, padding: @pad)

  	# win.add(@#)
    @@win.signal_connect('destroy') {Gtk.main_quit}
		@gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
		@@win.add(@gtkObject)
		@@win.show_all


		@image.signal_connect('button_press_event' ) {
			Gtk.main_quit
		}
	  @image.signal_connect("enter_notify_event") { |widget, event|
	    @image.window.set_cursor(Click::CURSORIN) unless @image.window == nil
	  }
	  @image.signal_connect("leave_notify_event") { |widget, event|
	    @image.window.set_cursor(Click::CURSOROUT) unless @image.window == nil
	  }

		mdpOublie.onClick{
				MotdepasseOublie.new
		}

		ident.onClick{
			@@joueur=connect.playerConnect(saisi.text,saisi2.text)
			if(@@joueur!=nil)
				@@win.hide
				TestGame.new
			else
				ProblemeIdent.new
				saisi.set_text("")
				saisi2.set_text("")
			end
		}

		inscription.onClick{
			if(connect.isPlayerExist(saisi.text)!=nil)
				Probleme.new
				saisi.set_text("")
				saisi2.set_text("")
			elsif connect.isPlayerExist(saisi.text)==nil
				@@joueur=connect.createPlayer(saisi.text, saisi2.text)
				@@win.hide
				TestGame.new
			end

		}

  end

	def Connexion.connexion(player)
		@@joueur=player
		@@win.hide
		TestGame.new
	end

	def Connexion.getJoueur
			return @@joueur
	end

	def Connexion.show
			@@win.show_all
	end
end

Connexion.new
Gtk.main

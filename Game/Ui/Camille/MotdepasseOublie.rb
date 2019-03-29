# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   8-Mar-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: Connexion.rb
# @Last modified by:   maxime
# @Last modified time: 29-Mar-2019

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
		win.decorated=false
    win.window_position= :center_always
		win.icon=GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/../../../Assets/Icons/tent.jpeg")


    connect=ConnectDB.new

  	@menu=Gtk::Box.new(:vertical, 25)
		saisiLogin = Gtk::Entry.new()
    saisi=Gtk::Entry.new()
    saisi2=Gtk::Entry.new()
    take = Text.new("SAISIR")
		name = Text.new("Name")
		password = Text.new("New Password")
		confirmPass = Text.new("Confirm Password")
		confirm =Text.new("Confirmer")

    @menu.pack_start(take.gtkObject,expand: false, fill: true, padding: @pad)
		@menu.pack_start(name.gtkObject, expand: false, fill: true, padding: @pad)
		@menu.pack_start(saisiLogin, expand: false, fill: true, padding: @pad)
		@menu.pack_start(password.gtkObject, expand: false, fill: true, padding: @pad)
    @menu.pack_start(saisi,expand: false, fill: true, padding: @pad)
  #  @menu.pack_start(mdp,expand: false, fill: true, padding: @pad)
		@menu.pack_start(confirmPass.gtkObject,expand: false, fill: true, padding: @pad)
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



		buffer = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/../../../Assets/Backgrounds/nature.png")
		buffer=buffer.scale(500,500)
		chose = Gtk::Table.new(3,3)
		chose.attach(@menu,1,2,1,2)
		chose.attach(Gtk::Image.new(pixbuf: buffer),0,3,0,3)

		win.add(chose)

    win.show_all

  end
end

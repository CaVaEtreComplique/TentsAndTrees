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
require File.dirname(__FILE__) + "/../../../Core/DB/ConnectDB"



##
# ===== Presentation
#MotdepasseOublie only needs to be initialized.
#It creates and implements a pop up to redefine your password
##


class MotdepasseOublie
	#
	#=====Presentation
	#This method is used to create the pop up to redefine your password.
	#All the other variable are used for the layout.
	#
  def initialize()
    screen=Gdk::Screen.default
		@textManager=XmlReader.instance
		@ic=IconAsset.new
		@pad=screen.height*0.002
 	 	@police=screen.height*0.02
    win = Gtk::Window.new
		w=screen.width
		h=screen.height
    win.set_default_size(w*0.4,h*0.7)
    win.set_resizable(false)
		win.decorated=false
		win.icon=GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/../../../../Assets/Icons/tent.jpeg")
    win.window_position= :center_always

    connect=ConnectDB.new
		@image=Gtk::EventBox.new()
  	@menu=Gtk::Box.new(:vertical, 25)
		saisiLogin = Gtk::Entry.new()
    saisi=Gtk::Entry.new()
    saisi2=Gtk::Entry.new()

		name = Text.new(@textManager.getScreenTexts("forgotpass" , "name"))
		password = Text.new(@textManager.getScreenTexts("forgotpass" , "pass"))
		confirmPass = Text.new(@textManager.getScreenTexts("forgotpass" , "confirmpass"))
		confirm = Text.new(@textManager.getScreenTexts("forgotpass" , "confirmform"))

		quitter=Asset.new(File.dirname(__FILE__) + "/../../../../Assets/Icons/cancel.png")
    quitter.resize(20,20)
		quitter.applyOn(@image)

		@menu.pack_start(@image,expand: false, fill: true, padding: @pad)
		@image.signal_connect('button_press_event' ) {
			win.hide
		}

		@menu.pack_start(name.gtkObject, expand: false, fill: true, padding: @pad)
		@menu.pack_start(saisiLogin, expand: false, fill: true, padding: @pad)
		@menu.pack_start(password.gtkObject, expand: false, fill: true, padding: @pad)
    @menu.pack_start(saisi,expand: false, fill: true, padding: @pad)
		@menu.pack_start(confirmPass.gtkObject,expand: false, fill: true, padding: @pad)
	  @menu.pack_start(saisi2,expand: false, fill: true, padding: @pad)
		@menu.pack_start(confirm.gtkObject,expand: false, fill: true, padding: @pad)
		confirm.onClick{
    	if(saisi.text !=saisi2.text)
      	saisi.set_text("")
      	saisi2.set_text("")
    	else
				win.hide
				Connexion.connexion(connect.playerUpdate(saisiLogin.text, saisi.text))
			end
		}



		buffer = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/../../../../Assets/Backgrounds/nature.jpg")
		buffer=buffer.scale(w*0.4,h*0.7)
		chose = Gtk::Table.new(3,3)
		chose.attach(@menu,1,2,1,2)
		chose.attach(Gtk::Image.new(pixbuf: buffer),0,3,0,3)

		win.add(chose)

    win.show_all

  end
end

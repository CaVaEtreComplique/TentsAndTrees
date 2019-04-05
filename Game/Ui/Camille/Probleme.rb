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


class Probleme
  def onDestroy
     Gtk.main_quit
  end
  def initialize()
    screen=Gdk::Screen.default
		#Variable pour resize le texte
		@pad=screen.height*0.03
		@police=screen.height*0.025
		w=screen.width
		h=screen.height
    win = Gtk::Window.new
    win.set_default_size(w/4,h/10)
    win.set_resizable(false)
		#win.decorated=false
    win.window_position= :center_always

		@menu=Gtk::Box.new(:vertical, 25)
		@gtkObject= Gtk::Table.new(3,3)
		@gtkObject.attach(@menu,1,2,1,2)

		@buffer = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/../../../Assets/Backgrounds/nature.png")
		@buffer=@buffer.scale(w/4,h/10)

    pb = Text.new("Identifiant indisponible",@police)
		pb.colorChange("red")
    @menu.pack_start(pb.gtkObject,expand: false, fill: true, padding: @pad)

		@gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
		win.add(@gtkObject)
		win.show_all
  end
end

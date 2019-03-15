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


class ProblemeIdent
  def onDestroy
     Gtk.main_quit
  end
  def initialize()
    screen=Gdk::Screen.default
		#Variable pour resize le texte
	  @pad =8
    win = Gtk::Window.new
    win.set_default_size(150,150)
    win.set_resizable(false)

  	@menu=Gtk::Box.new(:vertical, 25)

    pb = Text.new("Identifiant introuvable et mot de passe incorrecte",0.5,0.3)
    @menu.pack_start(pb.gtkObject,expand: false, fill: true, padding: @pad)
    win.add(@menu)
    win.show_all

  end
end

require 'gtk3'
require File.dirname(__FILE__) + "/ModeDeJeu"
require File.dirname(__FILE__) + "/../Screens/Screen"
require File.dirname(__FILE__) + "/../Buttons/Button"

def require_all(_dir)
	Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each { |file|
		require file
	}
end

class Parametre < Screen
  def initialize(manager)
    @pad =10
    super(manager.win)
    screen=Gdk::Screen.default
    #menuV=box verticale
    @gtkObject= Gtk::Table.new(3,3)
    @menu=Gtk::Box.new(:vertical, 100)
    @gtkObject.attach(@menu,1,2,1,2)


    titre=Text.new("Parametre",screen.width*0.10,screen.height*0.08)
		@menu.pack_start(titre.gtkObject ,expand: false, fill: true, padding: @pad)

    #Menu deroulant des langues
    fr ="Francais"
    ang="Anglais"
    langue=Gtk::ComboBoxText.new
  #  @menu.pack_start(langue.gtkObject ,expand: false, fill: true, padding: 10)
    @menu.add(langue=Gtk::ComboBoxText.new)
    langue.append_text(fr)
    langue.append_text(ang)



    appli=Text.new("Appliquer",screen.width*0.08,screen.height*0.05)
    @menu.pack_start(appli.gtkObject ,expand: false, fill: true, padding:@pad)
    appli.onClick{
      #Changement de langue
    }

    retour=Text.new("retour",screen.width*0.08,screen.height*0.05)
    @menu.pack_start(retour.gtkObject ,expand: false, fill: true, padding: @pad)
    retour.onClick{
        manager.mainScreen.applyOn(@parent)
    }

  @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)

  end
end

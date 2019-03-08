
# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   8-Feb-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: Parametre.rb
# @Last modified by:   <QuentinGoncalves>
# @Last modified time: 08-March-2019# @Last modified time: 5-Mar-2019

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

    super(manager.win)
			#Variable de l'ecran
    screen=Gdk::Screen.default
		#Variable pour resize le texte
	  @pad =10
		@widthTitre=screen.width*0.10
    @heightTitre=screen.height*0.08
    @widthText=screen.width*0.08
    @heightText=screen.height*0.05

    @gtkObject= Gtk::Table.new(3,3)
    @menu=Gtk::Box.new(:vertical, 100)
    @gtkObject.attach(@menu,1,2,1,2)

  #Bontons de menu
    titre=Text.new(@textManager.getScreenTexts("settings" , "title"),@widthTitre,@heightTitre)
		@menu.pack_start(titre.gtkObject ,expand: false, fill: true, padding: @pad)

    #Menu deroulant des langues
    fr ="Francais"
    ang="Anglais"
    langue=Gtk::ComboBoxText.new
  #  @menu.pack_start(langue.gtkObject ,expand: false, fill: true, padding: 10)
    @menu.add(langue=Gtk::ComboBoxText.new)
    langue.append_text(fr)
    langue.append_text(ang)



    appli=Text.new(@textManager.getButtonLabel("settings" , "apply"),@widthText,@heightText)
    @menu.pack_start(appli.gtkObject ,expand: false, fill: true, padding:@pad)
    appli.onClick{
      #Changement de langue
    }

    retour=Text.new(@textManager.getButtonLabel("settings" , "back"),@widthText,@heightText)
    @menu.pack_start(retour.gtkObject ,expand: false, fill: true, padding: @pad)
		#Renvoie sur la page principale
    retour.onClick{
        manager.mainScreen.applyOn(@parent)
    }
		#Fond d'ecran
  @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)

  end
end

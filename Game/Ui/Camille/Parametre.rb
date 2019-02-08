require 'gtk3'
require File.dirname(__FILE__) + "/ModeDeJeu"
require File.dirname(__FILE__) + "/../Screens/Screen"
require File.dirname(__FILE__) + "/../Buttons/Button"

class Parametre < Screen
  def initialize(parent)
    super(parent)
    #menuV=box verticale
    @gtkObject=Gtk::Box.new(:vertical, 100)
    #Premiere case : titre
    titre= "<span font_desc=\"menu\">Parametre </span>\n"
    monLabel=Gtk::Label.new()
    monLabel.set_markup(titre)
    @gtkObject.add(monLabel)

    #Menu deroulant des langues
    fr ="Francais"
    ang="Anglais"
    @gtkObject.add(langue=Gtk::ComboBoxText.new)
    langue.append_text(fr)
    langue.append_text(ang)



    appli=Button.new(:horizontal,"Appliquer")
    @gtkObject.add(appli.gtkObject)

    retour=Button.new(:horizontal,"retour")
    @gtkObject.add(retour.gtkObject)
    retour.onClick{
        FenetrePrinc.new(@parent).applyOn(@gtkObject)
    }



end
end


# @Author: Corentin Huaulmé <CorentinHuaulme>
# @Date:   25-Jan-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: FenetrePrinc.rb
# @Last modified by:   <QuentinGoncalves>
# @Last modified time: 08-Mar-2019

require 'gtk3'
require File.dirname(__FILE__) + "/Screen"
require File.dirname(__FILE__) + "/../Buttons/Text"
require File.dirname(__FILE__) + "/../Buttons/Button"

class HighScoresScreen < Screen
  def initialize(manager) #:nodoc:
    super(manager.win)
    screen=Gdk::Screen.default
    #Variable pour resize le texte
    @pad=30
    @widthTitre=screen.width*0.10
    @heightTitre=screen.height*0.08
    @widthText=screen.width*0.15
    @heightText=screen.height*0.04

    @menuBase = Gtk::Box.new(:vertical)
    @gtkObject= Gtk::Table.new(4,9)
    @menuV=Gtk::Box.new(:horizontal)
    @gtkObject.attach(@menuBase,1,2,0,1)

    db = ConnectDB.new()

    db.getPlayerHighScoreByGamemodeDiff("timeAttack","easy",Connexion.getJoueur)

    titre=Text.new(@textManager.getButtonLabel("main" , "score"))

    timeAttackArea = Gtk::Box.new(:horizontal)
    quickplayArea = Gtk::Box.new(:horizontal)
    adventureArea = Gtk::Box.new(:horizontal)

    timeAttackLabel=Text.new(@textManager.getButtonLabel("gamemode" , "timeattack"))
    quickPlayLabel=Text.new(@textManager.getButtonLabel("gamemode" , "quick"))
    adventureLabel=Text.new(@textManager.getButtonLabel("gamemode" , "adventure"))
    #add sur gtkObject
    @gtkObject.attach(titre.gtkObject ,0,2,0,2)

    @boxHighScore=Gtk::Box.new(:vertical)

    @boxLabel=Gtk::Box.new(:horizontal)
    @menuV.add(timeAttackArea)
    @menuV.add(quickplayArea)
    @menuV.add(adventureArea)
    #@boxHighScore.pack_start(@boxLabel,expand: true, fill: true, padding: @pad)

    timeAttackArea.pack_start(timeAttackLabel.gtkObject,expand: true, fill:true, padding: @pad)
    quickplayArea.pack_start(quickPlayLabel.gtkObject,expand: true, fill:true, padding: @pad)
    adventureArea.pack_start(adventureLabel.gtkObject,expand: true, fill:true, padding: @pad)

    @boxHGTA = Gtk::Box.new(:vertical)
    @rowTA = Gtk::Box.new(:horizontal)
    @rowTA.pack_start(Gtk::Label.new("Jaco le BG"),expand: true, fill: true, padding: @pad)
    @rowTA.pack_start(Gtk::Label.new("322"),expand: true, fill: true, padding: @pad)

    @boxHGTA.pack_start(@rowTA,expand: true, fill: true, padding: @pad)

    @boxHighScore.pack_start(@boxHGTA,expand: true, fill: true, padding: @pad)

    #image de fond
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)

  end
end

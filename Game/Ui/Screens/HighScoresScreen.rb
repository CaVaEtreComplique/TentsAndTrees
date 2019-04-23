
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

    easy = db.getHighScoresByGamemodeDiff("quickplay","easy")
    medium = db.getHighScoresByGamemodeDiff("quickplay","medium")
    hard = db.getHighScoresByGamemodeDiff("quickplay","hard")

    ta = db.getHighScoresByGamemodeDiff("timeAttack","easy")
    adventure = db.getHighScoresByGamemodeDiff("adventure","easy")

    titre=Text.new(@textManager.getButtonLabel("main" , "score"))

    timeAttackArea = Gtk::Box.new(:vertical)
    quickplayArea = Gtk::Box.new(:vertical)
    adventureArea = Gtk::Box.new(:vertical)
    difficultyArea = Gtk::Box.new(:horizontal)
    easyArea = Gtk::Box.new(:vertical)
    mediumArea = Gtk::Box.new(:vertical)
    hardArea = Gtk::Box.new(:vertical)

    timeAttackLabel=Text.new(@textManager.getButtonLabel("gamemode" , "timeattack"))
    quickPlayLabel=Text.new(@textManager.getButtonLabel("gamemode" , "quick"))
    adventureLabel=Text.new(@textManager.getButtonLabel("gamemode" , "adventure"))


    easyLabel=Text.new(@textManager.getButtonLabel("difficulty","easy"))
    mediumLabel=Text.new(@textManager.getButtonLabel("difficulty","normal"))
    hardLabel=Text.new(@textManager.getButtonLabel("difficulty","hard"))

    easyArea.pack_start(easyLabel.gtkObject,expand: true, fill:true, padding: @pad)
    mediumArea.pack_start(mediumLabel.gtkObject,expand: true, fill:true, padding: @pad)
    hardArea.pack_start(hardLabel.gtkObject,expand: true, fill:true, padding: @pad)


    easy.each{ |hg|
        easyArea.pack_start(Text.new("#{hg.player_highScores.name_player} : #{hg.score_highScores}").gtkObject,expand: true, fill:true, padding: @pad)
        p hg
    }
    medium.each{ |hg|
        mediumArea.pack_start(Text.new("#{hg.player_highScores.name_player} : #{hg.score_highScores}").gtkObject,expand: true, fill:true, padding: @pad)
        p hg
    }
    hard.each{ |hg|
        hardArea.pack_start(Text.new("#{hg.player_highScores.name_player} : #{hg.score_highScores}").gtkObject,expand: true, fill:true, padding: @pad)
        p hg
    }


    difficultyArea.pack_start(easyArea,expand:true, fill:true, padding:@pad)
    difficultyArea.pack_start(mediumArea,expand:true, fill:true, padding:@pad)
    difficultyArea.pack_start(hardArea,expand:true, fill:true, padding:@pad)


    #add sur gtkObject
    @menuBase.add(titre.gtkObject)

    @boxHighScore=Gtk::Box.new(:vertical)

    @boxLabel=Gtk::Box.new(:horizontal)
    @menuV.add(timeAttackArea)
    @menuV.add(quickplayArea)
    @menuV.add(adventureArea)
    #@boxHighScore.pack_start(@boxLabel,expand: true, fill: true, padding: @pad)

    timeAttackArea.pack_start(timeAttackLabel.gtkObject,expand: true, fill:true, padding: @pad)
    quickplayArea.pack_start(quickPlayLabel.gtkObject,expand: true, fill:true, padding: @pad)
    adventureArea.pack_start(adventureLabel.gtkObject,expand: true, fill:true, padding: @pad)
    quickplayArea.pack_start(difficultyArea,expand:true, fill:true, padding:@pad)

    @boxHGTA = Gtk::Box.new(:vertical)
    @rowTA = Gtk::Box.new(:horizontal)
    @rowTA.pack_start(Gtk::Label.new("Jaco le BG"),expand: true, fill: true, padding: @pad)
    @rowTA.pack_start(Gtk::Label.new("322"),expand: true, fill: true, padding: @pad)

    @boxHGTA.pack_start(@rowTA,expand: true, fill: true, padding: @pad)

    @boxHighScore.pack_start(@boxHGTA,expand: true, fill: true, padding: @pad)


    @menuBase.add(@menuV)
    #image de fond
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)

  end
end

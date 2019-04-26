
# @Author: Corentin Huaulmé <CorentinHuaulme>
# @Date:   25-Jan-2019
# @Email:  corentin.huaulme.etu@univ-lemans.fr
# @Filename: HighScoresScreen.rb
# @Last modified by:   <HuaulmeCorentin>
# @Last modified time: 26-Avr-2019

require 'gtk3'
require File.dirname(__FILE__) + "/Screen"
require File.dirname(__FILE__) + "/../Buttons/Text"
require File.dirname(__FILE__) + "/../Buttons/Button"


##
# ===== Presentation
# HighScoresScreen is an inherited class from the Screen class. This class only needs
# to be initialized and refreshed.
# It creates and implements the high scores screen from the game by adding the high scores.
class HighScoresScreen < Screen

  ##
  # ===== Presentation
  # This method is used to create the high scores screen by calling the class ConnectDB.
  # All high scores will be loaded using the ConnectDB class.
  # A scrollable area is also created by calling the class ScrollableArea, which contains boxes.
  # The boxes contains the high scores.
  # All the other variable are used for the layout.
  #
  # ===== Attributes
  # *+manager+ - managerUi who handles the Ui
  def initialize(manager)
    super(manager.win)
    screen=Gdk::Screen.default
    #Variable pour resize le texte
    @pad=10
    @widthTitre=screen.width*0.10
    @heightTitre=screen.height*0.08
    @widthText=screen.width*0.15
    @heightText=screen.height*0.04

    @menuBase = Gtk::Box.new(:vertical)
    @gtkObject= Gtk::Table.new(4,9)
    @menuScores=Gtk::Box.new(:horizontal)
    @menuLabel = Gtk::Box.new(:horizontal)
    @gtkObject.attach(@menuBase,1,2,0,1)
    @gridScores=Gtk::Table.new(5,2)
    a=Gtk::Alignment.new(0.5,1,0,1)



    @menu=Gtk::Box.new(:vertical)

    db = ConnectDB.new()

    easy = db.getHighScoresByGamemodeDiff("quickplay","easy")
    medium = db.getHighScoresByGamemodeDiff("quickplay","medium")
    hard = db.getHighScoresByGamemodeDiff("quickplay","hard")

    qp = easy+medium+hard

    qp.sort{ |a,b|
      a.score_highScores <=> b.score_highScores
    }


    ta = db.getHighScoresByGamemodeDiff("timeAttack","random")
    adventure = db.getHighScoresByGamemodeDiff("adventure","easy")


    ta.sort{ |a,b|
        a.score_highScores <=> b.score_highScores
    }

    titre=Text.new(@textManager.getButtonLabel("main" , "score"))
    titre.title

    timeAttackArea = Gtk::Box.new(:vertical)
    quickplayArea = Gtk::Box.new(:vertical)
    adventureArea = Gtk::Box.new(:vertical)
    difficultyArea = Gtk::Box.new(:vertical)

    timeAttackLabel=Text.new(@textManager.getButtonLabel("gamemode" , "timeattack"))
    quickPlayLabel=Text.new(@textManager.getButtonLabel("gamemode" , "quick"))
    adventureLabel=Text.new(@textManager.getButtonLabel("gamemode" , "adventure"))


    retour=Text.new(@textManager.getButtonLabel("save" , "back"))

    retour.onClick{
      manager.mainScreen.applyOn(@parent)
     }
     @gridScores.column_spacings=(20)
     @gridScores.attach(timeAttackLabel.gtkObject,0,1,0,1)
     @gridScores.attach(quickPlayLabel.gtkObject,2,3,0,1)
     @gridScores.attach(adventureLabel.gtkObject,4,5,0,1)

    qp.each{ |hg|
        difficultyArea.pack_start(Text.new("#{hg.player_highScores.name_player} : #{hg.score_highScores}").gtkObject,expand: true, fill:true, padding: @pad)
    }
    ta.each{ |hg|
        timeAttackArea.pack_start(Text.new("#{hg.player_highScores.name_player} : #{hg.score_highScores}").gtkObject,expand: true, fill:true, padding: @pad)
    }

    adventure.each{ |hg|
        boxAdventure = Gtk::Box.new(:horizontal)
        boxAdventure.pack_start(Star.new(1,1).gtkObject,expand: true, fill:true, padding: @pad)
        boxAdventure.pack_start(Text.new("#{hg.player_highScores.name_player} : #{hg.score_highScores}").gtkObject,expand: true, fill:true, padding: @pad)
        adventureArea.pack_start(boxAdventure,expand: true, fill:true, padding: @pad)
    }


    #add sur gtkObject
    @menuBase.add(titre.gtkObject)

    @gridScores.attach(timeAttackArea,0,1,1,2)
    @gridScores.attach(quickplayArea,2,3,1,2)
    @gridScores.attach(adventureArea,4,5,1,2)

    a.add(@gridScores)

    #@boxHighScore.pack_start(@boxLabel,expand: true, fill: true, padding: @pad)

    quickplayArea.pack_start(difficultyArea,expand:true, fill:true, padding:@pad)

    @menuBase.add(a)
    @menuBase.add(retour.gtkObject)
    #image de fond
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)

  end
end

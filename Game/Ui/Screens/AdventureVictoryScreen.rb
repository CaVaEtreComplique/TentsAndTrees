# @Author: GoncalvesQuentin <QuentinGoncalves>
# @Date:   10-Feb-2019
# @Email:  goncalves.quentin.etu@univ-lemans.fr
# @Filename: AdventureVictoryScreen.rb
# @Last modified by:   zeigon
# @Last modified time: 05-Apr-2019


require 'gtk3'
require File.dirname(__FILE__) + "/Screen"

class AdventureVictoryScreen < Screen

  def initialize(manager,session)
    @manager=manager
    super(@manager.win)
    screen = Gdk::Screen.default
    @gtkObject=Gtk::Table.new(3,3)
    @vBox=Gtk::Box.new(:vertical)
    @session=session

    @bjr = Gtk::Alignment.new(0.5, 0, 0, 0)
    @gtkObject.attach(@vBox,0,3,0,1)
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
  end

  def applyOn(widget,sScore,isWon)
    @score=sScore

    @resultText=Text.new(@textManager.getScreenTexts("victory" , "win"))
    newlab = @textManager.getScreenTexts("victory" , "score")+@score.to_s
    @scoreText=Text.new(newlab)

    @vBox.pack_start(@resultText.gtkObject, expand: false, fill: true, padding: 50)
    @vBox.pack_start(@scoreText.gtkObject, expand: false, fill: true, padding: 40)
    if !isWon
      @resultText.updateLabel(@textManager.getScreenTexts("victory" , "lose"))
      @resultText.title
    end
    if !isWon || @session.continuable?

        if @session.continuable?
          @replay=Text.new(@textManager.getButtonLabel("victory" , "continue"))
        else
          @replay=Text.new(@textManager.getButtonLabel("victory" , "retry"))
        end

        @replay.onClick{
          @session.replay(false)
          @manager.runGameSession(@session)
        }

        @vBox.pack_start(@replay.gtkObject, expand: false, fill: true, padding: 20)

        quit=Text.new(@textManager.getButtonLabel("victory" , "quit"))
        quit.onClick{
          @manager.levelNumberScreen.applyOn(@parent,@session.calculateOverallStars, @session.overAllStars,@session.levelNumber)
        }
        @vBox.pack_start(quit.gtkObject, expand: false, fill: true, padding:20)
    else
      s=Star.new(@session.maxStars,@session.calculateStars)
      @bjr.add(s.stars)
      @vBox.pack_start(@bjr,expand: false, fill: true, padding: @pad)

      @replay=Text.new(@textManager.getButtonLabel("victory" , "levelselection"))
      @replay.onClick{
        @manager.levelNumberScreen.applyOn(@parent,@session.calculateOverallStars, @session.overallStars,@session.levelNumber)
      }
      @vBox.pack_start(@replay.gtkObject, expand: false, fill: true, padding: 20)

      quit=Text.new(@textManager.getButtonLabel("victory" , "quit"))
      quit.onClick{
  			manager.session.updateSave
  			manager.updateSave
      	manager.mainScreen.applyOn(@parent)
      }
      @vBox.pack_start(quit.gtkObject, expand: false, fill: true, padding:20)
    end
    super(widget)
  end

end

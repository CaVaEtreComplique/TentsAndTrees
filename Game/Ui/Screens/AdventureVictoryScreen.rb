# @Author: GoncalvesQuentin <QuentinGoncalves>
# @Date:   10-Feb-2019
# @Email:  goncalves.quentin.etu@univ-lemans.fr
# @Filename: AdventureVictoryScreen.rb
# @Last modified by:   zeigon
# @Last modified time: 08-Apr-2019


require 'gtk3'
require File.dirname(__FILE__) + "/Screen"

##
# ===== 404
# This class was not commented in the first place, so it can not be documented.
class AdventureVictoryScreen < Screen
   # :nodoc:

  def initialize(manager,session)
    @manager=manager
    super(@manager.win)
    screen = Constants::SCREEN
		@pad=Constants::BUTTON_PADDING
    @gtkObject=Gtk::Table.new(3,3)
    @vBox=Gtk::Box.new(:vertical)
    @session=session

    @bjr = Gtk::Alignment.new(0.5, 0, 0, 0)
    @gtkObject.attach(@vBox,0,3,0,1)
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
  end

  def applyOn(widget,sScore,isWon, associatedTimer)
    @score=sScore
    @manager.session.adventureInfo.maxScore = (associatedTimer*@manager.session.levelInfo[2])
    @score = @manager.session.calculateScore(@score).truncate;

    @resultText=Text.new(@textManager.getScreenTexts("victory" , "win"))
    newlab = @textManager.getScreenTexts("victory" , "score")+@score.to_s
    @scoreText=Text.new(newlab)

    @vBox.pack_start(@resultText.gtkObject, expand: false, fill: true, padding: @pad)
    @vBox.pack_start(@scoreText.gtkObject, expand: false, fill: true, padding: @pad)
    if !isWon
      @resultText.updateLabel(@textManager.getScreenTexts("victory" , "lose"))
      @resultText.title
    end
    if !isWon || @manager.session.continuable?

        if @manager.session.continuable?
          @replay=Text.new(@textManager.getButtonLabel("victory" , "continue"))
        else
          @replay=Text.new(@textManager.getButtonLabel("victory" , "retry"))
        end

        @replay.onClick{
          @session.replay(true)
          @manager.runGameSession(@session,true)
        }

        @vBox.pack_start(@replay.gtkObject, expand: false, fill: true, padding: @pad)

        quit=Text.new(@textManager.getButtonLabel("victory" , "quit"))
        quit.onClick{
          @manager.updateHighScore
          @manager.updateSave
          @manager.levelNumberScreen.applyOn(@parent)
        }
        @vBox.pack_start(quit.gtkObject, expand: false, fill: true, padding:@pad)
    else
      s=Star.new(@manager.session.levelInfo[3],@manager.session.calculateStars,@manager.ic)
      @bjr.add(s.stars)
      @vBox.pack_start(@bjr,expand: false, fill: true, padding: @pad)

      @replay=Text.new(@textManager.getButtonLabel("victory" , "levelselection"))
      @replay.onClick{
        @manager.session.updateSave
        @manager.levelNumberScreen.applyOn(@parent)
      }
      @vBox.pack_start(@replay.gtkObject, expand: false, fill: true, padding:@pad)

      quit=Text.new(@textManager.getButtonLabel("victory" , "quit"))
      quit.onClick{
  			@manager.session.updateSave
  			@manager.updateSave
      	@manager.mainScreen.applyOn(@parent)
      }
      @vBox.pack_start(quit.gtkObject, expand: false, fill: true, padding:@pad)
    end
    super(widget)
  end

end

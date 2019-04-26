# @Author: Maxime Touze <Maxime>
# @Date:   11-Apr-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: TutorialVictoryScreen.rb
# @Last modified by:   Sckylle
# @Last modified time: 24-Apr-2019

require 'gtk3'
require File.dirname(__FILE__) + "/Screen"

class TutorialVictoryScreen < Screen

  def initialize(manager,session)
    @manager=manager
    super(@manager.win)
    @pad=Constants::BUTTON_PADDING
    screen = Gdk::Screen.default
    @gtkObject=Gtk::Table.new(3,3)
    vBox=Gtk::Box.new(:vertical)
    @session=session
    @responseText1 = Text.new(@textManager.getTutorialTexts("victory", 0))
    @responseText2 = Text.new(@textManager.getTutorialTexts("victory", 1))
    @responseText3 = Text.new(@textManager.getTutorialTexts("victory", 2))
    @responseText4 = Text.new(@textManager.getTutorialTexts("victory", 3))
    @resultText = Text.new(@textManager.getScreenTexts("victory" , "win"))
    @resultText.title

    vBox.pack_start(@resultText.gtkObject, expand: false, fill: true, padding: @pad)
    vBox.pack_start(@responseText1.gtkObject, expand: false, fill: true, padding: @pad)
    vBox.pack_start(@responseText2.gtkObject, expand: false, fill: true, padding: @pad)
    vBox.pack_start(@responseText3.gtkObject, expand: false, fill: true, padding: @pad)
    vBox.pack_start(@responseText4.gtkObject, expand: false, fill: true, padding: @pad)

    # @replay=Text.new(@textManager.getButtonLabel("victory" , "retry"))
    #
    # vBox.pack_start(@replay.gtkObject, expand: false, fill: true, padding: 20)

    quit=Text.new(@textManager.getButtonLabel("victory" , "quit"))
    quit.onClick{
      @manager.mainScreen.applyOn(@parent)
    }
    vBox.pack_start(quit.gtkObject, expand: false, fill: true, padding:30)


    Gtk::Alignment.new(0.5, 0.2, 0, 0)
    @gtkObject.attach(vBox,0,3,0,1)
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
  end

  def applyOn(widget,sScore,isWon)
    screen = Gdk::Screen.default
    if !isWon
      @resultText.updateLabel(@textManager.getScreenTexts("victory" , "lose"))
      @resultText.title
    end
    # if !isWon || !@session.continuable?
    #     @replay.updateLabel(@textManager.getButtonLabel("victory" , "retry"))
    #     @replay.onClick{
    #       @session.replay(false)
    #       @manager.runGameSession(@session)
    #     }
    # else
    #     @replay.updateLabel(@textManager.getButtonLabel("victory" , "continue"))
    #     @replay.onClick{
    #       @session.replay(true)
    #       @manager.runGameSession(@session)
    #     }
    # end
    super(widget)
  end

end

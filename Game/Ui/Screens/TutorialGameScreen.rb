# @Author: maxime-touze <Maxime>
# @Date:   08-Feb-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: TutorialGameScreen.rb
# @Last modified by:   zeigon
# @Last modified time: 26-Apr-2019



require 'gtk3'
require File.dirname(__FILE__) + "/Screen"
require File.dirname(__FILE__) + "/../GridUi"
require File.dirname(__FILE__) + "/../HelpUi"
require File.dirname(__FILE__) + "/../Buttons/Button"

class TutorialGameScreen < Screen
  @@states = [:intro, :unlockPause, :unlockGrid, :unlockUndo, :unlockRedo, :unlockFreezers, :unlockReset, :unlockHelps]

  attr_reader :gridUi

  attr_writer :helpDisplayed

  def initialize(manager,game,cellAssets,victoryScreen)

    @tutoEnd = false;
    @stape = :intro
    super(manager.win)
    (@game=game).add_observer(self)

    @victoryScreen = victoryScreen
    @pauseScreen = PauseScreen.new(self,manager,@game)

    @gridUi=GridUi.new(game, cellAssets,self)
    @gtkObject = Gtk::Table.new(4,4)

    screen=Gdk::Screen.default

    buttonHeight = screen.height*0.04
    buttonWidth = screen.width*0.3

    ProcessStatus.send(@textManager.getLoadingMessages("textures"))
    @newGuess=Text.new(@textManager.getButtonLabel("ingame" , "newguess"))

    @removeGuess=Text.new(@textManager.getButtonLabel("ingame" , "refuteguess"))

    @resetGrid=Text.new(@textManager.getButtonLabel("ingame" , "rz"))

    @undoButton=Text.new(@textManager.getButtonLabel("ingame" , "undo"))

    @redoButton=Text.new(@textManager.getButtonLabel("ingame" , "redo"))


    @helpResponseUi = Text.new ""
    @helpResponseUi.style="italic"
    @helpResponseUi.weight="normal"
    @helpResponseUi.color="red"
    @helpResponseUi.size=15
    @helpResponseUi.apply
    @helpResponseUi.setWrap(true)
    @helpResponseUi.setBackground(1,1,1,0.5)
    @help=Text.new(@textManager.getButtonLabel("ingame" , "help"))

    @pause=Text.new(@textManager.getButtonLabel("ingame" , "pause"))



    @rank =0

    @nextResponseUI = Text.new (@textManager.getTutorialTexts("level" , @rank))
    @nextResponseUI.setBackground(1,1,1,0.5)
    @rank = @rank+1
    nextStep = Text.new(@textManager.getButtonLabel("ingame" , "next"))
      nextStep.onClick(){
        if (@rank == 7)
          @tutoEnd = true
        end
        if(@rank <= 7)
          goToNextStep()
          @nextResponseUI.updateLabel("")
          @nextResponseUI.updateLabel(@textManager.getTutorialTexts("level" , @rank))
          @rank = @rank + 1
        end
      }

      @nextResponseUI.style="italic"
      @nextResponseUI.weight="normal"
      @nextResponseUI.color="red"
      @nextResponseUI.size=17
      @nextResponseUI.apply
      @nextResponseUI.setWrap(true)

##################################################################

    undoRedoBox = Gtk::Box.new(:horizontal)
    undoRedoBox.pack_start(@undoButton.gtkObject, expand: true, fill: false, padding: 3)
    undoRedoBox.pack_start(@redoButton.gtkObject, expand: true, fill: false, padding: 3)
    aliURB=Gtk::Alignment.new(0.5, 0.2, 0, 0).add(undoRedoBox)
    aliPause=Gtk::Alignment.new(1, 0.2, 0, 0).add(@pause.gtkObject)

    globalBox = Gtk::Box.new(:vertical)
    globalBox.width_request=(screen.width*0.3)
    globalBox.pack_start(aliPause, expand: true, fill: true, padding: 3)

    nextBox = Gtk::Box.new(:vertical).add(@nextResponseUI.gtkObject)
    # nextAli = Gtk::Alignment.new(0.5, 1, 0, 0).add(nextBox)

    globalBox.pack_start(aliURB, expand: true, fill: false, padding: 3)
    globalBox.pack_start(@resetGrid.gtkObject, expand: true, fill: false, padding: 3)
    globalBox.pack_start(@newGuess.gtkObject, expand: true, fill: false, padding: 3)
    globalBox.pack_start(@removeGuess.gtkObject, expand: true, fill: false, padding: 3)
    globalBox.pack_start(@help.gtkObject, expand: true, fill: false, padding: 10)
    globalBox.pack_start(nextStep.gtkObject, expand: true, fill: false, padding: 10)

    globalBoxH = Gtk::Box.new(:horizontal).add(globalBox)
    globalAli  = Gtk::Alignment.new(0.5, 0, 0, 0).add(globalBoxH)
    helpCRAli  = Gtk::Alignment.new(0.5, 0, 0, 1).add(@helpResponseUi.gtkObject)

    @gtkObject.attach(globalAli,3,4,0,1)
    @gtkObject.attach(helpCRAli,2,4,1,2)
    # @gtkObject.attach(@nextResponseUI.gtkObject,2,4,2,3)
    @gtkObject.attach(nextBox,2,4,2,3)
    # @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer2),0,4,0,4)
    @gtkObject.attach(@gridUi.gtkObject, 0, 1, 0, 4)
  end

  def gridAltered
    if helpDisplayed?
      @helpResponseUi.updateLabel ""
      @helpCR[1]
      #  Make the concerned cells normal
      @helpCR[1].each{ |cell|
          cellUi= @gridUi.cells[cell.row][cell.column]
          cellUi.normal
        }
      helpDisplayed=false
    end
  end

  def helpDisplayed?
    @helpDisplayed
  end

  def goToNextStep
    case @stape
      when :unlockReset
        @stape = :unlockHelps
        setHelpOnClick

      when :unlockFreezers
        @stape = :unlockReset
        setResetOnClick

      when :unlockRedo
        @stape = :unlockFreezers
        setFreezersOnClick

      when :unlockUndo
        @stape = :unlockRedo
        setRedoOnClick

      when :unlockGrid
        @stape = :unlockUndo
        setUndoOnClick

      when :unlockPause
        @stape = :unlockGrid
        setGridOnClick

      when :intro
        @stape = :unlockPause
        setPauseOnClick
    end
  end

#set the Reset on click function
  def setResetOnClick
    @resetGrid.onClick(){
      @game.resetGrid
      @gridUi.refresh
    }
  end


#set the Hypothesis on click function
  def setFreezersOnClick
    @newGuess.onClick(){
      @game.beginGuess
      @gridUi.refresh
    }
    ######################
    @removeGuess.onClick(){
      @game.removeGuess
      @gridUi.refresh
    }
  end

#set the Redo on click function
  def setRedoOnClick
    @redoButton.onClick(){
      @gridUi.redo
    }
  end

#set the Undo on click function
  def setUndoOnClick
    @undoButton.onClick(){
      @gridUi.undo
    }
  end

#set the Grid's cells on click function
  def setGridOnClick

  end


#set the Pause on click function
  def setPauseOnClick
    @pause.onClick(){
      @pauseScreen.applyOn(@parent)
    }
  end

#set the Help on click function
  def setHelpOnClick
    @help.onClick(){
      # Display the help message
      @helpCR=@game.help
      @helpResponseUi.updateLabel(@helpCR[0])
      self.helpDisplayed=true
      #  Make the concerned cells golw
      @helpCR[1].each{ |cell|
        cellUi= @gridUi.cells[cell.row][cell.column]
        cellUi.glowing
      }
    }
  end

  def update
    if !@parent.active?
      @pauseScreen.applyOn(@parent)
    end
    if @game.currentGuess.grid==@game.correction && @tutoEnd
      @victoryScreen.applyOn(@parent,0,true)
      @game.delete_observers
    end
  end

end

# @Author: maxime-touze <Maxime>
# @Date:   08-Feb-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: TutorialGameScreen.rb
# @Last modified by:   zeigon
# @Last modified time: 26-Apr-2019

# :nodoc:
require 'gtk3'
require File.dirname(__FILE__) + "/Screen"
require File.dirname(__FILE__) + "/../GridUi"
require File.dirname(__FILE__) + "/../HelpUi"
require File.dirname(__FILE__) + "/../Buttons/Button"
# :startdoc:

##
# ===== Presentation
# The Helper class is a helper class inherited from FictivHelper
# it's role is to help you to find where you can fill a row or column whith tents.
#
# ===== Variables
# * +states+ : class variable, all the steps of the tutorial.
# * +tutoEnd+ : instence variable, true when the tutorial is finished.
# * +step+ : instence variable, one of @@states, permises to know where we are in the tutorial's steps.
# * +victoryScreen+ : instence variable, the screen you see when you finished the tutorial
# * +rank+ : instence variable, the number of the step we are (for multilanguage)
#
# ===== Methods
# * +update+ - update the screens.
# * +gridAltered+ - Called when the grid is altered.
# * +goToNextStep+ - Permises to unlock the next step of the tutorial.
class TutorialGameScreen < Screen
  @@states = [:intro, :unlockPause, :unlockGrid, :unlockUndo, :unlockRedo, :unlockFreezers, :unlockReset, :unlockHelps]

  attr_reader :gridUi

  attr_writer :helpDisplayed


  ##
  # ===== Presentation
  # This method initialize the TutorialGameScreen.
  #
  # ===== Attributes
  # * +manager+ : help level at the start of the helps.
  # * +game+ : minimal help level of the helper.
  # * +cellAssets+ : maximal help level of the helper.
  # * +victoryScreen+ :
  #
  # ===== How to use
  # To create a TutorialGameScreen:
  #    TutorialGameScreen.new(manager,game,cellAssets,victoryScreen)
  # -----------
  def initialize(manager,game,cellAssets,victoryScreen)
# :nodoc:
    @tutoEnd = false;
    @step = :intro
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


    @help=Text.new(@textManager.getButtonLabel("ingame" , "help"))

    @pause=Text.new(@textManager.getButtonLabel("ingame" , "pause"))



    @rank =0

    @textUI = Text.new (@textManager.getTutorialTexts("level" , @rank))
    @textUI.setBackground(1,1,1,0.5)
    @rank = @rank+1
    nextStep = Text.new(@textManager.getButtonLabel("ingame" , "next"))
      nextStep.onClick(){
        if (@rank == 7)
          @tutoEnd = true
        end
        if(@rank <= 7)
          goToNextStep()
          @textUI.updateLabel("")
          @textUI.updateLabel(@textManager.getTutorialTexts("level" , @rank))
          @rank = @rank + 1
        end
      }

      @textUI.style="italic"
      @textUI.weight="normal"
      @textUI.color="red"
      @textUI.size=17
      @textUI.apply
      @textUI.setWrap(true)

##################################################################

    undoRedoBox = Gtk::Box.new(:horizontal)
    undoRedoBox.pack_start(@undoButton.gtkObject, expand: true, fill: false, padding: 3)
    undoRedoBox.pack_start(@redoButton.gtkObject, expand: true, fill: false, padding: 3)
    aliURB=Gtk::Alignment.new(0.5, 0.2, 0, 0).add(undoRedoBox)
    aliPause=Gtk::Alignment.new(1, 0.2, 0, 0).add(@pause.gtkObject)

    globalBox = Gtk::Box.new(:vertical)
    globalBox.width_request=(screen.width*0.3)
    globalBox.pack_start(aliPause, expand: true, fill: true, padding: 3)

    nextBox = Gtk::Box.new(:vertical).add(@textUI.gtkObject)

    globalBox.pack_start(aliURB, expand: true, fill: false, padding: 3)
    globalBox.pack_start(@resetGrid.gtkObject, expand: true, fill: false, padding: 3)
    globalBox.pack_start(@newGuess.gtkObject, expand: true, fill: false, padding: 3)
    globalBox.pack_start(@removeGuess.gtkObject, expand: true, fill: false, padding: 3)
    globalBox.pack_start(@help.gtkObject, expand: true, fill: false, padding: 10)
    globalBox.pack_start(nextStep.gtkObject, expand: true, fill: false, padding: 10)

    globalBoxH = Gtk::Box.new(:horizontal).add(globalBox)
    globalAli  = Gtk::Alignment.new(0.5, 0, 0, 0).add(globalBoxH)
    #helpCRAli  = Gtk::Alignment.new(0.5, 0, 0, 1).add(@helpResponseUi.gtkObject)

    @gtkObject.attach(globalAli,3,4,0,1)

    @gtkObject.attach(nextBox,2,4,3,4)
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer2),0,4,0,4)

    @gtkObject.attach(@gridUi.gtkObject, 0, 1, 0, 4)
  # :startdoc:
  end

  ##
  # ===== Presentation
  # This method is called when the grid is altered.
  #
  # ===== How to use
  # To use this:
  #    tutorialGameScreen_instance.gridAltered()
  # -----------
  def gridAltered
  # :nodoc:
    if helpDisplayed?
      @textUI.updateLabel ""
      @helpCR[1]
      #  Make the concerned cells normal
      @helpCR[1].each{ |cell|
          cellUi= @gridUi.cells[cell.row][cell.column]
          cellUi.normal
        }
      helpDisplayed=false
    end
  # :startdoc:
  end


  ##
  # ===== Presentation
  # This method returns true if help has been displayed.
  #
  # ===== Return
  # * +@helpDisplayed+ - return the instace variable whitch is a boolean.
  #
  # ===== How to use
  # To use this:
  #    tutorialGameScreen_instance.helpDisplayed?()
  # -----------
  def helpDisplayed?
  # :nodoc:
    @helpDisplayed
  # :startdoc:
  end

  ##
  # ===== Presentation
  # This method permises to go to the next Tutorial step.
  #
  # ===== How to use
  # To use this:
  #    tutorialGameScreen_instance.goToNextStep()
  # -----------
  def goToNextStep
    # :nodoc:
    case @step
      when :unlockReset
        @step = :unlockHelps
        setHelpOnClick

      when :unlockFreezers
        @step = :unlockReset
        setResetOnClick

      when :unlockRedo
        @step = :unlockFreezers
        setFreezersOnClick

      when :unlockUndo
        @step = :unlockRedo
        setRedoOnClick

      when :unlockGrid
        @step = :unlockUndo
        setUndoOnClick

      when :unlockPause
        @step = :unlockGrid
        setGridOnClick

      when :intro
        @step = :unlockPause
        setPauseOnClick
    end
  # :startdoc:
  end

  ##
  # ===== Presentation
  # This method sets the Reset on click function.
  #
  # ===== How to use
  # To set the reset on click:
  #    tutorialGameScreen_instance.setResetOnClick()
  # -----------
  def setResetOnClick
  # :nodoc:
    @resetGrid.onClick(){
      @game.resetGrid
      @gridUi.refresh
    }
  # :startdoc:
  end



  ##
  # ===== Presentation
  # This method sets the Hypothesis on click function.
  #
  # ===== How to use
  # To set the freezers on click:
  #    tutorialGameScreen_instance.setFreezersOnClick()
  # -----------
  def setFreezersOnClick
  # :nodoc:
    @newGuess.onClick(){
      @game.beginGuess
      @gridUi.refresh
    }
    ######################
    @removeGuess.onClick(){
      @game.removeGuess
      @gridUi.refresh
    }
  # :startdoc:
  end


  ##
  # ===== Presentation
  # This methods sets the Redo on click function.
  #
  # ===== How to use
  # To set the Redo on click:
  #    tutorialGameScreen_instance.setRedoOnClick()
  # -----------
  def setRedoOnClick
  # :nodoc:
    @redoButton.onClick(){
      @gridUi.redo
    }
  # :startdoc:
  end

  ##
  # ===== Presentation
  # This method sets the Undo on click function.
  #
  # ===== How to use
  # To set the undo on click:
  #    tutorialGameScreen_instance.setUndoOnClick()
  # -----------
  def setUndoOnClick
  # :nodoc:
    @undoButton.onClick(){
      @gridUi.undo
    }
  # :startdoc:
  end

  ##
  # ===== Presentation
  # This method sets the Grid's cells on click function.
  #
  # ===== How to use
  # To set the Grid's cells on click:
  #    tutorialGameScreen_instance.setGridOnClick()
  # -----------
  def setGridOnClick
  # :nodoc:
  # :startdoc:
  end

  ##
  # ===== Presentation
  # This method sets the Pause on click function.
  #
  # ===== How to use
  # To set the pause on click:
  #    tutorialGameScreen_instance.setPauseOnClick()
  # -----------
  def setPauseOnClick
  # :nodoc:
    @pause.onClick(){
      @pauseScreen.applyOn(@parent)
    }
  # :startdoc:
  end

  ##
  # ===== Presentation
  # This method sets the Help on click function.
  #
  # ===== How to use
  # To set the help on click:
  #    tutorialGameScreen_instance.setHelpOnClick()
  # -----------
  def setHelpOnClick
  # :nodoc:
    @help.onClick(){
      # Display the help message
      @helpCR=@game.help
      @textUI.updateLabel(@helpCR[0])
      self.helpDisplayed=true
      #  Make the concerned cells golw
      @helpCR[1].each{ |cell|
        cellUi= @gridUi.cells[cell.row][cell.column]
        cellUi.glowing
      }
    }
  # :startdoc:
  end

  ##
  # ===== Presentation
  # This method updates all the parents of the current screen, and the current itself.
  #
  # ===== How to use
  # To set the help on click:
  #    tutorialGameScreen_instance.update()
  # -----------
  def update
  # :nodoc:
    if !@parent.active?
      @pauseScreen.applyOn(@parent)
    end
    if @game.currentGuess.grid==@game.correction && @tutoEnd
      @victoryScreen.applyOn(@parent,0,true)
      @game.delete_observers
    end
  # :startdoc:
  end

end

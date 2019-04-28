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
# The tutorialGameScreen class is inherited from Screen.
# Its role is to show the tutorial screen.
#
# ===== Variables
# * +states+ - A class variable, all the steps of the tutorial.
# * +tutoEnd+ - An instance variable, true when the tutorial is finished.
# * +step+ - An instance variable, one of +states+, used to know where we are in the tutorial's steps.
# * +victoryScreen+ - An instance variable, the screen you see when you've finished the tutorial.
# * +rank+ - An instance variable, the number of the step we are on (for multilanguage).
#
# ===== Methods
# This class knows its initializer and the methods described below.
class TutorialGameScreen < Screen
   # :nodoc:
  @@states = [:intro, :unlockPause, :unlockGrid, :unlockUndo, :unlockRedo, :unlockFreezers, :unlockReset, :unlockHelps]

  attr_reader :gridUi

  attr_writer :helpDisplayed
  # :startdoc:


  ##
  # ===== Presentation
  # This method initializes the TutorialGameScreen.
  #
  # ===== Attributes
  # * +manager+ - The help level at the start of the helps.
  # * +game+ - The minimal help level of the helper.
  # * +cellAssets+ - The maximal help level of the helper.
  # * +victoryScreen+ - The screen shown after the tutorial's completion.
  #
  # ===== How to use
  # To create a TutorialGameScreen:
  #    TutorialGameScreen.new(manager,game,cellAssets,victoryScreen)
  def initialize(manager,game,cellAssets,victoryScreen)
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
  end


  ##
  # ===== Presentation
  # This method returns true if help has been displayed.
  #
  # ===== Return
  # * +helpDisplayed+ - Returns the instance variable whitch is a boolean.
  #
  # ===== How to use
  # To use this:
  #    tutorialGameScreen_instance.helpDisplayed?()
  # -----------
  def helpDisplayed?
    @helpDisplayed
  end

  ##
  # ===== Presentation
  # This method lets us go to the next tutorial step.
  #
  # ===== How to use
  # To use this:
  #    tutorialGameScreen_instance.goToNextStep()
  # -----------
  def goToNextStep
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
  end

  ##
  # ===== Presentation
  # This method sets the reset on click function.
  #
  # ===== How to use
  # To set the reset on click:
  #    tutorialGameScreen_instance.setResetOnClick()
  # -----------
  def setResetOnClick
    @resetGrid.onClick(){
      @game.resetGrid
      @gridUi.refresh
    }
  end



  ##
  # ===== Presentation
  # This method sets the hypothesis on click function.
  #
  # ===== How to use
  # To set the freezers on click:
  #    tutorialGameScreen_instance.setFreezersOnClick()
  # -----------
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


  ##
  # ===== Presentation
  # This method sets the redo on click function.
  #
  # ===== How to use
  # To set the redo on click:
  #    tutorialGameScreen_instance.setRedoOnClick()
  # -----------
  def setRedoOnClick
    @redoButton.onClick(){
      @gridUi.redo
    }
  end

  ##
  # ===== Presentation
  # This method sets the undo on click function.
  #
  # ===== How to use
  # To set the undo on click:
  #    tutorialGameScreen_instance.setUndoOnClick()
  # -----------
  def setUndoOnClick
    @undoButton.onClick(){
      @gridUi.undo
    }
  end

  ##
  # ===== Presentation
  # This method sets the grid's cells on click function.
  #
  # ===== How to use
  # To set the grid's cells on click:
  #    tutorialGameScreen_instance.setGridOnClick()
  # -----------
  def setGridOnClick
  end

  ##
  # ===== Presentation
  # This method sets the pause on click function.
  #
  # ===== How to use
  # To set the pause on click:
  #    tutorialGameScreen_instance.setPauseOnClick()
  # -----------
  def setPauseOnClick
    @pause.onClick(){
      @pauseScreen.applyOn(@parent)
    }
  end

  ##
  # ===== Presentation
  # This method sets the help on click function.
  #
  # ===== How to use
  # To set the help on click:
  #    tutorialGameScreen_instance.setHelpOnClick()
  # -----------
  def setHelpOnClick
    @help.onClick(){
      # Display the help message
      @helpCR=@game.help
      @textUI.updateLabel(@helpCR[0])
      self.helpDisplayed=true
      #  Make the concerned cells glow
      @helpCR[1].each{ |cell|
        cellUi= @gridUi.cells[cell.row][cell.column]
        cellUi.glowing
      }
    }
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
    if !@parent.active?
      @pauseScreen.applyOn(@parent)
    end
    if @game.currentGuess.grid==@game.correction && @tutoEnd
      @victoryScreen.applyOn(@parent,0,true)
      @game.delete_observers
    end
  end

end

# @Author: Maxime Touze <Maxime>
# @Date:   15-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: Helper.rb
# @Last modified by:   Maxime
# @Last modified time: 15-Mar-2019



#Main of the help, when you need a help, let's call Helper to help you
require File.dirname(__FILE__) + "/FictivHelper"
require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsGrassHelper"
require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsTentsHelper"
require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsFindTent"
require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsFindGrass"
require File.dirname(__FILE__) + "/CellsHelpers/CellDontTouchTreeHelper"
require File.dirname(__FILE__) + "/CellsHelpers/CellTouchATentHelper"
require File.dirname(__FILE__) + "/RecursivHelpers/AllTreesHaveTentsHelper"
require File.dirname(__FILE__) + "/RecursivHelpers/AllTreesHaveTentsHelper2"
require File.dirname(__FILE__) + "/CellsHelpers/CellWhiteOverlap"
require File.dirname(__FILE__) + "/../GameDecorated"

class Helper < FictivHelper
  #needed to be initialized at the start
  private_class_method :new

  @@helper
  @helps

  def Helper.initializor
    #Check for being a singleton
    if defined?(@@helper).nil?
      return @@helper = Helper.new
    else
      return @@helper
    end
  end

  def initialize
    #initialize with all helpers
    @helps = Array.new

    @helps.push(CellDontTouchTreeHelper.new)    # Help when a cell dont touch a tree, it will be a grass
    @helps.push(CellTouchATentHelper.new)       # Fill the cells near a Tent with grass
    @helps.push(RowsAndColumnsGrassHelper.new)  #fill a row/column whith grass when it has all this tents
    @helps.push(RowsAndColumnsTentsHelper.new)  #fill a row/column whith tents when it has all this grass
    @helps.push(RowsAndColumnsFindGrass.new)    # RowsAndColumnsFindGrass help you to find grass in a row or columns
    @helps.push(RowsAndColumnsFindTent.new)     # RowsAndColumnsFindTent help you to find Tent in a row or columns
    @helps.push(CellWhiteOverlap.new)           # Help when all possibilities give a grass cell
    @helps.push(AllTreesHaveTentsHelper2.new)   #  Place a tent for a tree that don't has his tent

  end

  def help(game) #called to help the player
    #game.beginGuess

    game = GameDecorated.new(game)

    @helps.each{ |aHelp|
      if(((helpRes = aHelp.help(game)).helpFound?))
        #game.removeGuess
        return helpRes
      end
    }
    #game.removeGuess
    return help = HelpNotFound.new
  end
end

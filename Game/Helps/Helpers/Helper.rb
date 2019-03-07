#Main of the help, when you need a help, let's call Helper to help you
require File.dirname(__FILE__) + "/FictivHelper"
require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsGrassHelper"
require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsTentsHelper"
require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsFindGrass"
require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsFindTent"
require File.dirname(__FILE__) + "/CellsHelpers/CellDontTouchTreeHelper"
require File.dirname(__FILE__) + "/CellsHelpers/CellTouchATentHelper"
require File.dirname(__FILE__) + "/../GameDecorated"

class Helper < FictivHelper
  #needed to be initialized at the start
  public_class_method :new

  @@helper
  @helps

  def Helper.initializor
    if defined?(@@helper).nil?
      return @@helper = Helper.new
    else
      return @@helper
    end
  end

  def initialize

    @helps = Array.new

    @helps.push(CellDontTouchTreeHelper.new)       #1  White cells that doesn't touch a tree are grass
    @helps.push(RowsAndColumnsGrassHelper.new)     #2  Fill a row or column whith grass if all tents have been placed
    @helps.push(RowsAndColumnsTentsHelper.new)     #3  Fill a row or column whith tent if there just enough place for tent
    @helps.push(CellTouchATentHelper.new)          #4  White cells that touch a tent are grass    @helps.push(CellTouchATentHelper.new)          #4  White cells that touch a tent are grass
    @helps.push(RowsAndColumnsFindGrass.new)       #5
    @helps.push(RowsAndColumnsFindTent.new)

  end

  def help(game) #called to help
    #game.beginGuess
    
    #game = GameDecoreted.new(game)

    @helps.each{ |aHelp|
      if(((helpRes = aHelp.help(game)).helpFound?))
        #game.removeGuess
        return helpRes
      end
    }
    return help = HelpNotFound.new
    #game.removeGuess
  end
end

#Main of the help, when you need a help, let's call Helper to help you
require File.dirname(__FILE__) + "/FictivHelper"
require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsGrassHelper"
require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsTentsHelper"
require File.dirname(__FILE__) + "/CellsHelpers/CellDontTouchTreeHelper"
require File.dirname(__FILE__) + "/CellsHelpers/CellTouchATentHelper"

class Helper < FictivHelper
  #needed to be initialized at the start
  private_class_method :new

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

    @helps.push(CellDontTouchTreeHelper.new)
    @helps.push(RowsAndColumnsGrassHelper.new)
    @helps.push(RowsAndColumnsTentsHelper.new)
    @helps.push(CellTouchATentHelper.new)

  end

  def Helper.help(game)
  end

  def help(game) #called to help
    #game.beginGuess

    @helps.each{ |aHelp|
      if(!((helpRes = aHelp.help(game)).helpFound?))
        #game.removeGuess
        return helpRes
      end
    }
    #game.removeGuess
    return help = HelpNotFound.new
end

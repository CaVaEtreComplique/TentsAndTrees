#Main of the help, when you need a help, let's call Helper to help you
require File.dirname(__FILE__) + "/FictivHelper"
require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsGrassHelper"
require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsTentsHelper"
require File.dirname(__FILE__) + "/CellsHelpers/CellDontTouchTreeHelper"
require File.dirname(__FILE__) + "/CellsHelpers/CellTouchATentHelper"
require File.dirname(__FILE__) + "/RecursivHelpers/AllTreesHaveTentsHelper"

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


    @helps.push(AllTreesHaveTentsHelper.new)
    @helps.push(CellDontTouchTreeHelper.new)
    @helps.push(RowsAndColumnsGrassHelper.new)
    @helps.push(RowsAndColumnsTentsHelper.new)
    @helps.push(CellTouchATentHelper.new)


  end

  def help(game) #called to help
    #game.beginGuess
    compt =0
    @helps.each{ |aHelp|
      if(((helpRes = aHelp.help(game)).helpFound?))
        #game.removeGuess
        return helpRes
      else
        p "pas trouve" + compt.to_s
        compt +=1
      end
    }
    #game.removeGuess
    # return help = HelpNotFound.new
  end
end

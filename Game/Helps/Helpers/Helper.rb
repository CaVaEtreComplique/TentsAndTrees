# @Author: Maxime Touze <Maxime>
# @Date:   15-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: Helper.rb
# @Last modified by:   Sckylle
# @Last modified time: 25-Apr-2019



#Main of the help, when you need a help, let's call Helper to help you
require File.dirname(__FILE__) + "/FictivHelper"
require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsGrassHelper"
require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsTentsHelper"
require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsFindTent"
require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsFindGrass"
require File.dirname(__FILE__) + "/CellsHelpers/CellDontTouchTreeHelper"
require File.dirname(__FILE__) + "/CellsHelpers/CellTouchATentHelper"
require File.dirname(__FILE__) + "/RecursivHelpers/AllTreesHaveTentsHelper"
require File.dirname(__FILE__) + "/CellsHelpers/CellWhiteOverlap"
require File.dirname(__FILE__) + "/../GameDecorated"

class Helper < FictivHelper
  #needed to be initialized at the start
  ##MODS for displaying only on game screen ( @@ONLY_UI_MOD ) or on the terminal as well ( @@DEBUG_MOD )
  @@DEBUG_MOD=1
  @@ONLY_UI_MOD=0
  @@mod = @@DEBUG_MOD
  ##Maximal and minimal level of help
  @@MAXLEVELHELP = 3
  @@MINLEVELHELP = 1
  ######################################

  @@helper
  @helps

  def initialize(helplvl = 1, lvlmin = 1, lvlmax = 3)

    @helpLevel = helplvl
    helpLevelSetMinMax(lvlmin, lvlmax)

    @lastHelp = HelpNotFound.new

    #initialize with all helpers
    @helps = Array.new

    @helps.push(CellTouchATentHelper.new)       # Fill the cells near a Tent with grass
    @helps.push(RowsAndColumnsTentsHelper.new)  # Fill a row/column whith tents when it has all this grass
    @helps.push(RowsAndColumnsGrassHelper.new)  # Fill a row/column whith grass when it has all this tents
    @helps.push(CellDontTouchTreeHelper.new)    # Help when a cell dont touch a tree, it will be a grass
    @helps.push(RowsAndColumnsFindTent.new)     # RowsAndColumnsFindTent help you to find Tent in a row or columns
    @helps.push(RowsAndColumnsFindGrass.new)    # RowsAndColumnsFindGrass help you to find grass in a row or columns
    @helps.push(CellWhiteOverlap.new)           # Help when all possibilities give a grass cell
    @helps.push(AllTreesHaveTentsHelper.new)    # Place a tent for a tree that don't has his tent
  end

  def helpLevelSetMinMax(helpLevelMin, helpLevelMax)

    if(helpLevelMin < @@MINLEVELHELP) #Set helpLevelMin
      @helpLevelMin = @@MINLEVELHELP
    elsif(helpLevelMin > @@MAXLEVELHELP)
      @helpLevelMin = @@MAXLEVELHELP
    else
      @helpLevelMin = helpLevelMin
    end

    if(helpLevelMax < @@MINLEVELHELP) #Set helpLevelMax
      @helpLevelMax = @@MINLEVELHELP
    elsif(helpLevelMax > @@MAXLEVELHELP)
      @helpLevelMax = @@MAXLEVELHELP
    else
      @helpLevelMax = helpLevelMax
    end

    if(@helpLevelMax < @helpLevelMin) #Invers if necessary
      tmp = @helpLevelMax
      @helpLevelMax = @helpLevelMin
      @helpLevelMin = tmp
    end
    # p"4"
    if(@helpLevel < helpLevelMin) #Modify helperLevel if needed
      @helpLevel = @helpLevelMin
    elsif (@helpLevel > helpLevelMax)
      @helpLevel = @helpLevelMax
    end
  end

  def helpLevelManagement(aHelp)
    if(aHelp == @lastHelp)
      if(@helpLevel < @helpLevelMax)
        @helpLevel += 1
      end
    else
      @helpLevel = @helpLevelMin
      @lastHelp = aHelp
    end
  end

  def price()
    return @lastHelp.price(@helpLevel)
  end

  def help(game) #called to help the player

    game = GameDecorated.new(game)

    @helps.each{ |aHelper|
      if(((helpRes = aHelper.help(game)).helpFound?))
        helpLevelManagement(helpRes)
        if(@@mod == @@DEBUG_MOD)
          puts "\nDebug : " + helpRes.getText(@helpLevel) + @helpLevel.to_s + "  " + helpRes.to_s + "\n"
        end
          return helpRes.getRes(@helpLevel)
      end
    }

    help = HelpNotFound.new

    if(@@mod == @@DEBUG_MOD)
      puts "\nDebug : " + help.to_s + @helpLevel.to_s + "\n"
    end
      helpLevelManagement(help)
      return help.getRes(@helpLevel)
  end
end

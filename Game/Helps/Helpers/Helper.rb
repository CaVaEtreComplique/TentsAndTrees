# @Author: Maxime Touze <Maxime>
# @Date:   15-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: Helper.rb
# @Last modified by:   Sckylle
# @Last modified time: 25-Apr-2019

require File.dirname(__FILE__) + "/FictivHelper"
require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsGrassHelper"
require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsTentsHelper"
require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsFindTent"
require File.dirname(__FILE__) + "/RowsOrColumnsHelpers/RowsAndColumnsFindGrass"
require File.dirname(__FILE__) + "/CellsHelpers/CellDontTouchTreeHelper"
require File.dirname(__FILE__) + "/CellsHelpers/CellTouchATentHelper"
require File.dirname(__FILE__) + "/RecursivHelpers/AllTreesHaveTentsHelper"
require File.dirname(__FILE__) + "/CellsHelpers/CellWhiteOverlap"
require File.dirname(__FILE__) + "/../GameDivised"

##
# ===== Presentation
# The Helper class is a helper class inherited from FictivHelper
# it's role is to help you to find where you can fill a row or column whith tents.
#
# ===== Variables
# * +MAXLEVELHELP+ : class variable, the maximum level of helps returned
# * +MINLEVELHELP+ : class variable, the minimal level of helps returned
# * +helps+ : instence variable, all the helpers known by this helper
#
# ===== Methods
# * +help+ - inherited from FictivHelper, but definded there.
# * +price+ - give the price of the last help.
class Helper < FictivHelper
  # :nodoc:
  #needed to be initialized at the start
  ##MODS for displaying only on game screen ( @@ONLY_UI_MOD ) or on the terminal as well ( @@DEBUG_MOD )
  @@DEBUG_MOD=1
  @@ONLY_UI_MOD=0
  @@mod = @@ONLY_UI_MOD
#######

  ##Maximal and minimal level of help
  @@MAXLEVELHELP = 3
  @@MINLEVELHELP = 1
######
  @@helper
  @helps

  # :startdoc:

  ##
  # ===== Presentation
  # This method initialize the helper with all the helpers he needs to know, and the helps' levels.
  #
  # ===== Attributes
  # helplvl: help level at the start of the helps.
  # lvlmin : minimal help level of the helper.
  # lvlmax : maximal help level of the helper.
  #
  # ===== How to use
  # To get a help:
  #    helper_instace.helpLevelManagement(aHelp)
  # -----------
  def initialize(helplvl = 1, lvlmin = 1, lvlmax = 3)# :nodoc:

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
  end# :startdoc:

  ##
  # ===== Presentation
  # This method sets the min and max levels of the helps gave by the helper.
  #
  # ===== Attributes
  # helpLevelMin : minimal help level of the helper
  # helpLevelMax : maximal help level of the helper
  #
  # ===== How to use
  # To get a help:
  #    helper_instace.helpLevelManagement(aHelp)
  # -----------
  def helpLevelSetMinMax(helpLevelMin, helpLevelMax)# :nodoc:

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
  end# :startdoc:

  ##
  # ===== Presentation
  # This method changes the level of the help text.
  #
  # ===== Attributes
  # aHelp : last help called
  #
  # ===== How to use
  # To get a help:
  #    helper_instace.helpLevelManagement(aHelp)
  # -----------
  def helpLevelManagement(aHelp)# :nodoc:
    if(aHelp == @lastHelp)
      if(@helpLevel < @helpLevelMax)
        @helpLevel += 1
      end
    else
      @helpLevel = @helpLevelMin
      @lastHelp = aHelp
    end
  end# :startdoc:


  ##
  # ===== Presentation
  # This method returns the cost of last help.
  #
  # ===== Returns
  # The cost in second of the las help called
  #
  # ===== How to use
  # To get a help:
  #    helper_instace.price()
  # -----------
  def price()# :nodoc:
    return @lastHelp.price(@helpLevel)
  end# :startdoc:

  ##
  # ===== Presentation
  # This method returns the help found to help the player.
  #
  # ===== Attributes
  # * +game+ - The game you want a help for.
  #
  # ===== Returns
  # The interpretable result of a help.
  #
  # ===== How to use
  # To get a help:
  #    helper_instace.help(theGameYouWantHelpFor)
  # -----------
  def help(game) # :nodoc:
    #called to help the player

    game = GameDivised.new(game)

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
  end# :startdoc:
end

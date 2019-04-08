# @Author: Maxime Touze <Maxime>
# @Date:   15-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: Help.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019

require_all(__FILE__)
##
# The help class is an abstract class. It is the general parent of all the other
# help classes in the game. To see the help classes tree, see below :
#
# https://i.imgur.com/yE9dgIb.png
#
# The classes in blue are abstract while the ones in green are concrete.
#
# This class' direct children are the HelpNotFound class and the abstract classes
# HelpOnRowsAndColumn, HelpOnCells and HelpCellsAndRowsOrColumns. This class
# knows the methods below :
class Help
  # :nodoc:
  private_class_method :new  #abstract class


  # :startdoc:
  # The class' constructor.
  # This method takes no parameters and initializes two variables :
  # * +price+ : An integer giving the cost of each help. Here, it is initialized at 5.
  # * +helpText+ : The text that will be shown every time the player needs help.
  def initialize()
    @price = 5
    @textManager = XmlReader.instance
    #Initializes the help text as what it needs to be.
    @helpText = self.getText(@helpLevel)
  end

  # :nodoc:
  attr_reader :helpText
  # :startdoc:

  # This tries to find the necessary help.
  # ===== Returns
  # Returns true if help has been found, else it returns false.
  # --------------
  def helpFound?()
    return true
  end

  # This method fetches the help text for a given help level. It is used to
  # initialize the @helpText variable in the class' constructor.
  # ===== Returns
  # Returns the help text.
  # ---------
  def getText(helpLevel)
      return @textManager.getHelpsTexts("help", 0, 0)
  end

  # This method a redefinition of the to_s method, used to print the help text.
  # ===== Returns
  # Returns the @helpText variable's value and a line break.
  # -----------
  def to_s
    return @helpText + "\n"
  end

  # This method returns the UI printable form of the help.
  # -----------
  def getRes(helpLevel)
    res = Array.new
    res.push(getText(helpLevel))
    res.push(cellsList(helpLevel))
  end

  # This method returns an array with all the important cells for the help.
  # -----------
  def cellsList(helpLevel)
    return Array.new
  end

  # This method checks the price of a given help level.
  # ===== Returns
  #  @price * helpLevel
  # The @price variable (initialized at 5) times the help level, so the prices
  # go higher as the help gets higher and the game gets easier.
  # ----------
  def price(helpLevel)
    return @price * helpLevel
  end

  # This method is a redefinition of the == method.
  # ===== Returns
  #   return (self.class == otherHelp.class)
  # A boolean telling if the two classes are equal.
  # ----------
  def ==(otherHelp)
    return (self.class == otherHelp.class)
  end
end

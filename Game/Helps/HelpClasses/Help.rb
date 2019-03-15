# @Author: Maxime Touze <Maxime>
# @Date:   15-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: Help.rb
# @Last modified by:   Maxime
# @Last modified time: 15-Mar-2019



require_all(__FILE__)
##
#The help class is an abstract class which contains a String to explain the
#help. It contains the methods helpFound? and getText and they act on the help
#text. This abstract class is the parent of every help in the game.
class Help
  # :nodoc:
  private_class_method :new  #abstract class

  # :startdoc:
  # The class' constructor.
  def initialize()
    #Initializes the help text as what it needs to be.
    @helpText = self.getText
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

  # This method fetches the help text.
  # ===== Returns
  # Returns the help text.
  # ---------
  def getText()
    return "Txt not Available"
  end

  # This method prints the help text.
  # -----------
  def to_s
    return @helpText + "\n"
  end

  # This method returns the UI printable form of the help
  # -----------
  def getRes()
    res = Array.new
    res.push(getText)
    res.push(cellsList())
  end

  # This method returns an array with all the cells important for the help
  # -----------
  def cellsList
    return Array.new
  end
end

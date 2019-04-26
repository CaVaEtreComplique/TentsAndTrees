# @Author: Gonçalves Quentin <QuentinGoncalves>
# @Date:   29-Feb-2019
# @Email:  quentin.goncalves.etu@univ-lemans.fr
# @Filename: XmlReader.rb
# @Last modified by:   maxime
# @Last modified time: 08-Apr-2019

require 'nokogiri'
require 'active_support/core_ext/hash/conversions'

##
# ==== Presentation
# The XmlReader class is here to read every necessary information inside the XML
# file. The XML file contains all the language data such as every word or phrase
# in the game in the language we want. This reader gets the informations and
# applies them to the game.
#
# ==== Variables
# * +language+ : The language variable determines the game's language.
#
# ==== Methods
# This class contains 5 methods, each described further down.
class XmlReader
  include Singleton
  #:nodoc:
  attr_writer :language
  attr_reader :language
  #:startdoc:

  # ===== Presentation
  # The initialization method reads the XML document, which is converted into a
  # HashTable indented by element.
  # Here is also defined the game's language.
  ##
  def initialize()
    xmlDoc = Nokogiri::XML(File.read("../Assets/Files/Languages/lang.xml"))
    @xmlHash = Hash.from_xml(xmlDoc.to_s)
    @language = "English"
  end


  ##
  # ===== Presentation
  # The getButtonLabel method fetches the label of a button according to the
  # current screen and its key.
  #
  # ===== Attributes
  # * +currentLevel+ : The screen that we are in.
  # * +key+ : The key of the button label we want.
  #
  # ===== Returns
  # This method returns the label of the button wanted.
  ##
  def getButtonLabel(currentScreen, key)
     return @xmlHash.fetch("languages").fetch(@language).fetch("screen").fetch(currentScreen).fetch("buttons").fetch(key)
  end


  # ===== Presentation
  # The getScreentexts method fetches a text according to the current screen
  # and its key.
  #
  # ===== Attributes
  # * +currentLevel+ : The screen that we are in.
  # * +key+ : The key of the button label we want.
  #
  # ===== Returns
  # This method returns the text that we want according to the current screen
  # and the key.
  ##
  def getScreenTexts(currentScreen, key)
    return @xmlHash.fetch("languages").fetch(@language).fetch("screen").fetch(currentScreen).fetch("texts").fetch(key)
  end

  # ===== Presentation
  # The getHelpTexts method fetches a text according to a key and the position
  # of a delimiter (here we use ";"). This way it is possible to divide the text
  # and put values between it.
  #
  # ===== Attributes
  # * +help+ : The help that we want.
  # * +helpLevel+ : The level of the help.
  # * +delimiterPosition+ : Use to introduce variable between those delemiters.
  #
  # ===== Returns
  # This method returns the text that we want according to the help, its level
  # and its position depending on the delemiter.
  ##
  def getHelpsTexts(help, helpLevel, delimiterPosition)
      temp = String.new
      temp = @xmlHash.fetch("languages").fetch(@language).fetch("helps").fetch(help).fetch("lvl" + helpLevel.to_s)
      return temp.split(";")[delimiterPosition]
  end

  # ===== Presentation
  # The getTutorialTexts method fetches a text according to the current
  # tutorial level and its step.
  #
  # ===== Attributes
  # * +currentLevel+ : The level that we want.
  # * +helpLevel+ : The step of the tutorial.
  #
  # ===== Returns
  # This method returns the text that we want according to current level and his
  # steps.
  ##
  def getTutorialTexts(currentLevel, step)
    return @xmlHash.fetch("languages").fetch(@language).fetch("tutorial").fetch(currentLevel).fetch("step" + step.to_s)
  end

  ##
  # The getLoadingMessages method fetches a loading text message according to the key
  #
  def getLoadingMessages(key)
    return @xmlHash.fetch("languages").fetch(@language).fetch("loadingmessages").fetch(key)
  end

  def getRules(number)
    return @xmlHash.fetch("languages").fetch(@language).fetch("rules").fetch("rule" + number.to_s)
  end

  ##
  # The buttonMaxString method returns the length of the longest label of a
  # button in a screen.
  #
  def buttonMaxString(currentScreen)
    longest = Array.new
    @xmlHash.fetch("languages").fetch(@language).fetch("screen").fetch(currentScreen).fetch("buttons").each_value{
    |v| longest.push(v) }
    longest.sort_by!(&:length).reverse!
    return longest[0]
  end

  def getLanguages
    tab = Array.new
    @xmlHash.fetch("languages").each_value{ |v|
      tab.push(v.fetch("language"))
    }
    return tab
    end

end

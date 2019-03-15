# @Author: Gonçalves Quentin <QuentinGoncalves>
# @Date:   29-Feb-2019
# @Email:  quentin.goncalves.etu@univ-lemans.fr
# @Filename: XmlReader.rb
# @Last modified by:   <QuentinGoncalves>
# @Last modified time: 14-March-2019

require 'nokogiri'
require 'active_support/core_ext/hash/conversions'

class XmlReader
  include Singleton
  attr_writer :language

  ##
  # Read the XML document that contain all the text needed in the gamemode
  # This file is convert into a HashTable wich is indent by element
  # Here is also defined the language of the game
  ##
  def initialize()
    xmlDoc = Nokogiri::XML(File.read("../Assets/Files/Languages/xmlDoc.xml"))
    @xmlHash = Hash.from_xml(xmlDoc.to_s)
    @language = "english"
  end

  ##
  # Fetch the button label of a button according to the current screen and its key
  ##
  def getButtonLabel(currentScreen, key)
     return @xmlHash.fetch("languages").fetch(@language).fetch("screen").fetch(currentScreen).fetch("buttons").fetch(key)
  end

  ##
  # Fetch a text according to the current screen and its key
  ##
  def getScreenTexts(currentScreen, key)
    return @xmlHash.fetch("languages").fetch(@language).fetch("screen").fetch(currentScreen).fetch("texts").fetch(key)
  end

  ##
  # Fetch a text according to a key and the position of a delimiter (here ";")
  # This way it is possible to divide the text and put values between it
  ##
  def getHelpsTexts(key, delimiterPosition)
      temp = String.new
      temp = @xmlHash.fetch("languages").fetch(@language).fetch("helps").fetch(key)
      return temp.split(";")[delimiterPosition]
  end

  ##
  # Return the length of the longest label of a button in a screen
  ##
  def buttonMaxString(currentScreen)
    longest = Array.new
    @xmlHash.fetch("languages").fetch(@language).fetch("screen").fetch(currentScreen).fetch("buttons").each_values{
    |v| longest.push(v) }
    longest.sort_by!(&:length).reverse!
    return longest[0]
  end

end

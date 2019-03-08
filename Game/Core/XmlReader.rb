# @Author: Gonçalves Quentin <QuentinGoncalves>
# @Date:   29-Feb-2019
# @Email:  quentin.goncalves.etu@univ-lemans.fr
# @Filename: XmlReader.rb
# @Last modified by:   <QuentinGoncalves>
# @Last modified time: 08-March-2019

require 'nokogiri'
require 'active_support/core_ext/hash/conversions'

class XmlReader
  def initialize()
    xmlDoc = Nokogiri::XML(File.read("../Assets/Files/Languages/xmlDoc.xml"))
    @xmlHash = Hash.from_xml(xmlDoc.to_s)
    @language = "french"
  end

  def getButtonLabel(currentScreen, key)
     return @xmlHash.fetch("languages").fetch(@language).fetch("screen").fetch(currentScreen).fetch("buttons").fetch(key)
  end

  def getScreenTexts(currentScreen, key)
    return @xmlHash.fetch("languages").fetch(@language).fetch("screen").fetch(currentScreen).fetch("texts").fetch(key)
  end

  def setLanguage(l)
    @language = l
  end

  def buttonMaxString(currentScreen)
    longest = Array.new
    @xmlHash.fetch("languages").fetch(@language).fetch("screen").fetch(currentScreen).fetch("buttons").each_values{
    |v| longest.push(v) }
    longest.sort_by!(&:length).reverse!
    return longest[0]
  end

end

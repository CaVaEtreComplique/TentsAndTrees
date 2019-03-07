# @Author: Gonçalves Quentin
# @Date:   29-Feb-2019
# @Email:  quentin.goncalves.etu@univ-lemans.fr
# @Filename: XmlReader.rb
# @Last modified by:   Gonçalves Quentin
# @Last modified time: 05-March-2019

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

  def setLanguage(l)
    @language = l
  end

end

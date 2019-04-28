# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Screen.rb
# @Last modified by:   zeigon
# @Last modified time: 26-Apr-2019



require 'gtk3'
require File.dirname(__FILE__) + "/../../Core/XmlReader"
require File.dirname(__FILE__) + "/../Constants"

##
# ===== 404
# This class was not commented in the first place, so it can not be documented.
class Screen
   # :nodoc:
  @gtkObject
  @backgroundPath

  def initialize(parent)
    screen = Constants::SCREEN
    @parent=parent
  	@buffer = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/../../../Assets/Backgrounds/landscape2.jpg")
    @buffer=@buffer.scale(screen.width,screen.height)
  	@buffer2 = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/../../../Assets/Backgrounds/landscape.jpg")
    @buffer2=@buffer2.scale(screen.width,screen.height)
    @textManager=XmlReader.instance
  end

  def applyOn(widget)
    widget.each { |child|
      widget.remove(child)
    }
    widget.add(@gtkObject)
    widget.show_all
  end
end

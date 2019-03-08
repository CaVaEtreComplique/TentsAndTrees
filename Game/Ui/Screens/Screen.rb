# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Screen.rb
# @Last modified by:   <QuentinGoncalves>
# @Last modified time: 08-March-2019



require 'gtk3'
require File.dirname(__FILE__) + "/../../Core/XmlReader"

class Screen
  @gtkObject
  @backgroundPath

  def initialize(parent)
    screen = Gdk::Screen.default
    @parent=parent
  	@buffer = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/../../../Assets/Backgrounds/4.png")
    @buffer=@buffer.scale(screen.width,screen.height)
  end

  def applyOn(widget)
    widget.each { |child|
      widget.remove(child)
    }
    widget.add(@gtkObject)
    widget.show_all
  end
end

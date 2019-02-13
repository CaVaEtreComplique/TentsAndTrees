# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Screen.rb
# @Last modified by:   zeigon
# @Last modified time: 13-Feb-2019



require 'gtk3'

class Screen
  @gtkObject
  @backgroundPath

  def initialize(parent)
    screen = Gdk::Screen.default
    @parent=parent
  	@buffer = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/../../../Assets/Backgrounds/2.jpg")
  	# @buffer = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/../../../Assets/Backgrounds/"+Random.new.rand(1...4).to_s+".jpg")
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

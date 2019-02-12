# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Screen.rb
# @Last modified by:   CorentinPetit
# @Last modified time: 11-Feb-2019



require 'gtk3'

class Screen
  @gtkObject
  @backgroundPath

  def initialize(parent)
    screen = Gdk::Screen.default
    @parent=parent
  	@buffer = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/../../../Assets/Backgrounds/4.png")
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

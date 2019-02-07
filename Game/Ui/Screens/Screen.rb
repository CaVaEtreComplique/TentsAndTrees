require 'gtk3'

class Screen
  @gtkObject
  @backgroundPath

  def initialize
  	@buffer = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/../../../Assets/Backgrounds/forest.jpg")
    screen = Gdk::Screen.default
    @buffer=@buffer.scale(screen.width, screen.height, :bilinear)
  end

  def applyOn(widget)
    widget.each { |child|
      widget.remove(child)
    }
    widget.add(@gtkObject)
    widget.show_all
  end
end

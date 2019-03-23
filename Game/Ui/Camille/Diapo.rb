require 'gtk3'

class Diapo
  attr_accessor :pile, :picindex, :imgLoaded, :image, :box, :window, :time

def initialize(width , height)
  pic1 = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/regle/1SeuleTenteParArbre.png")
  pic2 = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/regle/ColonneAZero.png")
  pic3 = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/regle/NombreColoneEtLigne.png")
  pic4 = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/regle/TentePasEnDiagonale.png")
  @pile = [pic1, pic2, pic3, pic4]
  @picindex = 0
  @width = width
  @height = height
  self.getImage
  @box = Gtk::EventBox.new.add(@image)
  @time = true
end

def nuImage
  @box.remove(@image)
  @picindex = @picindex + 1
  @picindex = 0 if @picindex == @pile.length
  self.getImage
  @box.add(@image)
  @box.show
end

def getImage
  @imgLoaded = @pile[@picindex]
  @imgLoaded = @imgLoaded.scale(@width,@height)
  @image = Gtk::Image.new(pixbuf: @imgLoaded)
  @image.show
end

end # class Pics

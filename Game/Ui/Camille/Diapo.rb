# @Author: Quentin Goncalves <QuentinGoncalves>
# @Date:   18-Mar-2019
# @Email:  quentin.goncalves.etu@univ-lemans.fr
# @Filename: Diapo.rb
# @Last modified by:   QuentinGoncalves
# @Last modified time: 23-Mar-2019


require 'gtk3'

class Diapo
  attr_accessor :hBox, :nextButton, :previousButton, :rule, :box

def initialize(width , height, textManager)
  pic1 = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/regle/regle1.png")
  pic2 = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/regle/regle2.png")
  pic3 = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/regle/regle3.png")
  pic4 = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/regle/regle4.png")

  tempNext = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/regle/nextButton.png")
  tempPrevious = GdkPixbuf::Pixbuf.new(file: File.dirname(__FILE__) + "/regle/previousButton.png")
  tempNext = tempNext.scale(width*0.2,height*0.2)
  nextButton = Gtk::Image.new(pixbuf: tempNext)
  tempPrevious = tempPrevious.scale(width*0.2,height*0.2)
  previousButton = Gtk::Image.new(pixbuf: tempPrevious)

  @textManager=textManager
  @pile = [pic1, pic2, pic3, pic4]
  @nextButton=Gtk::EventBox.new.add(nextButton)
  @previousButton=Gtk::EventBox.new.add(previousButton)
  @picindex = 0
  @width = width
  @height = height
  @box = Gtk::Box.new(:vertical)
  @page = Text.new((@picindex+1).to_s + "/" + @pile.length.to_s)
  @hBox = Gtk::Box.new(:horizontal)
  @rule = Text.new(@textManager.getRules(@picindex+1))
  @box.pack_start(@page.gtkObject, expand: false, fill: false, padding: 0)
  @box.add(@hBox)
  @box.pack_start(@rule.gtkObject, expand: false, fill: false, padding: 0)
  puts "1"
  self.getImage
  @hBox.add(@previousButton)
  @hBox.add(@image)
  @hBox.add(@nextButton)
  @time = true
end

def nextImage
  @hBox.remove(@previousButton)
  @hBox.remove(@image)
  @hBox.remove(@nextButton)
  @picindex = @picindex + 1
  if @picindex == @pile.length
    @picindex = 0
  end
  self.getImage
  @page.updateLabel((@picindex+1).to_s + "/" + @pile.length.to_s)
  @hBox.add(@previousButton)
  @hBox.add(@image)
  @hBox.add(@nextButton)
  @rule.updateLabel(@textManager.getRules(@picindex+1))
  @box.show
end

def previousImage
  @hBox.remove(@previousButton)
  @hBox.remove(@image)
  @hBox.remove(@nextButton)
  @picindex = @picindex - 1
  if @picindex == -1
    @picindex = @pile.length-1
  end
  self.getImage
  @page.updateLabel((@picindex+1).to_s + "/" + @pile.length.to_s)
  @hBox.add(@previousButton)
  @hBox.add(@image)
  @hBox.add(@nextButton)
  @rule.updateLabel(@textManager.getRules(@picindex+1))
  @box.show
end

def getImage
  @imgLoaded = @pile[@picindex]
  @imgLoaded = @imgLoaded.scale(@width,@height)
  @image = Gtk::Image.new(pixbuf: @imgLoaded)
  @image.show
end

end # class Pics

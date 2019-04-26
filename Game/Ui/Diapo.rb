# @Author: Quentin Goncalves <QuentinGoncalves>
# @Date:   18-Mar-2019
# @Email:  quentin.goncalves.etu@univ-lemans.fr
# @Filename: Diapo.rb
# @Last modified by:   zeigon
# @Last modified time: 08-Apr-2019


require 'gtk3'
require File.dirname(__FILE__) + "/AssetsClass/Asset"
require File.dirname(__FILE__) + "/AssetsLoaderClass/IconAsset"

class Diapo
  attr_accessor :hBox, :nextButton, :previousButton, :rule, :box

def initialize(width , height, textManager,ic)
  @h=height*0.7
  @w=width*0.9
  @ic=ic
  pic1 = @ic.iconAsset(:diapo1)
  pic2 = @ic.iconAsset(:diapo2)
  pic3 = @ic.iconAsset(:diapo3)
  pic4 = @ic.iconAsset(:diapo4)
  pic1.resize(@w,@h)
  pic2.resize(@w,@h)
  pic3.resize(@w,@h)
  pic4.resize(@w,@h)

  tempNext = Asset.new(File.dirname(__FILE__) + "/../../Assets/regle/nextButton.png")
  tempPrevious = Asset.new(File.dirname(__FILE__) + "/../../Assets/regle/previousButton.png")
  tempNext = tempNext.resize(width*0.2,height*0.2)
  nextButton = Gtk::Image.new(pixbuf: tempNext)
  tempPrevious = tempPrevious.resize(width*0.2,height*0.2)
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
  @box.pack_start(@page.gtkObject, expand: false, fill: false, padding: 20)
  @ali  = Gtk::Alignment.new(0.5, 0, 0, 0).add(@hBox)
  @box.add(@ali)
  @box.pack_start(@rule.gtkObject, expand: false, fill: false, padding: 0)
  self.getImage
  @hBox.add(@previousButton)
  @hBox.add(@image)
  @hBox.add(@nextButton)
  @time = true


  @previousButton.signal_connect("enter_notify_event") { |widget, event|
    @previousButton.window.set_cursor(Click::CURSORIN) unless @previousButton.window == nil
  }
  @previousButton.signal_connect("leave_notify_event") { |widget, event|
    @previousButton.window.set_cursor(Click::CURSOROUT) unless @previousButton.window == nil
  }

  @nextButton.signal_connect("enter_notify_event") { |widget, event|
    @nextButton.window.set_cursor(Click::CURSORIN) unless @nextButton.window == nil
  }
  @nextButton.signal_connect("leave_notify_event") { |widget, event|
    @nextButton.window.set_cursor(Click::CURSOROUT) unless @nextButton.window == nil
  }

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
  @imgLoaded = @imgLoaded.resize(@w,@h)
  @image = Gtk::Image.new(pixbuf: @imgLoaded)
  @image.show
end

end # class Pics

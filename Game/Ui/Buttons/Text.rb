# @Author: Corentin Petit <CorentinPetit>
# @Date:   10-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Text.rb
# @Last modified by:   zeigon
# @Last modified time: 13-Feb-2019

class Text

  attr_reader :gtkObject, :size

  def initialize(label, width=20, height=width, borderwidth=5, orientation=:horizontal)
    @currentWidth=width
    @currentHeight=height
    @borderWidth=borderwidth
    @charNumber=label.size
    @label=label
    @orientation=orientation
    @gtkObject=Gtk::Alignment.new(0.5, 0.2, 0, 0)
    @eventBox = Gtk::EventBox.new
    @eventBox.set_border_width(@borderWidth)
    @textBox = Gtk::Box.new(@orientation)
    @textBoxSelected = Gtk::Box.new(@orientation)

    @fs=ratio(@currentWidth,@currentHeight)

    @label.split(//).each{ |char|
      CharAssets.new(char.upcase,@fs).asset.applyOn(@textBox)
      CharAssets.new(char.upcase+"Selected",@fs).asset.applyOn(@textBoxSelected)
    }

    @gtkObject.add(@eventBox.add(@textBox))
  end

  def resize(width,height=width)
    @currentWidth=width
    @currentHeight=height
    @textBox.each { |child|
      @textBox.remove(child)
    }
    @textBoxSelected.each { |child|
      @textBoxSelected.remove(child)
    }
    @fs=ratio(width,height)
    @label.split(//).each{ |char|
      CharAssets.new(char.upcase,@fs).asset.applyOn(@textBox)
      CharAssets.new(char.upcase+"Selected",@fs).asset.applyOn(@textBoxSelected)
    }
    @textBox.show_all
    self
  end

  def setBorderWidth(nPix)
    @gtkObject.set_border_width(@borderWidth=nPix)
    self
  end

  def updateLabel(newLabel,width,height)
    @charNumber=newLabel.size
    @textBox.each { |child|
      @textBox.remove(child)
    }
    @fs=ratio(width,height)
    newLabel.split(//).each{ |char|
      CharAssets.new(char.upcase,@fs).asset.applyOn(@textBox)
    }
    @textBoxSelected.each { |child|
      @textBoxSelected.remove(child)
    }
    newLabel.split(//).each{ |char|
      CharAssets.new(char.upcase+"Selected",@fs).asset.applyOn(@textBoxSelected)
    }
    @textBoxSelected.show_all
    @textBox.show_all
    self
  end

  def onClick(block=nil)
    @eventBox.signal_connect("enter_notify_event") { |widget, event|
      @eventBox.each { |child|
        @eventBox.remove(child)
      }
      @eventBox.add(@textBoxSelected)
    }
    @eventBox.signal_connect("leave_notify_event") { |widget, event|
      @eventBox.each { |child|
        @eventBox.remove(child)
      }
      @eventBox.add(@textBox)
    }

    @gtkObject.signal_connect("button_release_event") { |_, event|
      if event.button==Click::LEFT
        yield
      end
    }
    self
  end

  def ratio(width,height)
    cw=[(width/@charNumber-@borderWidth*2).truncate,10].max
    ch=[(height-@borderWidth*2).truncate,10].max
    (ch * @charNumber + @borderWidth*2) < cw ? ch : cw
  end

end

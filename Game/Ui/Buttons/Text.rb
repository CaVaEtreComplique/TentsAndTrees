# @Author: Corentin Petit <CorentinPetit>
# @Date:   10-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Text.rb
# @Last modified by:   zeigon
# @Last modified time: 08-Apr-2019


class Text

  attr_reader :size, :gtkObject
  attr_writer :weight, :style, :size, :color

  def initialize(label, size=30)
    @label=label
    @gtkObject=Gtk::Alignment.new(0.5, 0.2, 0, 0)
    @eventBox = Gtk::EventBox.new
    @size=size
    @font="Arial"
    @color="black"
    @weight="bold"
    @style="normal"
    @textBox = Gtk::Label.new(@label)
    @textBox.use_markup = true
    apply
    @gtkObject.add(@eventBox.add(@textBox))
  end
  def setWrap(bool)
    @textBox.wrap=bool
    self
  end

  def title
    @weight = "ultrabold"
    @font = "Sans"
    @size = 50
    apply
  end

  def updateLabel(newLabel)
    @label=newLabel
    apply
    self
  end

  def onClick(block=nil)
    @eventBox.signal_connect("enter_notify_event") { |widget, event|
      @eventBox.window.set_cursor(Click::CURSORIN) unless @eventBox.window == nil
      @color="orange"
      apply
    }
    @eventBox.signal_connect("leave_notify_event") { |widget, event|
      @eventBox.window.set_cursor(Click::CURSOROUT) unless @eventBox.window == nil
      @color="black"
      apply
    }
    @eventBox.signal_connect("button_release_event") { |_, event|
      if event.button==Click::LEFT
        @eventBox.window.set_cursor(Click::CURSOROUT) unless @eventBox.window == nil
        @color="black"
        apply
        yield
      end
    }
    self
  end

  def apply
    @textBox.set_markup("<span style='"+@style.to_s+"' weight='"+@weight.to_s+"' foreground='"+@color.to_s+"' font_desc='"+@font.to_s+" "+@size.to_s+"'>"+@label+"</span>")
  end
  def colorChange(couleur)
    @color=couleur
    apply
  end
end

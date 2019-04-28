# @Author: Corentin Petit <CorentinPetit>
# @Date:   10-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Text.rb
# @Last modified by:   zeigon
# @Last modified time: 26-Apr-2019

require File.dirname(__FILE__) + "/../Constants"

##
# ===== 404
# This class was not commented in the first place, so it can not be documented.
class Text
   # :nodoc:

  attr_reader :size, :gtkObject
  attr_writer :weight, :style, :size, :color, :font

  def initialize(label, size=Constants::BUTTON_SIZE)
    @label=label
    @gtkObject=Gtk::Alignment.new(0.5, 0.2, 0, 0)
    @eventBox = Gtk::EventBox.new
    @eventBox.border_width=0
    @size=size
    @font="Arial"
    @color="lightgrey"
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

  def setBackground(r,g,b,a)
    @eventBox.override_background_color(:normal,Gdk::RGBA.new(r,g,b,a))
    @eventBox.show_all
  end

  def title
    @weight = "ultrabold"
    @font = "arial"
    @color = "white"
    @size = Constants::TITTLE_SIZE
    apply

    underText = Text.new(@label)
    underText.size=Constants::TITTLE_SIZE+2
    underText.font="arial"
    underText.color="black"
    underText.weight="bold"
    underText.style="normal"
    underText.apply

    @gtkObject.each { |child|
      @gtkObject.remove(child)
    }
    table=Gtk::Table.new(3,3)
    table.attach(@eventBox, 1, 2, 1, 2)
    table.attach(underText.gtkObject, 0, 3, 0, 3)
    @gtkObject.add(table)

    self
  end

  def updateLabel(newLabel)
    @label=newLabel
    apply
    self
  end

  def onClick(block=nil)
    temp=@color
    setBackground(0.2,0.2,0.2,0.6)
    @eventBox.signal_connect("enter_notify_event") { |widget, event|
      @eventBox.window.set_cursor(Click::CURSORIN) unless @eventBox.window == nil
      @color="orange"
      apply
    }
    @eventBox.signal_connect("leave_notify_event") { |widget, event|
      @eventBox.window.set_cursor(Click::CURSOROUT) unless @eventBox.window == nil
      @color=temp
      apply
    }
    @eventBox.signal_connect("button_release_event") { |_, event|
      if event.button==Click::LEFT
        Thread.new{
          sleep(0.5)
          if  !@eventBox.mapped?
            @eventBox.window.set_cursor(Click::CURSOROUT) unless @eventBox.window == nil
            @color=temp
            apply
          end
        }
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

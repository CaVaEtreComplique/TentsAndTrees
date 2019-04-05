
require 'gtk3'
class ScrollableArea
  attr_reader :gtkObject
  def initialize
    @gtkObject=Gtk::ScrolledWindow.new()
    @menu= Gtk::Box.new(:vertical)
    @gtkObject.border_width=10
    @vp=Gtk::Viewport.new(nil,@gtkObject.vadjustment)
    @vp.add(@menu)
    @gtkObject.add(@vp)
  end
  def add(widget,pad=0)
    @menu.pack_start(widget,padding:pad)
  end
end


require 'gtk3'
class ScrollableArea
  attr_reader :gtkObject
  def initialize(orientation)
    @gtkObject=Gtk::ScrolledWindow.new()
    @menu= Gtk::Box.new(orientation)
    @gtkObject.border_width=10
    @vp=Gtk::Viewport.new(nil,@gtkObject.vadjustment)
    @vp.add(@menu)
    @gtkObject.add(@vp)
  end
  def add(widget,pad=0)
    @menu.pack_start(widget,expand: false, fill: false,padding:pad)
  end
end


require 'gtk3'
##
# ===== Presentation
# This class creates and implements a scrollable area in a page.
#
# ===== Methods
# This class has its initializer and an add method, as described below.
class ScrollableArea

  # :nodoc:
  attr_reader :gtkObject
  # :startdoc:

  ##
  # ===== Presentation
  # This method is used to create the scrollable area by using a viewport.
  # All of the other variables are used for the layout.
  #
  # ===== Attributes
  # * +orientation+ - Defines the orientation (horizontal,vertical) of the scrollable area.
  #
  def initialize(orientation)
    @gtkObject=Gtk::ScrolledWindow.new()
    @menu= Gtk::Box.new(orientation)
    @gtkObject.border_width=10
    @vp=Gtk::Viewport.new(nil,@gtkObject.vadjustment)
    @vp.add(@menu)
    @gtkObject.add(@vp)
  end

  ##
  # ===== Presentation
  # This method will add a widget to the scrollable area.
  #
  # ===== Attributes
  # * +widget+ - The widget it is adding.
  # * +pad+ - The padding value.
  def add(widget,pad=0)
    @menu.pack_start(widget, expand: false, fill: false, padding:pad)
  end
end

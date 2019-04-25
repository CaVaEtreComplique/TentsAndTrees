
require 'gtk3'
##
# ===== Presentation
#ScolableArea  only needs to be initialized.
#It creates and implements a scrolable area in a page.
##

class ScrollableArea
  attr_reader :gtkObject
  #
  #=====Presentation
  #This method is used to create the scrolable area by using a viewport
  #All the other variable are used for the layout.
  #=====Attributes
  # *+orientation+ : define the orientation (horizontal,vertical) of the scrolable area
  ##
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

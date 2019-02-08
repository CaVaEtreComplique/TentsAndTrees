require File.dirname(__FILE__) + "/../Click"

class Button
  @blocks
	@index
	@gtkObject
	@gtkLabels

	attr_reader :gtkObject

	def initialize(orientation, label)
		@gtkLabels = Gtk::Label.new(label.to_s)
    gtkBox = Gtk::Box.new(orientation)
		gtkBox.pack_end(@gtkLabels, expand:true, fill:true, padding:0)
		@gtkObject = Gtk::Button.new
		@gtkObject.add(gtkBox)
	end

  def onClick(block=nil)
    return unless block_given?
    @gtkObject.signal_connect("button_release_event") { |_, event|
			if event.button==Click::LEFT
        yield
      end
    }
  end

  def updateLabel(newLabel)
    @gtkLabels.label=newLabel
  end

end

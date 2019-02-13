# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Button.rb
# @Last modified by:   zeigon
# @Last modified time: 13-Feb-2019



require File.dirname(__FILE__) + "/../Click"
require File.dirname(__FILE__) + "/../AssetsClass/Asset"

class Button
  @blocks
	@index
	@gtkObject
	@gtkLabels

	attr_reader :gtkObject, :gtkLabels

	def initialize(orientation, label)
		@gtkLabels = Gtk::Label.new(label.to_s)
    gtkBox = Gtk::Box.new(orientation)
		gtkBox.pack_end(@gtkLabels, expand:true, fill:false, padding:0)
		@gtkObject = Gtk::Button.new
		@gtkObject.add(gtkBox)
	end


  def updateLabel(newLabel)
    @gtkLabels.label=newLabel
  end

  def onClick(block=nil)
    return unless block_given?
    @gtkObject.signal_connect("button_release_event") { |_, event|
      if event.button==Click::LEFT
        yield
      end
    }
  end

end

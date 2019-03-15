# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Button.rb
# @Last modified by:   zeigon
# @Last modified time: 13-Feb-2019

require File.dirname(__FILE__) + "/../Click"
require File.dirname(__FILE__) + "/../AssetsClass/Asset"

##
# The Button class implements how every button in the game should work. This
# class has 3 methods : initialize, updateLabel and onClick.
class Button
  @blocks
	@index
	@gtkObject
	@gtkLabels

   #:nodoc:
	attr_reader :gtkObject, :gtkLabels
   #:startdoc:

   ##
   # This method initializes the button's variables in order to act properly.
	def initialize(orientation, label)
		@gtkLabels = Gtk::Label.new(label.to_s)
    gtkBox = Gtk::Box.new(orientation)
		gtkBox.pack_end(@gtkLabels, expand:true, fill:false, padding:0)
		@gtkObject = Gtk::Button.new
		@gtkObject.add(gtkBox)
	end

   ##
   # The updateLabel method updates the button label with the new value taken
   # in parameters.
  def updateLabel(newLabel)
    @gtkLabels.label=newLabel
  end

  ##
  # The onClick method determins how a button acts when it is clicked or
  # hovered.
  def onClick(block=nil)
    return unless block_given?
    @gtkObject.signal_connect("button_release_event") { |_, event|
      if event.button==Click::LEFT
        yield
      end
    }
  end

end

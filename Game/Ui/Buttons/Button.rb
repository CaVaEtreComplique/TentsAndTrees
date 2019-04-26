# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Button.rb
# @Last modified by:   zeigon
# @Last modified time: 28-Mar-2019

require File.dirname(__FILE__) + "/../Click"
require File.dirname(__FILE__) + "/../AssetsClass/Asset"

##
# ===== Presentation
# The Button class implements how every button in the game should work.
# ===== Methods
# This class has 3 methods : initialize, updateLabel and onClick.
class Button
  @blocks
	@index
	@gtkObject
	@gtkLabels

   #:nodoc:
	attr_reader :gtkObject, :gtkLabels
   #:startdoc:

   ##
   # ===== Presentation
   # This method initializes the button's variables in order to act properly.
   #
   # ===== Attributes
   # * +orientation+ - The button's orientation.
   # * +label+ - The button's name that will be shown.
	def initialize(orientation, label)
		@gtkLabels = Gtk::Label.new(label.to_s)
      gtkBox = Gtk::Box.new(orientation)
		gtkBox.pack_end(@gtkLabels, expand:true, fill:false, padding:0)
		@gtkObject = Gtk::Button.new
		@gtkObject.add(gtkBox)
	end

   ##
   # ===== Presentation
   # The updateLabel method updates the button label with the new value taken
   # in parameters.
   #
   # ===== Attributes
   # * +newLabel+ - The label the button will have.
  def updateLabel(newLabel)
    @gtkLabels.label=newLabel
  end

  ##
  # ===== Presentation
  # The onClick method determins how a button acts when it is clicked or
  # hovered.
  #
  # ===== Attributes
  # * +block+ - The instruction block that will be executed when the button is pressed.
  # ----------
  def onClick(block=nil)
    return unless block_given?
    @gtkObject.signal_connect("button_release_event") { |_, event|
      if event.button==Click::LEFT
        yield
      end
    }
  end

end

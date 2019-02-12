# @Author: Corentin Petit <CorentinPetit>
# @Date:   10-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: CharAsset.rb
# @Last modified by:   CorentinPetit
# @Last modified time: 12-Feb-2019



require File.dirname(__FILE__) + "/Asset"
require File.dirname(__FILE__) + "/../Constants"

class CharAsset < Asset
	@image
	@buffer
	def initialize(char,width=20)
		super(File.dirname(__FILE__) + "/../../../Assets/Characters/"+char.upcase+".png")
		resize(width,width)
	end

	def resize(width,height)
		super(width,height)
	end

  def applyOn(widget)
    widget.add(Gtk::Image.new(pixbuf: @buffer))
    widget.show_all
  end

end

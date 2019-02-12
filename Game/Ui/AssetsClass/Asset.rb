# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Asset.rb
# @Last modified by:   CorentinPetit
# @Last modified time: 09-Feb-2019



class Asset
	@image
	@buffer
	@width
	@height

	attr_reader :buffer

	def initialize(file)
		@buffer= GdkPixbuf::Pixbuf.new(file: file)
		resize
	end

	def resize(width,height)
		@buffer=@buffer.scale(width,height, :bilinear)
	end

	def applyOn(widget)
		widget.each { |child|
			widget.remove(child)
		}
		widget.add(Gtk::Image.new(pixbuf: @buffer))
		widget.show_all
	end

end

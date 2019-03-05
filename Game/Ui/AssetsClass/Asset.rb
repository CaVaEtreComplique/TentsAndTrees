# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Asset.rb
# @Last modified by:   CorentinPetit
# @Last modified time: 12-Feb-2019

##
#Asset is an abstract class needed to create and use all of the images from the
#game. It creates these 4 variables :
#	@image
#	@buffer
#	@width
#	@height
#
#This class needs to be initialized. In the initializer the buffer variable
#takes its value from a file taken in the method parameters.
#
#This class creates two methods : resize and applyOn.
#
#The resize class modifies the buffer to make it fit the size taken in
#parameters.
#
#The applyOn method takes a widget in parameters and puts the image on it.
class Asset
	@image
	@buffer
	@width
	@height

	attr_reader :buffer  #:nodoc:

	def initialize(file)  #:nodoc:
		@buffer= GdkPixbuf::Pixbuf.new(file: file)
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

# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Asset.rb
# @Last modified by:   CorentinPetit
# @Last modified time: 12-Feb-2019

##
# ===== Presentation
# Asset is an abstract class needed to create and use all of the images from the
# game. It creates these 4 variables :
#	@image
#	@buffer
#	@width
#	@height
#
# ===== Methods
# This class creates two methods : resize and applyOn. It also needs to be initialized.
class Asset
	@image
	@buffer
	@width
	@height

	# :nodoc:
	attr_reader :buffer
	# :startdoc:

	##
	# ===== Presentation
	# The class' initializer.
	#
	# ===== Attributes
	# * +file+ - A file that will give its value to the buffer variable.
	#
	# ===== Examples
	# To initialize the buffer variable :
	#      @buffer= GdkPixbuf::Pixbuf.new(file: file)
	def initialize(file)
		@buffer= GdkPixbuf::Pixbuf.new(file: file)
	end

	##
	# ===== Presentation
	# The resize method modifies the buffer to make it fit a certain size.
	#
	# ===== Attributes
	# * +width+, +height+ - The new size for the buffer.
	#
	# ===== Examples
	# To resize the buffer :
	#     @buffer=@buffer.scale(width, height, :bilinear)
	def resize(width,height)
		@buffer=@buffer.scale(width, height, :bilinear)
	end

	##
	# ===== Presentation
	# The applyOn method puts an image on a widget.
	#
	# ===== Atrributes
	# * +widget+ - The widget we will put the image onto.
	# ----------
	def applyOn(widget)
		widget.each { |child|
			widget.remove(child)
		}
		widget.add(Gtk::Image.new(pixbuf: @buffer))
		widget.show_all
	end

end

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

	def resize

	end

	def applyOn(widget)
		widget.each { |child|
			widget.remove(child)
		}
		widget.add(Gtk::Image.new(pixbuf: @buffer))
		widget.show_all
	end

end

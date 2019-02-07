class ClueUi
	@blocks
	@index
	@gtkObject
	@gtkLabels

	attr_reader :gtkObject
	def initialize(orientation, blocks, index)
		@blocks = blocks
		@index = index

		gtkBox = Gtk::Box.new(orientation)
		@gtkLabels = Gtk::Label.new(blocks.to_s)
			gtkBox.pack_end(@gtkLabels, expand:false, fill:false, padding:3)
			@gtkObject = Gtk::Button.new
		@gtkObject.add(gtkBox)
	end


end

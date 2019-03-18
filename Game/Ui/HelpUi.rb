# @Author: Corentin Petit <zeigon>
# @Date:   05-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: HelpUi.rb
# @Last modified by:   zeigon
# @Last modified time: 18-Mar-2019


# class HelplUi
#
#   attr_reader :gtkObject
#
#   def initialize
#       @gtkObject = Gtk::DrawingArea.new
#       @gtkObject.signal_connect "draw" do
#           onDraw
#       end
#   end
#
#   def onDraw
#       @cr = @gtkObject.window.create_cairo_context
#       drawLyrics
#   end
#
#   def drawLyrics
#       @cr.set_source_rgb 0.1, 0.1, 0.1
#       @cr.select_font_face "Purisa", Cairo::FONT_SLANT_NORMAL,
#           Cairo::FONT_WEIGHT_NORMAL
#       @cr.set_font_size 13
#       @cr.move_to 20, 30
#       @cr.show_text "Most relationships seem so transitory"
#       @cr.move_to 20, 60
#       @cr.show_text "They're all good but not the permanent one"
#       @cr.move_to 20, 120
#       @cr.show_text "Who doesn't long for someone to hold"
#       @cr.move_to 20, 150
#       @cr.show_text "Who knows how to love without being told"
#       @cr.move_to 20, 180
#       @cr.show_text "Somebody tell me why I'm on my own"
#       @cr.move_to 20, 210
#       @cr.show_text "If there's a soulmate for everyone"
#   end
#
# end


class Preview

	@gtkObject
	@game
	@surface
	@size

	attr_reader :gtkObject

	def initialize(game)
		@game = game
		@gtkObject = Gtk::DrawingArea.new
    @size=140
		@gtkObject.set_size_request(@size, @size)

		@gtkObject.signal_connect "draw" do |_widget, cr|
      onDrawSignal(cr)
    end

    @gtkObject.signal_connect "configure-event" do |widget|
      onConfigureEventSignal(widget)
		end
	end

	def onDrawSignal(cr)
    # Redraw the screen from the
    cr.set_source(@surface, 0, 0)
    cr.paint
    false
	end

	def onConfigureEventSignal(da)
    @surface.destroy if @surface
    @surface = da.window.create_similar_surface(Cairo::CONTENT_COLOR, da.allocated_width, da.allocated_height)
    # initialize the surface to white
    cr = Cairo::Context.new(@surface)
    cr.set_source_rgba(1, 1, 1, 1)
    cr.paint
    cr.destroy
    # we have handled the configure event, no need to further processing
    true
	end

	def update(row, col, state)
		return false unless @surface
		cr = Cairo::Context.new(@surface)
	  checkWidth = @size/@game.nCol
		checkHeight = @size/@game.nRow
		i = checkWidth * row
		j = checkHeight * col
		if state != :white then
			cr.set_source_rgba(0, 0, 0, 1)
		else
			cr.set_source_rgba(1, 1, 1, 1)
		end
		cr.rectangle(j, i, checkWidth, checkHeight)
		cr.fill
		cr.destroy
		@gtkObject.queue_draw
 end

end

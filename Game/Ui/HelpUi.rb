# @Author: Corentin Petit <zeigon>
# @Date:   18-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: HelpUi.rb
# @Last modified by:   zeigon
# @Last modified time: 29-Mar-2019

class HelpUi

	@gtkObject
	@surface
	@size

	attr_reader :gtkObject

	def initialize
		@gtkObject = Gtk::DrawingArea.new
		@gtkObject.set_size_request((Gdk::Screen.default.width*0.3), (Gdk::Screen.default.height*0.3))
		@label=Text.new ""
    @label.style="italic"
    @label.weight="normal"
    @label.color="red"
    @label.size=12
		# @gtkObject.add(@label)
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
		clean
    # we have handled the configure event, no need to further processing
    true
	end

	def clean
		return false unless @surface
		# initialize the surface to white
		cr = Cairo::Context.new(@surface)
		cr.set_source_rgba(1, 1, 1, 1)
		cr.paint
		cr.destroy
		@label.updateLabel ""
	end

	def update(message="")
		return false unless @surface
		clean
		@label.updateLabel message
    self
 end

end

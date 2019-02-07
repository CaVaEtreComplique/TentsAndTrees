require 'gtk3'
require File.dirname(__FILE__) + "/Screen"

class LoadingScreen < Screen

  attr_reader :progressCount

  def initialize()
    super()
    @progressBar = Gtk::ProgressBar.new
    @progressBar.pulse_step=0.3
    text
    @gtkObject=Gtk::Layout.new.add(Gtk::Table.new(3,3).attach(@progressBar,0,3,0,1).attach(Gtk::Image.new(pixbuf: @buffer),0,3,1,3))
  end

  def update
    @progressBar.pulse
  end

  def run
    @thread=Thread.new{
      while true
        update
        sleep(0.01)
      end
    }
  end

  def kill
      @trhead.terminate
  end

  def text(s="Chargement en Cours")
    @progressBar.text=s
    @progressBar.set_show_text(true)
  end

end

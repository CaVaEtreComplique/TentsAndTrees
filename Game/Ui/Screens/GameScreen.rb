require 'gtk3'
require File.dirname(__FILE__) + "/Screen"
require File.dirname(__FILE__) + "/../GridUi"

class GameScreen < Screen

  def initialize(game,assets)
    super()
    @assets=assets
    @gridUi=GridUi.new(game, assets)
    @gtkObject = Gtk::Table.new(3,3)

# => TO DO CORRECLTY
    gtkBox1 = Gtk::Box.new(:vertical)
		gtkLabels1 = Gtk::Label.new("Nouvelle Hypothèse")
		gtkBox1.pack_end(gtkLabels1, expand:true, fill:false, padding:1)
		button1 = Gtk::Button.new
		button1.add(gtkBox1)

    gtkBox2 = Gtk::Box.new(:vertical)
		gtkLabels2 = Gtk::Label.new("Refuter Hypothèse")
		gtkBox2.pack_end(gtkLabels2, expand:true, fill:false, padding:1)
		button2 = Gtk::Button.new
		button2.add(gtkBox2)

    buttonsBox = Gtk::Box.new(:vertical)
		buttonsBox.add(button1).add(button2)

    button1.signal_connect("button_release_event") { |_, event|
      game.beginGuess
      (@gridUi.cells).each { |r|
        r.each { |c|
  				c.normal
  			}
  		}
		}

    button2.signal_connect("button_release_event") { |_, event|
      game.removeGuess
      (@gridUi.cells).each { |r|
        r.each { |c|
  				c.normal
        }
      }
		}

    @gtkObject.attach(buttonsBox,2,3,1,2)
# => DOWN UNTIL THERE

    @gtkObject.attach(@gridUi.gtkObject, 0, 1, 0, 3)
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)


  end

end

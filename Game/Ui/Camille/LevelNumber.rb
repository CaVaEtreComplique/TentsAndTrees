# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   1-Mar-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: ChoixDiff.rb
# @Last modified by:   zeigon
# @Last modified time: 15-Mar-2019

require 'gtk3'
require File.dirname(__FILE__) + "/../Screens/Screen"
require File.dirname(__FILE__) + "/../Buttons/Button"

def require_all(_dir)
	Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each { |file|
		require file
	}
end

class LevelNumber < Screen
  def initialize(manager)
		super(manager.win)
		screen=Gdk::Screen.default
		@pad=20
		@widthText=screen.width*0.1
    @heightText=screen.height*0.1

		@gtkObject= Gtk::Table.new(3,3)
    @menu=Gtk::Box.new(:vertical, 25)
    @gtkObject.attach(@menu,1,2,1,2)

		@menuH1=Gtk::Box.new(:horizontal, 25)
		@menuH2=Gtk::Box.new(:horizontal, 25)
		@menu.add(@menuH1)
		@menu.add(@menuH2)

    n1=Text.new(" 1",@widthText,@heightText)
    @menuH1.pack_start(n1.gtkObject ,expand: false, fill: true, padding: @pad)
		n1.onClick{
			#session=AdventureSession.new(:timeAttack, :easy,1)
			#manager.runGameSession(session)
	 }

		n2=Text.new("2 ",@widthText,@heightText)
    @menuH1.pack_start(n2.gtkObject ,expand:false, fill: true, padding: @pad)

		n3=Text.new("3 ",@widthText,@heightText)
    @menuH1.pack_start(n3.gtkObject ,expand: false, fill: true, padding: @pad)

		n4=Text.new("4 ",@widthText,@heightText)
    @menuH1.pack_start(n4.gtkObject ,expand: false, fill: true, padding: @pad)

		n5=Text.new("5 ",@widthText,@heightText)
    @menuH1.pack_start(n5.gtkObject ,expand: false, fill: true, padding: @pad)

		n6=Text.new("6 ",@widthText,@heightText)
    @menuH2.pack_start(n6.gtkObject ,expand: false, fill: true, padding: @pad)

		n7=Text.new("7 ",@widthText,@heightText)
    @menuH2.pack_start(n7.gtkObject ,expand: false, fill: true, padding: @pad)

		n8=Text.new("8 ",@widthText,@heightText)
    @menuH2.pack_start(n8.gtkObject ,expand: false, fill: true, padding: @pad)

		n9=Text.new("9 ",@widthText,@heightText)
    @menuH2.pack_start(n9.gtkObject ,expand: false, fill: true, padding: @pad)

		n10=Text.new("10 ",@widthText,@heightText)
    @menuH2.pack_start(n10.gtkObject ,expand: false, fill: true, padding: @pad)

		retour=Text.new("RETOUR",@widthText,screen.height*0.08)
		@menu.pack_start(retour.gtkObject ,expand: false, fill: true, padding: @pad)
		retour.onClick{
			manager.modeScreen.applyOn(@parent)
		 }

		@gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
  end
end

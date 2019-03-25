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

		#Chargement de la campagne
		@adventure = Levels.new

		screen=Gdk::Screen.default
		@pad=1
		@widthText=screen.width*0.1
    @heightText=screen.height*0.1

		@gtkObject= Gtk::Table.new(3,3)
		@menu= Gtk::Table.new(6,6)
    #@menu=Gtk::Box.new(:vertical, 25)
    @gtkObject.attach(@menu,0,1,0,1)

    @nbNiveau=25
    x=0
    y=0


    (1... @nbNiveau+1).each { |i|
      @im=Gtk::Box.new(:horizontal, 25)
      @menu.attach(@im,x,x+1,y,y+1)
      if(i==1 || i==2)
        n=Text.new(i.to_s,@widthText,@heightText)
        @im.pack_start(n.gtkObject,expand: false, fill: true, padding:0)
        n.onClick{
          session=@adventure.getLevel(i)
          manager.runGameSession(session)
        }
      else
      n=Asset.new(File.dirname(__FILE__) + "/../../../Assets/Characters/Locked/"+i.to_s+".png")
  		n.resize(70,65)
  		n.applyOn(@im)
      end
      if i>5+y*5
          y=y+1
           x=0
      end
      x=x+1

    #  @menu.remove(@im)
	#	@im=Gtk::Box.new(:horizontal, 25)
	#	@menu.attach(@im,x,x+1,y,y+1)
    #  n=Text.new(i.to_s,@widthText,@heightText)
    #  @im.pack_start(n.gtkObject,expand: false, fill: true, padding: @pad)
	#	n.onClick{
	#		session=@adventure.getLevel(i)
	#		manager.runGameSession(session)
	#	}
    }

		@menuR=Gtk::Box.new(:horizontal, 25)
		@menu.attach(@menuR,5,6,5,6)
    retour=Text.new("RETOUR",@widthText,screen.height*0.08)
		@menuR.pack_start(retour.gtkObject ,expand: false, fill: true, padding: @pad)
		retour.onClick{
			manager.modeScreen.applyOn(@parent)
 		}



		@gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
  end

end

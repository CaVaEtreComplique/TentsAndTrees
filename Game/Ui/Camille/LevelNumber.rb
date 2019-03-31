# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   1-Mar-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: ChoixDiff.rb
# @Last modified by:   zeigon
# @Last modified time: 28-Mar-2019

require 'gtk3'
require File.dirname(__FILE__) + "/../AssetsClass/Asset"

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

    @gtkObject= Gtk::Table.new(3,3)
    @menu= Gtk::Table.new(12,12)
    @gtkObject.attach(@menu,0,1,0,1)

    @nbNiveau=25
    @nbEtoile=3
		@nbEtoileObtenu=3
    x=0
    y=0
    (1.. @nbNiveau).each { |i|
        @im=Gtk::Box.new(:horizontal, 25)
				@menu.attach(@im,x,x+1,y,y+1)

				@BoxH=Gtk::Box.new(:horizontal,25)
				@BoxV=Gtk::Box.new(:vertical,25)
				@im.pack_start(@BoxV,expand: false, fill: true, padding: @pad)

				@BoxV.pack_start(@BoxH,expand: false, fill: true, padding: @pad)

				niveau=Text.new(i.to_s,40)
			 	@BoxH.pack_start(niveau.gtkObject,expand: false, fill: true, padding: @pad)

				@lock=Gtk::EventBox.new()
				@stars=Gtk::Box.new(:horizontal,25)
				s=Star.new(@nbEtoile,@nbEtoileObtenu)
				@BoxV.pack_start(s.stars,expand: false, fill: true, padding: @pad)


      if(i==1 || i==2)
        niveau.onClick{
          session=@adventure.getLevel(i)
          manager.runGameSession(session)
				}
      else
        loc=Asset.new(File.dirname(__FILE__) + "/../../../Assets/Characters/lock.png")
        loc.resize(30,30)
        loc.applyOn(@lock)
        @BoxH.pack_start(@lock,expand: false, fill: true, padding: @pad)
      end
      x=x+2
      if i>4+y*5
          y=y+1
         x=0
      end
    }
    @menuR=Gtk::Box.new(:horizontal, 25)
		@menu.attach(@menuR,11,12,11,12)
		retour=Text.new("RETOUR",14)
    @menuR.pack_start(retour.gtkObject ,expand: false, fill: true, padding: @pad)
  	retour.onClick{
			if @game!=nil
				manager.createNewSave
				manager.updateSave
			end
    	manager.modeScreen.applyOn(@parent)
		}
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
	end
end

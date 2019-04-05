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
		@pad=screen.height*0.03
		@police=screen.height*0.04

		@gtkObject = Gtk::Table.new(3,3)
		@scrol=ScrollableArea.new(:vertical)
		@boxV=Gtk::Box.new(:horizontal)
		a=Gtk::Alignment.new(0.5,0,0.5,1)
		a.add(@boxV)
		@gtkObject.attach(a,0,1,1,2)
		@boxV.pack_start(@scrol.gtkObject,expand: true, fill: true, padding: @pad)

    @nbNiveau=@adventure.levels.length
		@overAllStars = 5
		@adventureInfo=Hash.new
		l=Asset.new(File.dirname(__FILE__) + "/../../../Assets/Characters/lock.png")

    (1.. @nbNiveau).each { |i|
        @im=Gtk::Box.new(:horizontal, 25)
				@scrol.add(@im)
				al=Gtk::Alignment.new(0.5,0,0.5,1)
				@BoxH=Gtk::Box.new(:horizontal,25)
				@BoxV=Gtk::Box.new(:vertical,25)
				@im.pack_start(@BoxV,expand: false, fill: true, padding: @pad)

				@BoxV.pack_start(@BoxH,expand: false, fill: true, padding: @pad)

				niveau=Text.new( i.to_s,@police*6)
			 	@BoxH.pack_start(niveau.gtkObject,expand: false, fill: true, padding: @pad)
				@lock=Gtk::EventBox.new()
				@stars=Gtk::Box.new(:horizontal,25)

				if @adventureInfo.include?(i)
					@s=Star.new(@adventure.getLevelMaxStars(i),@adventureInfo.fetch(i))
				else
					@s=Star.new(@adventure.getLevelMaxStars(i),0)
				end

				@BoxV.pack_start(@s.stars,expand: false, fill: true, padding: @pad)

			if @adventure.lvlAvailable?(i,@overAllStars)
        niveau.onClick{
					session=@adventure.getLevel(i,@adventureInfo)
					manager.runGameSession(session)
				}
      else
        loc = l
        loc.resize(100,100)
        loc.applyOn(@lock)
        @BoxH.pack_start(@lock,expand: false, fill: true, padding: @pad)
      end
		}
    @menuR=Gtk::Box.new(:horizontal, 25)
		@scrol.add(@menuR)

		retour=Text.new("RETOUR",@police)
    @menuR.pack_start(retour.gtkObject ,expand: false, fill: true, padding:10)
  	retour.onClick{
			if @game!=nil
				manager.createNewSave
				manager.updateSave
			end
    	manager.modeScreen.applyOn(@parent)
		}
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
	end

	def applyOn(widget, overAllStars, adventureInfo,levelnumber)

		@overAllStars = overAllStars
		@adventureInfo = adventureInfo
		if @adventureInfo.include?(levelnumber)
			@s.refresh(@adventure.getLevelMaxStars(levelnumber), @adventureInfo.fetch(levelnumber))
		end
		super(widget)
	end
end

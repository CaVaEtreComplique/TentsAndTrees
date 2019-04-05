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
    #@menu= Gtk::Box.new(:vertical)

		# @scrol=Gtk::ScrolledWindow.new()
		# @scrol.border_width=10
		# @vp=Gtk::Viewport.new(nil,@scrol.vadjustment)
		# @vp.add(@menu)
		# @scrol.add(@vp)


		@scrol=ScrollableArea.new(:vertical)
		@boxV=Gtk::Box.new(:horizontal)
		a=Gtk::Alignment.new(0.5,0,0.5,1)
		a.add(@boxV)
		@gtkObject.attach(a,0,1,1,2)
	#	@gtkObject.attach(@boxV,0,1,1,2)
		@boxV.pack_start(@scrol.gtkObject,expand: true, fill: true, padding: @pad)

    @nbNiveau=5
		@nbEtoileObtenu=0
		@overAllStars = 2
		if @game != nil
			if @game.session.partOfAdventure?
				@overAllStars = @game.session.calculateOverallStars
			end
		end

    (1.. @nbNiveau).each { |i|
        @im=Gtk::Box.new(:horizontal, 25)
				@scrol.add(@im)
				al=Gtk::Alignment.new(0.5,0,0.5,1)
				@BoxH=Gtk::Box.new(:horizontal,25)
				@BoxV=Gtk::Box.new(:vertical,25)
				@im.pack_start(@BoxV,expand: false, fill: true, padding: @pad)

				@BoxV.pack_start(@BoxH,expand: false, fill: true, padding: @pad)

				niveau=Text.new( i.to_s,120)
			 	@BoxH.pack_start(niveau.gtkObject,expand: false, fill: true, padding: @pad)
				@lock=Gtk::EventBox.new()
				@stars=Gtk::Box.new(:horizontal,25)
				s=Star.new(@adventure.getLevelMaxStars(i),@nbEtoileObtenu)
				@BoxV.pack_start(s.stars,expand: false, fill: true, padding: @pad)

			if @adventure.lvlAvailable?(i,@overAllStars)
        niveau.onClick{
					session=@adventure.getLevel(i,Hash.new)
          if @game != nil
						if @game.session.partOfAdventure?
							session=@adventure.getLevel(i,@game.session.overAllStars)
						end
					end
					manager.runGameSession(session)
				}
      else
        loc=Asset.new(File.dirname(__FILE__) + "/../../../Assets/Characters/lock.png")
        loc.resize(100,100)
        loc.applyOn(@lock)
        @BoxH.pack_start(@lock,expand: false, fill: true, padding: @pad)
      end
		}
    @menuR=Gtk::Box.new(:horizontal, 25)
		@scrol.add(@menuR)

		retour=Text.new("RETOUR",25)
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
end

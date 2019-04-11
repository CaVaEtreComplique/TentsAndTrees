# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   1-Mar-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: ChoixDiff.rb
# @Last modified by:   zeigon
# @Last modified time: 05-Apr-2019

require 'gtk3'
require File.dirname(__FILE__) + "/../AssetsClass/Asset"

def require_all(_dir)
	Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each { |file|
		require file
	}
end

class LevelSelectionScreen < Screen

attr_reader :adventure, :adventureInfo, :overAllStars
  def initialize(manager)
		super(manager.win)
		@manager = manager
		#Chargement de la campagne
		@adventure = manager.session
		screen = Constants::SCREEN
		@pad=Constants::BUTTON_PADDING

		@gtkObject = Gtk::Table.new(3,3)
		@scrol=ScrollableArea.new(:vertical)
		@boxV=Gtk::Box.new(:horizontal)
		a=Gtk::Alignment.new(0.5,0,0.5,1)
		a.add(@boxV)
		@gtkObject.attach(a,0,1,1,2)
		@boxV.pack_start(@scrol.gtkObject,expand: true, fill: true, padding: @pad)

		@nbNiveau=@adventure.adventureInfo.levels.length
		@overAllStars = @adventure.overAllStars
		l=Asset.new(File.dirname(__FILE__) + "/../../../Assets/Characters/lock.png")

    @b=Gtk::Box.new(:horizontal, 25)
		@scrol.add(@b)

		@icones=LevelNumbers.new(manager,@adventure ,@adventure.overAllStarsHash)
		@b.pack_start(@icones.im,expand: false, fill: true, padding: @pad)
    @menuR=Gtk::Box.new(:horizontal, 25)
		@scrol.add(@menuR)

		retour=Text.new("Quitter")
    @menuR.pack_start(retour.gtkObject ,expand: false, fill: true, padding:@pad)
  	retour.onClick{
			manager.session.updateSave
			manager.updateSave
    	manager.mainScreen.applyOn(@parent)
		}
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
	end

	def applyOn(widget)

		@icones.refresh(@manager,@adventure,@adventure.overAllStarsHash)
		super(widget)
	end
end

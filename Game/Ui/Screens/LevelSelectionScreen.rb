# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   1-Mar-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: ChoixDiff.rb
# @Last modified by:   Sckylle
# @Last modified time: 25-Apr-2019

require 'gtk3'
require File.dirname(__FILE__) + "/../AssetsClass/Asset"

def require_all(_dir)
	Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each { |file|
		require file
	}
end


##
# ===== Presentation
#LevelSelectionScreen is an inherited class from the Screen class. This class only needs
#to be initialized and refresh.
#It creates and implements the level selection menu from the game by creating its
#levels numbers.
##

class LevelSelectionScreen < Screen

attr_reader :adventure, :adventureInfo, :overAllStars
#
#=====Presentation
#This method is used to create the level selection by calling the class LevelNumbers.
#ALl images will be charged thanks to the class IconAsset.
#A scrolable area is also created by calling the class ScrolableArea, which contains
#buttons and boxes. These buttons are made by the class levelNumbers who represente the level numbers, the loc and the stars.
#On the page we can find the number of stars that we own contain in the box etoileTotal.
#All the other variable are used for the layout.
#=====Attributes
# *+manager+ : managerUi who handle the Ui
##
  def initialize(manager,ic)
		super(manager.win)
		@manager = manager
		#Chargement de la campagne
		@adventure = manager.session
		screen = Constants::SCREEN
		@pad=Constants::BUTTON_PADDING
		@ic=ic
		@gtkObject = Gtk::Table.new(3,3)
		@scrol=ScrollableArea.new(:vertical)
		@boxV=Gtk::Box.new(:vertical)
		@overAllStars = @adventure.overAllStars.to_s

		@etoileTotal=Gtk::Box.new(:horizontal)
		a=Gtk::Alignment.new(0.5,0,0.5,1)
		a.add(@boxV)
		@gtkObject.attach(a,0,1,1,2)

		@boxV.pack_start(@etoileTotal ,expand: false, fill: true, padding:@pad)
		@st=Star.new(1,1,@ic)
		@etoileTotal.pack_start(@st.stars,expand: false, fill: true, padding:@pad)
		nbEtoile=Text.new(@overAllStars)

		nbEtoile.title
		@etoileTotal.pack_start(nbEtoile.gtkObject,expand: false, fill: true, padding:@pad)

		@boxV.pack_start(@scrol.gtkObject,expand: true, fill: true, padding: @pad)

		@nbNiveau=@adventure.adventureInfo.levels.length
		l=@ic.iconAsset(:loc)

    @b=Gtk::Box.new(:horizontal, 25)
		@scrol.add(@b)

		@icones=LevelNumbers.new(manager,@adventure ,@adventure.overAllStarsHash,@ic)
		@b.pack_start(@icones.im,expand: false, fill: true, padding: @pad)
    @menuR=Gtk::Box.new(:horizontal, 25)
		@scrol.add(@menuR)

		retour=Text.new(@textManager.getButtonLabel("adventure", "back"))
    @boxV.pack_start(retour.gtkObject ,expand: false, fill: true, padding:@pad)
  	retour.onClick{
			manager.session.updateSave
			manager.updateSave
    	manager.mainScreen.applyOn(@parent)
		}
    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)
	end

	#
	#=====Presentation
	#This method is used to refresh star's icons
	#=====Return
	# this method return the box etoileTotal which contain all the stars
	##
	def refreshOverAllStar
		@etoileTotal.each { |child|
			@etoileTotal.remove(child)
		}
		@st=Star.new(1,1,@ic)
		@etoileTotal.pack_start(@st.stars,expand: false, fill: true, padding:@pad)
		nbEtoile=Text.new(@adventure.overAllStars.to_s)
		nbEtoile.title
		@etoileTotal.pack_start(nbEtoile.gtkObject,expand: false, fill: true, padding:@pad)
	end

	#
	#=====Presentation
	#This method is used to refresh the page by calling the method refresh of the class LevelNumbers
	#=====Attributes
	# *+widget+ : the widget associated
	#=====Return
	# this method return the widget refreshed
	##
	def applyOn(widget)
		refreshOverAllStar
		@icones.refresh(@manager,@adventure,@adventure.overAllStarsHash)
		super(widget)
	end
end

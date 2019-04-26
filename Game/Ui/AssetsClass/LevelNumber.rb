# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   1-Mar-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: LevelNumber.rb
# @Last modified by:   zeigon
# @Last modified time: 28-Mar-2019

require 'gtk3'
require File.dirname(__FILE__) + "/Asset"
require File.dirname(__FILE__) + "/../AssetsLoaderClass/IconAsset"

def require_all(_dir)
	Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each { |file|
		require file
	}
end
##
# ===== Presentation
#LevelNumber only needs to be initialized and refresh.
#It creates and implements the level number icon.
##
class LevelNumber
		attr_reader :BoxV
		##
		# ===== Presentation
		# This method is used to create the level icon.
		# An icon contain a level number icon from the levels numbers menu by creating its
		# number, box of star corresponding and the lock icon if needed.
		# Icons are loaded thanks to iconAsset
		# All the other variables are used for the layout.
		# ===== Attributes
		# *+manager+ : managerUi who handles the Ui.
		# *+adventure+ : class adventure session
		# *+adventureInfo+ : hash table that contains all the stars own per level
		# *+i+ : number of the level associated
		#
  def initialize(i,manager,adventure, adventureInfo,ic)
		@police=25
		@ic=ic
    @BoxH=Gtk::Box.new(:horizontal)
    @BoxV=Gtk::Box.new(:vertical)
    @lock=Gtk::EventBox.new()
    @stars=Gtk::Box.new(:horizontal,10)
		@overAllStars = 0
		@adventureInfo=adventureInfo
		@s=Star.new(adventure.getLevelInformation(i)[3],0,ic)
		refresh(i,manager,adventure,adventureInfo)
  end
	##
	# ===== Presentation
	# This method is used to refresh the level icon.
	# An icon contain a level number icon from the levels numbers menu by refreshing its
	# number, box of star corresponding and the lock icon if needed.
	# ===== Attributes
	# *+manager+ : managerUi who handles the Ui.
	# *+adventure+ : class adventure session
	# *+adventureInfo+ : hash table that contains all the stars own per level
	# *+i+ : number of the level associated
	#
  def refresh(i,manager,adventure,adventureInfo)
		@adventureInfo=adventureInfo
		@BoxH.each { |child|
			@BoxH.remove(child)
		}
    @BoxV.each { |child|
      @BoxV.remove(child)
    }
		@BoxH=Gtk::Box.new(:horizontal)

		niveau=Text.new(i.to_s,@police*6)
		if @adventureInfo.has_key?(i)
		      @s.refresh(adventure.getLevelInformation(i)[3],@adventureInfo.fetch(i))
		 end

    @BoxV.pack_start(@BoxH,expand: false, fill: true, padding: @pad)
    @BoxH.pack_start(niveau.gtkObject,expand: false, fill: true, padding: @pad)
    @BoxV.pack_start(@s.stars,expand: false, fill: true, padding: @pad)

    if adventure.lvlAvailable?(i)
      niveau.onClick{
        session=adventure.getLevel(i)
        manager.runGameSession(session,true)

      }
    else
      loc = @ic.iconAsset(:loc)
      loc.resize(100,100)
      loc.applyOn(@lock)
      @BoxH.pack_start(@lock,expand: false, fill: true, padding: @pad)
    end
    @BoxV.show_all

  end
end

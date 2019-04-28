# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   1-Mar-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: LevelNumbers.rb
# @Last modified by:   zeigon
# @Last modified time: 28-Mar-2019

require 'gtk3'
require File.dirname(__FILE__) + "/Asset"
require File.dirname(__FILE__) + "/LevelNumber"


def require_all(_dir)
	Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each { |file|
		require file
	}
end
##
# ===== Presentation
# The LevelNumbers class creates and implements all the levels numbers icon.
#
# ===== Methods
# LevelNumbers only needs to be initialized and refreshed.
class LevelNumbers
	# :nodoc:
  attr_reader :im
  # :startdoc:

	##
	# ===== Presentation
	# This method is used to create all the levels icons by calling the LevelNumber class.
	# All the other variables are used for the layout.
	#
	# ===== Attributes
	# * +manager+ : managerUi who handles the Ui.
	# * +adventure+ : Represents the AdventureSession class.
	# * +adventureInfo+ : A hash table that contains all the stars owned per level.
  def initialize(manager,adventure ,adventureInfo,ic)
		@pad=Constants::BUTTON_PADDING
		@im=Gtk::Box.new(:vertical, 25)
		@ic=ic
    (1.. adventure.adventureInfo.levels.length).each { |i|
      @ico=LevelNumber.new(i,manager,adventure ,adventureInfo,@ic)
      @im.pack_start(@ico.BoxV,expand: false, fill: true, padding: @pad)
    }
    @im.show_all
  end

	##
	# ===== Presentation
	# This method is used to refresh all the levels icons by calling the class LevelNumber.
	#
	# ===== Attributes
	# * +manager+ : ManagerUi who handles the Ui.
	# * +adventure+ : Represents the AdventureSession class.
	# * +adventureInfo+ : A hash table that contains all the stars owned per level.
  def refresh(manager,adventure ,adventureInfo)
		@im.each { |child|
			@im.remove(child)
		}
    (1.. adventure.adventureInfo.levels.length).each { |i|
			@ico=LevelNumber.new(i,manager,adventure ,adventureInfo,@ic)
      @im.pack_start(@ico.BoxV,expand: false, fill: true, padding: @pad)
    }
    @im.show_all
  end

end

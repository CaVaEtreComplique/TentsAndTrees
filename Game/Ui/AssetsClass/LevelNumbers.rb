# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   1-Mar-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: ChoixDiff.rb
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

class LevelNumbers
  attr_reader :im
  def initialize(manager,adventure ,adventureInfo)
		@im=Gtk::Box.new(:vertical, 25)
    (1.. 5).each { |i|
      @ic=LevelNumber.new(i,manager,adventure ,adventureInfo)
      @im.pack_start(@ic.BoxV,expand: false, fill: true, padding: @pad)
    }
    @im.show_all
  end
  def refresh(manager,adventure ,adventureInfo)
		@im.each { |child|
			@im.remove(child)
		}
    (1.. 5).each { |i|
			@ic=LevelNumber.new(i,manager,adventure ,adventureInfo)
      @im.pack_start(@ic.BoxV,expand: false, fill: true, padding: @pad)
    }
    @im.show_all
  end

end

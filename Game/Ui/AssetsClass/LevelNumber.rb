# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   1-Mar-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: ChoixDiff.rb
# @Last modified by:   zeigon
# @Last modified time: 28-Mar-2019

require 'gtk3'
require File.dirname(__FILE__) + "/Asset"


def require_all(_dir)
	Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each { |file|
		require file
	}
end

class LevelNumber
		attr_reader :BoxV
  def initialize(i,manager,adventure, adventureInfo)
		@police=25
    @BoxH=Gtk::Box.new(:horizontal)
    @BoxV=Gtk::Box.new(:vertical)
    @lock=Gtk::EventBox.new()
    @stars=Gtk::Box.new(:horizontal,10)
		@overAllStars = 0
		@adventureInfo=adventureInfo
		@s=Star.new(adventure.getLevelMaxStars(i),0)
		refresh(i,manager,adventure,adventureInfo)
  end

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
		if @adventureInfo.include?(i)
      @s.refresh(adventure.getLevelMaxStars(i),@adventureInfo.fetch(i))
    end


    @BoxV.pack_start(@BoxH,expand: false, fill: true, padding: @pad)
    @BoxH.pack_start(niveau.gtkObject,expand: false, fill: true, padding: @pad)
    @BoxV.pack_start(@s.stars,expand: false, fill: true, padding: @pad)

    if adventure.lvlAvailable?(i,3)
      niveau.onClick{
        session=adventure.getLevel(i,@adventureInfo)
        manager.runGameSession(session)

      }
    else
      loc = Asset.new(File.dirname(__FILE__) + "/../../../Assets/Characters/lock.png")
      loc.resize(100,100)
      loc.applyOn(@lock)
      @BoxH.pack_start(@lock,expand: false, fill: true, padding: @pad)
    end
    @BoxV.show_all

  end
end

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

class Star
  attr_reader :stars
  def initialize(nbEtoile,nbEtoileObtenu)
		@sHappy=Asset.new(File.dirname(__FILE__) + "/../../../Assets/star.png")
		@sSad=Asset.new(File.dirname(__FILE__) + "/../../../Assets/starSad.png")
    @stars=Gtk::Box.new(:horizontal,25)
		refresh(nbEtoile,nbEtoileObtenu)
   end
	 def refresh(nbEtoile,nbEtoileObtenu)
		 @stars.each{|child|
			 @stars.remove(child)
		 }
		 (1.. nbEtoile).each { |e|
				@star=Gtk::EventBox.new()
				if(e <= nbEtoileObtenu)
				 sH= @sHappy
				 sH.resize(75,75)
				 sH.applyOn(@star)
			 else
				 sS=@sSad
				 sS.resize(75,75)
				 sS.applyOn(@star)
			 end
				@stars.add(@star)
			}
			@stars.show_all
	 end
end

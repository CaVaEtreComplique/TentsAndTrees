# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   1-Mar-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: ChoixDiff.rb
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
# Star only needs to be initialized and refresh.
# It creates and implements all the star's icon of the game.
##
class Star
  attr_reader :stars
	##
	# ===== Presentation
	# This method is used to create all the star's icons.
	# Icons are loaded thanks to iconAsset
	# All the other variables are used for the layout.
	# ===== Attributes
	# *+nbEtoile+: contain the maximun number of star that you can have
	#*+nbEtoileObtenu+: contain the number of star that you have for a level
	#
  def initialize(nbEtoile,nbEtoileObtenu,ic)
		@ic=ic
		@stars=Gtk::Box.new(:horizontal,25)
		refresh(nbEtoile,nbEtoileObtenu)
   end
	 ##
	 # ===== Presentation
	 # This method is used to refresh all the star's icons.
	 # ===== Attributes
	 # *+nbEtoile+: contain the maximun number of star that you can have
	 #*+nbEtoileObtenu+: contain the number of star that you have for a level
	 #
	 def refresh(nbEtoile,nbEtoileObtenu)
		 @stars.each{|child|
			 @stars.remove(child)
		 }
		 (1.. nbEtoile).each { |e|
				@star=Gtk::EventBox.new()
				if(e <= nbEtoileObtenu)
				 sH=@ic.iconAsset(:starH)
				 sH.resize(75,75)
				 sH.applyOn(@star)
			 else
				 sS=@ic.iconAsset(:starS)
				 sS.resize(75,75)
				 sS.applyOn(@star)
			 end
				@stars.add(@star)
			}
			@stars.show_all
	 end
end

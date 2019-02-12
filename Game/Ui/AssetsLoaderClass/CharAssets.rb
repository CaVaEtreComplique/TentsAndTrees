# @Author: Corentin Petit <CorentinPetit>
# @Date:   10-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: CharAssets.rb
# @Last modified by:   CorentinPetit
# @Last modified time: 12-Feb-2019


require File.dirname(__FILE__) + "/../AssetsClass/CharAsset"

class CharAssets
	@@charAssets
	@asset

	attr_reader :asset

	# @buttons ...
	def initialize(char,width)
	 	if defined?(@@charAssets).nil? then @@charAssets = Hash.new end
		@asset = @@charAssets.fetch([char.upcase,width]){
			asset={[char.upcase,width] => CharAsset.new(char,width)}
			@@charAssets.merge!(asset)
			asset.fetch([char.upcase,width])
		}
	end

	# @buttons ...
	def charAsset(char=" ")
    @charAssets.fetch(char.upcase)
	end

	def charAssetSelected(char=" ")

	end

end

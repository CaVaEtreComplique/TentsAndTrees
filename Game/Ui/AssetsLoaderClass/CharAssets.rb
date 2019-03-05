# @Author: Corentin Petit <CorentinPetit>
# @Date:   10-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: CharAssets.rb
# @Last modified by:   zeigon
# @Last modified time: 04-Mar-2019


require File.dirname(__FILE__) + "/../AssetsClass/CharAsset"

class CharAssets
	@@charAssets
	@asset

	attr_reader :asset

	# @buttons ...
	def initialize(char,width)
	 	if defined?(@@charAssets).nil? then @@charAssets = Hash.new end
		@asset = @@charAssets.fetch([char.upcase,width]){
			asset={[char,width] => CharAsset.new(char,width)}
			@@charAssets.merge!(asset)
			asset.fetch([char,width])
		}
	end

	# @buttons ...
	def charAsset(char=" ")
    @charAssets.fetch(char)
	end

	def charAssetSelected(char=" ")

	end

end

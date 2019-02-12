# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: BackgroundAsset.rb
# @Last modified by:   CorentinPetit
# @Last modified time: 10-Feb-2019



require File.dirname(__FILE__) + "/Asset"

class BackgroundAsset < Asset

	def resize
    screen = Gdk::Screen.default
    super(screen.width,screen.height)
	end

end

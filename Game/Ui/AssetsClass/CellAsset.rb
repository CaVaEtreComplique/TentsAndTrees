# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: CellAsset.rb
# @Last modified by:   CorentinPetit
# @Last modified time: 11-Feb-2019



require File.dirname(__FILE__) + "/Asset"
require File.dirname(__FILE__) + "/../Constants"

##
# ===== 404
# This class was not commented in the first place, so it can not be documented.
class CellAsset < Asset
	# :nodoc:
	@image
	@buffer
	def initialize(file,nRows, nCols)
		@nRows=nRows
		@nCols=nCols
		super(file)
		resize
	end

	def resize
			screen = Gdk::Screen.default
			m1=((screen.width*0.7 ) / (@nCols+1)) - Constants::SPACING
			m2=((screen.height*1.0) / (@nRows+1)) - Constants::SPACING
			mf= m1 < m2 ? m1 : m2
			super(mf,mf)
		end
end

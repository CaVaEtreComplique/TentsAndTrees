require File.dirname(__FILE__) + "/Asset"
require File.dirname(__FILE__) + "/../Constants"

class CellAsset < Asset
	@image
	@buffer
	def initialize(file,nRows, nCols)
		@nRows=nRows
		@nCols=nCols
		super(file)
	end

	def resize
			screen = Gdk::Screen.default
			m1=((screen.width*0.7 ) / (@nCols+1)) - Constants::SPACING
			m2=((screen.height*1.0) / (@nRows+1)) - Constants::SPACING
			mf= m1 < m2 ? m1 : m2
			@buffer=@buffer.scale(mf, mf, :bilinear)
		end
end

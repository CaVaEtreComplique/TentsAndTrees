require File.dirname(__FILE__) + "/Asset"

class BackgroundAsset < Asset

	def resize
		screen = Gdk::Screen.default
		@image.resize(screen.width.to_s+"x"+screen.height.to_s)
	end

end

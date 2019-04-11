


require File.dirname(__FILE__) + "/../AssetsClass/LevelNumber"
require File.dirname(__FILE__) + "/../AssetsClass/LevelNumbers"


class IconAsset
  @iconAsset
  def initialize
    pathToIcon=File.dirname(__FILE__) + "/../../../Assets/Icon/"
    @iconAsset= {
      loc: [Asset.new(pathToIcon+"lock.png")],
      starS:[Asset.new(pathToIcon+"starSad.png")],
      starH:[Asset.new(pathToIcon+"star.png")]
    }
  end

end

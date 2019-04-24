


class IconAsset
  attr_reader :iconAsset
  @iconAsset
  def initialize
    pathToIcon=File.dirname(__FILE__) + "/../../../Assets/Icons/"
    @iconAsset= {
      loc: Asset.new(pathToIcon+"lock.png"),
      starS:Asset.new(pathToIcon+"starSad.png"),
      starH:Asset.new(pathToIcon+"star.png")
    }
  end
end

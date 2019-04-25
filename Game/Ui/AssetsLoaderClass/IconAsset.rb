


class IconAsset
  attr_reader :iconAsset
  @iconAsset
  def initialize
    pathToIcon=File.dirname(__FILE__) + "/../../../Assets/Icons/"
    @iconAsset= {
      loc: Asset.new(pathToIcon+"lock.png"),
      starS:Asset.new(pathToIcon+"starSad.png"),
      starH:Asset.new(pathToIcon+"star.png"),
      diapo1: Asset.new(File.dirname(__FILE__) + "/../../../Assets/regle/regle1.png"),
      diapo2: Asset.new(File.dirname(__FILE__) + "/../../../Assets/regle/regle2.png"),
      diapo3: Asset.new(File.dirname(__FILE__) + "/../../../Assets/regle/regle3.png"),
      diapo4: Asset.new(File.dirname(__FILE__) + "/../../../Assets/regle/regle4.png")
    }
  end
end

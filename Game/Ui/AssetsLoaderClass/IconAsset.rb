
# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   25-Jan-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: IconAsset.rb
# @Last modified by:   vaidie Camille
# @Last modified time: 08-Apr-2019

##
# ===== Presentation
# Star only needs to be initialized.
# It load all the icon.
##
class IconAsset
  attr_reader :iconAsset
  @iconAssets
  ##
  # ===== Presentation
  # This method is used to load all the icon by putting them in a hash table @iconAsset
  def initialize
    pathToIcon=File.dirname(__FILE__) + "/../../../Assets/Icons/"
    @iconAssets= {
      loc: Asset.new(pathToIcon+"lock.png"),
      starS:Asset.new(pathToIcon+"starSad.png"),
      starH:Asset.new(pathToIcon+"star.png"),
      diapo1: Asset.new(File.dirname(__FILE__) + "/../../../Assets/regle/regle1.png"),
      diapo2: Asset.new(File.dirname(__FILE__) + "/../../../Assets/regle/regle2.png"),
      diapo3: Asset.new(File.dirname(__FILE__) + "/../../../Assets/regle/regle3.png"),
      diapo4: Asset.new(File.dirname(__FILE__) + "/../../../Assets/regle/regle4.png")
    }
  end
  def iconAsset(state)
    case state
      when :loc
        @iconAssets.fetch(:loc)
      when :starS
        @iconAssets.fetch(:starS)
      when :starH
        @iconAssets.fetch(:starH)
      when :diapo1
        @iconAssets.fetch(:diapo1)
      when :diapo2
        @iconAssets.fetch(:diapo2)
      when :diapo3
        @iconAssets.fetch(:diapo3)
      when :diapo4
        @iconAssets.fetch(:diapo4)
    end
  end
end

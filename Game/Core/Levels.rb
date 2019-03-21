# @Author: Quentin Goncalves <QuentinGoncalves>
# @Date:   18-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: Levels.rb
# @Last modified by:   QuentinGoncalves
# @Last modified time: 18-Mar-2019

require File.dirname(__FILE__) + "/AdventureLevel"

class Levels

	def initialize()
    @levels = {
			level1: AdventureLevel.new(:quickplay, :easy, 1, 3, false),
			level2: AdventureLevel.new(:timeAttack, :easy, false, 3, 1),
			level3: AdventureLevel.new(:quickplay, :easy, 0.95, 3, false),
			level4: AdventureLevel.new(:timeAttack, :easy, false, 3, 2),
			level5: AdventureLevel.new(:quickplay, :easy, 0.9, 3, false)
		}
	end

  def getLevel(level)
    @levels.fetch(level)
  end
end

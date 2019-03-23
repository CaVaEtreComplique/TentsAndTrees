# @Author: Quentin Goncalves <QuentinGoncalves>
# @Date:   18-Mar-2019
# @Email:  quentin.goncalves.etu@univ-lemans.fr
# @Filename: Levels.rb
# @Last modified by:   QuentinGoncalves
# @Last modified time: 18-Mar-2019

require File.dirname(__FILE__) + "/AdventureLevel"

class Levels

	def initialize()
    @levels = {
			1 =>  AdventureLevel.new(:quickplay, :easy, 1, 3, false),
			2 => AdventureLevel.new(:timeAttack, :easy, false, 3, 1),
			3 => AdventureLevel.new(:quickplay, :easy, 0.95, 3, false),
			4 => AdventureLevel.new(:timeAttack, :easy, false, 3, 2),
			5 => AdventureLevel.new(:quickplay, :easy, 0.9, 3, false)
		}
	end

  def getLevel(level)
    @levels.fetch(level)
  end
end

# @Author: Quentin Goncalves <QuentinGoncalves>
# @Date:   18-Mar-2019
# @Email:  quentin.goncalves.etu@univ-lemans.fr
# @Filename: Levels.rb
# @Last modified by:   QuentinGoncalves
# @Last modified time: 18-Mar-2019

require File.dirname(__FILE__) + "/AdventureLevel"

class Levels

		attr_reader :levels

	def initialize()
    @levels = {
			1 => [:quickplay, :easy, 1, 3, 1,1],
			2 => [:timeAttack, :easy, 1, 3, 2,2],
			3 => [:quickplay, :easy, 0.95, 3, 1,3],
			4 => [:timeAttack, :easy, 1, 3, 2,4],
			5 => [:quickplay, :easy, 0.9, 5, 1,5]
		}
		@neededStars = {
			1 => 0,
			2 => 1,
			3 => 3,
			4 => 5,
			5 => 8
		}

	end

  def getLevel(level,overallStars)
    levelInfo = @levels.fetch(level)
		AdventureLevel.new(levelInfo[0], levelInfo[1], levelInfo[2], levelInfo[3], levelInfo[4], overallStars,levelInfo[5])
  end

	def getLevelMaxStars(lvl)
		levelInfo= @levels.fetch(lvl)
		return levelInfo[3]
	end

	def lvlAvailable?(lvl, overAllStars)
		if @neededStars.fetch(lvl) > overAllStars
			false
		else
			true
		end
	end

end

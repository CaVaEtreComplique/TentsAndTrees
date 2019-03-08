# @Author: Corentin Petit <zeigon>
# @Date:   08-Mar-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: NewSession.rb
# @Last modified by:   zeigon
# @Last modified time: 08-Mar-2019

require File.dirname(__FILE__) +  "/Session"

class NewSession < Session

  def initialize(gameMode, difficulty)
    super(gameMode, difficulty)
		@score=0
    replay(false)
  end

end

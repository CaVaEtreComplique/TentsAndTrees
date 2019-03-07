# @Author: Corentin Petit <zeigon>
# @Date:   13-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: ChronoUi.rb
# @Last modified by:   zeigon
# @Last modified time: 13-Feb-2019

require File.dirname(__FILE__) + "/Button"


class ChronoUi < Button

	attr_reader :time

	def initialize(time)
    super(:horizontal,"%02dh %02dm %02ds" % parce(time))
	end


  def updateLabel(time)
	  super("%02dh %02dm %02ds" % parce(time))
  end

	def parce(time)
	  s, m = time % 60, time / 60
	  h = m / 60
	  m = m % 60
		[h, m, s]
	end

end

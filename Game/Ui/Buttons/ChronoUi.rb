# @Author: Corentin Petit <zeigon>
# @Date:   13-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: ChronoUi.rb
# @Last modified by:   zeigon
# @Last modified time: 13-Feb-2019

class ChronoUi < Button

	attr_reader :time

	def initialize(time)
	  s, m = time % 60, time / 60
	  h = m / 60
	  m = m % 60
    super(:horizontal,"%02dh %02dm %02ds" % [h, m, s])
	end


  def updateLabel(time)
	  s, m = time % 60, time / 60
	  h = m / 60
	  m = m % 60
	  super("%02dh %02dm %02ds" % [h, m, s])
  end

	def kill
		@run=false
	end

end

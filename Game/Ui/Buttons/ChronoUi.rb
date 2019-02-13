# @Author: Corentin Petit <zeigon>
# @Date:   13-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: ChronoUi.rb
# @Last modified by:   zeigon
# @Last modified time: 13-Feb-2019

class ChronoUi < Button

	def initialize(glibChrono, displayMode=true)
    @glibChrono=glibChrono
    @displayMode=displayMode
    super(:horizontal,"")
	end


  def run()
		@run=true
  Thread.new{
    while @run
      time=@glibChrono.elapsed[0]
      s, m = time % 60, time / 60
  		h = m / 60
  		m = m % 60
      updateLabel("%02dh %02dm %02ds" % [h, m, s])
      sleep(1)
    end
  }
  end

	def kill
		@run=false
	end

end

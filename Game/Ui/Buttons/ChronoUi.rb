# @Author: Corentin Petit <zeigon>
# @Date:   13-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: ChronoUi.rb
# @Last modified by:   zeigon
# @Last modified time: 29-Mar-2019

require File.dirname(__FILE__) + "/Button"

##
# ==== Presentation
#
# The ChronoUI class is inherited from the Button class and manages the in-game
# chronometer.
#
# ==== Methods
#
# This class knows three methods : initialize, updateLabel (both
# inherited from the Button class) and the parce method. These methods are
# described further down.
#
# ==== Variable
#
# The only variable this class needs is the time value.
class ChronoUi < Text

	#:nodoc:
	attr_reader :time
	#:startdoc:

	# The initialization method creates a new button with specific values for the
	# chronometer's creation.
	def initialize(time)
    super("%02dh %02dm %02ds" % parce(time))
    @font="Arial"
    @color="black"
    @weight="normal"
    @style="normal"
	end

	# The updateLabel method updates the chronometer button's label in order to
	# actualize it at each time change.
  def updateLabel(time)
	  super("%02dh %02dm %02ds" % parce(time))
  end

	# The parce method is needed for the initialization and for the label update.
	# It gives the time a value that is easily read by humans. By doing so, it
	# can be displayed in the game.
	def parce(time)
	  s, m = time % 60, time / 60
	  h = m / 60
	  m = m % 60
		[h, m, s]
	end

end

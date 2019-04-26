# @Author: Corentin Petit <zeigon>
# @Date:   13-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: ChronoUi.rb
# @Last modified by:   zeigon
# @Last modified time: 11-Apr-2019

require File.dirname(__FILE__) + "/Text"

##
# ===== Presentation
# The ChronoUI class is inherited from the Text class and manages the in-game
# chronometer.
#
# ===== Methods
# This class knows three methods : initialize, updateLabel (both
# inherited from the Text class) and the parce method. These methods are
# described further down.
#
# ===== Variables
# * +time+ - The only variable in the class, the time's value.
class ChronoUi < Text

	#:nodoc:
	attr_reader :time
	#:startdoc:

	##
	# ===== Presentation
	# The initialization method creates a new button with specific values for the
	# chronometer's creation.
	#
	# ===== Attributes
	# * +time+ - The time's value.
	#
	# ===== Examples
	# This method will first call the initializer from Text with the parsed time
	# attribute :
	#     super("%02dh %02dm %02ds" % parce(time))
	#
	# It will then define the font, color, weight and style of the
	# background and apply it :
	#      @font="Arial"
   #      @color="black"
	#      @weight="normal"
	#      @style="normal"
   #      setBackground 0.8, 0.5, 0.1, 1
   #      apply
	def initialize(time)
    super("%02dh %02dm %02ds" % parce(time))
    @font="Arial"
    @color="black"
    @weight="normal"
    @style="normal"
		setBackground 0.8, 0.5, 0.1, 1
		apply
	end

	##
	# ===== Presentation
	# The updateLabel method updates the chronometer button's label in order to
	# actualize it at each time change.
	#
	# ===== Attributes
	# * +time+ - The time's value.
  def updateLabel(time)
	  super("%02dh %02dm %02ds" % parce(time))
  end

	##
	# ===== Presentation
	# The parce method is needed for the initialization and for the label update.
	# It gives the time a value that is easily read by humans. By doing so, it
	# can be displayed in the game.
	#
	# ===== Attributes
	# * +time+ - The time's value.
	#
	# ===== Returns
	# This method returns the parsed time.
	#
	# ===== Examples
	# This method first gives a value to the seconds and minutes of the timer :
	#      s, m = time % 60, time / 60
	# Then the hour gets its value :
	#      h = m / 60
	# And finally the minutes get the correct value :
	#      m = m % 60
	# The time can now be returned in an arrray in the format H/M/S :
	#      [h, m, s]
	# ----------
	def parce(time)
	  s, m = time % 60, time / 60
	  h = m / 60
	  m = m % 60
		[h, m, s]
	end

end

# @Author: Maxime Touze <Maxime>
# @Date:   05-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: FictivHelper.rb
# @Last modified by:   Maxime
# @Last modified time: 15-Mar-2019

##
# ===== Presentation
# The FictivHelper class is a fictive helper class.
# Its role is to say that all the helper classes need to have a help method.
#
# ===== Methods
# * +help+ - Don't use this class' one.
class FictivHelper

   # :nodoc:
  private_class_method :new
  # :startdoc:

  ##
  # ===== Presentation
  # This method helps the player but needs to be defined in the helper class.
  #
  # ===== Attributes
  # * +game+ - The game you need help for.
  #
  # ===== Returns
  # By default, returns a HelpNotFound instance.
  #
  # ===== How to use
  # To get help :
  #     aHelper_instace.help(theGameYouWantHelpFor)
  def help(game)
    return HelpNotFound.new()
  end
end

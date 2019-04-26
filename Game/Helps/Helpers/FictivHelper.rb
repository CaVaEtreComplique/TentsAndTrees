# @Author: Maxime Touze <Maxime>
# @Date:   05-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: FictivHelper.rb
# @Last modified by:   Maxime
# @Last modified time: 15-Mar-2019

##
# ===== Presentation
# The FictivHelper class is a fictiv helper class,
# it's role is to say that all helper classes need to have help method
#
# ===== Methods
# * +help+ - don't use this class' one.
class FictivHelper
  private_class_method :new
  ##
  # ===== Presentation
  # This method help the player but need to be definded in the helper class.
  #
  # ===== Attributes
  # * +game+ - The game you want a help for.
  #
  # ===== Returns
  # By default, return HelpNotFound instance
  #
  # ===== How to use
  # To get a help:
  #     aHelper_instace.help(theGameYouWantHelpFor)
  # -----------
  def help(game)
    return HelpNotFound.new()
  end
end

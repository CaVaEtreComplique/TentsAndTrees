# @Author: Maxime Touze <Maxime>
# @Date:   05-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpOnAColumn.rb
# @Last modified by:   Maxime
# @Last modified time: 15-Mar-2019



require File.dirname(__FILE__) + "/../HelpOnRowsAndColumn"

class HelpOnAColumn < HelpOnRowsAndColumn
  #helps player when we need to give a column
  private_class_method :new  #abstract class
  def initialize(column)
    super(column)
  end
end

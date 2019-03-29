# @Author: Maxime Touze <Maxime>
# @Date:   06-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpAllTentsOnAColumn.rb
# @Last modified by:   maxime
# @Last modified time: 29-Mar-2019



require File.dirname(__FILE__) + "/../HelpOnAColumn"
#Help witch fill with grass a column who have all it's tents
class HelpAllTentsOnAColumn < HelpOnAColumn
  # Help when all the tents are placed and we need only grass
  public_class_method :new #instanciable class
  def initialize(column)
    super(column)
  end

  def getText(helpLevel) #returns the text of the help, saying that "All tents need have been placed, so all the empty cells of the column are grass"
    case(helpLevel)
      when 1
        @helpText = "You placed all the tents of a column"
      when 2
        @helpText = "You placed all the tents on a column, so all the white cells are grass"
      when 3
          @helpText = "All tents needed have been placed, so all the empty cells of the column " + @column[0].row.to_s + " are grass"
      else
          super(helpLevel)
      end
  end
end

# @Author: Maxime Touze <Maxime>
# @Date:   06-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpAllGrassOnARow.rb
# @Last modified by:   maxime
# @Last modified time: 29-Mar-2019



require File.dirname(__FILE__) + "/../HelpOneRow"

class HelpAllGrassOnARow < HelpOneRow
  #help the player when there is a row with all the grass needed, so the player need to fill with tents
  public_class_method :new #instanciable class

  def initialize(row)
    super(row)
  end

  def getText(helpLevel) #returns the text of the help, saying that "All tents need to be placed, so all the empty cells of the row ° are tents"

    case(helpLevel)
      when 1
        @helpText = "You placed all the grass of a row"
      when 2
        @helpText = "You placed all the grass on a row, so all the white cells are tents"
      when 3
        @helpText = "All grass needed have been placed, so all the empty cells of the row " + @row[0].column.to_s + " are tents"
      else
          super(helpLevel)
      end
  end
end

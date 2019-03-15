# @Author: Maxime Touze <Maxime>
# @Date:   06-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpAllGrassOnARow.rb
# @Last modified by:   Maxime
# @Last modified time: 15-Mar-2019



require File.dirname(__FILE__) + "/../HelpOneRow"

class HelpAllGrassOnARow < HelpOneRow
  #help the player when there is a row with all the grass needed, so the player need to fill with tents
  public_class_method :new #instanciable class

  def initialize(row)
    super(row)
  end

  def getText #returns the text of the help, saying that "All tents need to be placed, so all the empty cells of the row ° are tents"
    @helpText = "All grass needed have been placed, so all the empty cells of the row " + @row[0].row.to_s + " are tents"
  end
end

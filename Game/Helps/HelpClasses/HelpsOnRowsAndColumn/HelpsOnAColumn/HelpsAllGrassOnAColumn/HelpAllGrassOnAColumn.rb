# @Author: Maxime Touze <Maxime>
# @Date:   06-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpAllGrassOnAColumn.rb
# @Last modified by:   maxime
# @Last modified time: 31-Mar-2019



require File.dirname(__FILE__) + "/../HelpOnAColumn"
#Help witch fill with tent a column who only need tents
class HelpAllGrassOnAColumn < HelpOnAColumn
  # Help when all the grass are placed and we need only tents
  public_class_method :new #instanciable class
  def initialize(column)
    super(column)
  end

  def getText(helpLevel) #allgrassoncolumn
    #returns the text of the help, saying that "All tents need to be placed, so all the empty cells of the column ° are tents"

    case(helpLevel)
      when 1
        @helpText = @textManager.getHelpsTexts("allgrassoncolumn", helpLevel, 0)
      when 2
        @helpText = @textManager.getHelpsTexts("allgrassoncolumn", helpLevel, 0)
      when 3
        @helpText = @textManager.getHelpsTexts("allgrassoncolumn", helpLevel, 0) + @column[0].row.to_s + @textManager.getHelpsTexts("allgrassoncolumn", helpLevel, 1)
      else
          super(helpLevel)
      end
  end
end

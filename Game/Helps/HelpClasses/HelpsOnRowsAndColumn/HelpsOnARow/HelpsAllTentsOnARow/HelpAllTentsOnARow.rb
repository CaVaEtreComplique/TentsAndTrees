# @Author: Maxime Touze <Maxime>
# @Date:   08-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpAllTentsOnARow.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019



require File.dirname(__FILE__) + "/../HelpOneRow"

class HelpAllTentsOnARow < HelpOneRow
  #class saying that all tents of the row are placed, it need to be filled with grass
  public_class_method :new #instanciable class
  def initialize(row)
    super(row)
  end

  def getText(helpLevel) #alltentsonrow
    #returns the text of the help, saying that "All tents needed are placed, so all the empty cells of the row ° are grass"
    case(helpLevel)
      when 1
        @helpText = @textManager.getHelpsTexts("alltentsonrow", helpLevel, 0)
      when 2
        @helpText = @textManager.getHelpsTexts("alltentsonrow", helpLevel, 0)
      when 3
        @helpText = @textManager.getHelpsTexts("alltentsonrow", helpLevel, 0) + @row[0].column.to_s + @helpText = @textManager.getHelpsTexts("alltentsonrow", helpLevel, 1)
      else
          super(helpLevel)
      end
  end
end

# @Author: Maxime Touze <Maxime>
# @Date:   05-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpOnAColumn.rb
# @Last modified by:   maxime
# @Last modified time: 05-Apr-2019



require File.dirname(__FILE__) + "/../HelpOnRowsAndColumn"

class HelpOnAColumn < HelpOnRowsAndColumn
  #helps player when we need to give a column
  private_class_method :new  #abstract class
  def initialize(column)
    super(column)
  end
  def cellsList(helpLevel)
    res = super(helpLevel)

    if(helpLevel == 3)
      @column.each{ |cell|
        res.push(cell)
       }
     end

    return res
  end
end

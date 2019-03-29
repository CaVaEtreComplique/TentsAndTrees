# @Author: Maxime Touze <Maxime>
# @Date:   05-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpOneRow.rb
# @Last modified by:   maxime
# @Last modified time: 29-Mar-2019



#Helps whitch help for a row

require File.dirname(__FILE__) + "/../HelpOnRowsAndColumn"

class HelpOneRow < HelpOnRowsAndColumn
  #help gave when player need a help by giving a row
  private_class_method :new  #abstract

  def initialize(row)
    super(row)
  end
  def cellsList(helpLevel)
    res = super(helpLevel)
    if(helpLevel == 3)
      @row.each{ |cell|
        res.push(cell)
       }
     end
    return res
  end
end

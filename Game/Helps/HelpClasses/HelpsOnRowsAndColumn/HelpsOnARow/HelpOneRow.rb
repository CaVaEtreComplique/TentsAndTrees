# @Author: Maxime Touze <Maxime>
# @Date:   05-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: HelpOneRow.rb
# @Last modified by:   Maxime
# @Last modified time: 15-Mar-2019



#Helps whitch help for a row

require File.dirname(__FILE__) + "/../HelpOnRowsAndColumn"

class HelpOneRow < HelpOnRowsAndColumn
  #help gave when player need a help by giving a row
  private_class_method :new  #abstract

  def initialize(row)
    super(row)
  end
  def cellsList
    res = super()
    @row.each{ |cell|
      res.push(cell)
     }
    return res
  end
end

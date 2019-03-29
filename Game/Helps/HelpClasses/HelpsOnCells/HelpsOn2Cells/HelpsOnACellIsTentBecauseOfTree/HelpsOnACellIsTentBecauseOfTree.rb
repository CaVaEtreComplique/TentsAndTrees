# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: HelpsOnACellIsTentBecauseOfTree.rb
# @Last modified by:   maxime
# @Last modified time: 29-Mar-2019



require File.dirname(__FILE__) + "/../HelpOn2Cells"

class HelpsOnACellIsTentBecauseOfTree < HelpOn2Cells
  #a class for helping when a cell is link to a tree
  public_class_method :new #instanciable
  def initialize(cellTent, cellTree)
    super(cellTent, cellTree)
  end

  def getText(helpLevel)
    #returns the text of the help, saying that a cell touch a class and is some grass
    case helpLevel
      when 1
        return "Un arbre oblige un état d'une case"
      when 2
        return "Un arbre oblige une case à etre une tente"
      when 3
        return "La case " + @cell.to_s + " est une tent car elle touche le reseau d'arbre et tente en " + @cell2.to_s
      else
          super(helpLevel)
    end
  end
end

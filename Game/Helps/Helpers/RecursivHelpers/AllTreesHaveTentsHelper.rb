# @Author: Florian Tourpe <Sckylle>
# @Date:   15-Mar-2019
# @Email:  florian.tourpe@gmail.com
# @Filename: AllTreesHaveTentsHelper2.rb
# @Last modified by:   Sckylle
# @Last modified time: 15-Mar-2019



#Connect tree whith tent in order to find a tent
require File.dirname(__FILE__) + "/../FictivHelper"
require File.dirname(__FILE__) + "/../../CompresseGrid"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpsOnCells/HelpsOn2Cells/HelpsOnACellIsTentBecauseOfTree/HelpsOnACellIsTentBecauseOfTree"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpsOnCells/HelpsOn2Cells/HelpsOn2CellTentUniqueSolution/HelpsOn2CellTentUniqueSolution"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpsOnCells/HelpsOn2Cells/HelpsOn2CellsGrassLinkedTree/HelpsOn2CellsGrassLinkedTree"

class AllTreesHaveTentsHelper < FictivHelper
  public_class_method :new

  def help(game)

    tree = game.tree()
    game = game.game()

    result = Array.new  # Contain the result of research methode
    treeList = Array.new  #An Array send ro research in order to mark tree
    treeAlreadySeen = Array.new #Contain all the tree previously found in research

    whiteCellArray = Array.new #Use to find unique solution for a tree

    nbTree = 0
    nbTent = 0
    answer = nil

    tree.each() do |cell|

      #puts(cell.to_s)

      nbTree = 0 #reset var
      nbTent = 0
      answer = nil
      whiteCellArray = Array.new

      if !treeAlreadySeen.include?(cell)

        if (cell.row + 1 < game.nRow)
          nextCell = game.cellAt(cell.row + 1, cell.column)
          if nextCell.isATent?
            #puts("Test Droit")
            result = research(0, 0, nil, treeList, nextCell, cell, game)
            #puts("Resultat Droit  = " + result[0].to_s + " / " + result[1].to_s)
            treeAlreadySeen += result[3]
            nbTree += result[0]
            nbTent += result[1]
            answer = result[2]
            answer = game.cellAt(cell.row - 1, cell.column) if answer.nil? && (cell.row - 1 >= 0) && game.cellAt(cell.row - 1, cell.column).isAWhite?
          elsif nextCell.isAWhite?
            whiteCellArray.push(nextCell)
          end
        end
        if (cell.row - 1 >= 0)
          nextCell = game.cellAt(cell.row - 1, cell.column)
          if nextCell.isATent?
            #puts("Test Gauche")
            result = research(0, 0, nil, treeList, nextCell, cell, game)
            #puts("Gauche  = " + result[0].to_s + " / " + result[1].to_s)
            treeAlreadySeen += result[3]
            nbTree += result[0]
            nbTent += result[1]
            answer = result[2]
            answer = game.cellAt(cell.row + 1, cell.column) if answer.nil? && (cell.row + 1 < game.nRow) && game.cellAt(cell.row + 1, cell.column).isAWhite?
          elsif nextCell.isAWhite?
            whiteCellArray.push(nextCell)
          end
        end
        if (cell.column + 1 < game.nCol)
          nextCell = game.cellAt(cell.row, cell.column + 1)
          if nextCell.isATent?
            #puts("Test Bas")
            result = research(0, 0, nil, treeList, nextCell, cell, game)
            #puts("Bas  = " + result[0].to_s + " / " + result[1].to_s)
            treeAlreadySeen += result[3]
            nbTree += result[0]
            nbTent += result[1]
            answer = result[2]
            answer = game.cellAt(cell.row, cell.column - 1) if answer.nil? && (cell.column - 1 >= 0) && game.cellAt(cell.row, cell.column - 1).isAWhite?
          elsif nextCell.isAWhite?
            whiteCellArray.push(nextCell)
          end
        end
        if (cell.column - 1 >= 0)
          nextCell = game.cellAt(cell.row, cell.column - 1)
          if nextCell.isATent?
            #puts("Test Haut")
            result = research(0, 0, nil, treeList, nextCell, cell, game)
            #puts("Haut  = " + result[0].to_s + " / " + result[1].to_s)
            treeAlreadySeen += result[3]
            nbTree += result[0]
            nbTent += result[1]
            answer = result[2]
            answer = game.cellAt(cell.row, cell.column + 1) if answer.nil? && (cell.column + 1 < game.nCol) && game.cellAt(cell.row, cell.column + 1).isAWhite?
          elsif nextCell.isAWhite?
            whiteCellArray.push(nextCell)
          end
        end

        nbTree += 1
        if nbTree > nbTent && !answer.nil?
          # puts("La cell " + answer.to_s + " est une reponse ")
          return HelpsOnACellIsTentBecauseOfTree.new(answer, cell)
        elsif nbTree == nbTent && (whiteCellArray.size != 0 || !answer.nil?)
          answer = whiteCellArray.pop if answer.nil?
          #A mod
          return HelpsOn2CellTentUniqueSolution.new(answer, cell)
        elsif whiteCellArray.size == 1  #The tree only has one posibility
          answer = whiteCellArray.pop
          # puts("La cell " + answer.to_s + " est une reponse car case unique")
          return HelpsOn2CellTentUniqueSolution.new(answer, cell)
        end

      end
    end #End each
    return HelpNotFound.new
  end

  def research(nbTree, nbTent, answer, treeList, cell, prevCell, game)

    resultNbTree = 0
    resultNbTent = 0
    resultTreeList = Array.new
    nextCell = nil
    result = nil

    if cell.isATent?
      #puts("TENT || Past : " + prevCell.to_s + " Present : " + cell.to_s)

      if (cell.row + 1 < game.nRow)
        nextCell = game.cellAt(cell.row + 1, cell.column)
        #puts("Droit / Futur : " + nextCell.to_s + " | stat : " + nextCell.state.to_s)
        if ((nextCell.row != prevCell.row) || (nextCell.column != prevCell.column)) && (nextCell.isATree?)# if nextCell is a tree and is not prevCell
          result = research(nbTree, nbTent, answer, treeList, nextCell, cell, game)
          resultNbTree += result[0]
          resultNbTent += result[1]
          answer = result[2] if answer.nil?
        end
      end
      if (cell.row - 1 >= 0)
        nextCell = game.cellAt(cell.row - 1, cell.column)
        #puts("Gauche / Futur : " + nextCell.to_s + " | stat : " + nextCell.state.to_s)
        if ((nextCell.row != prevCell.row) || (nextCell.column != prevCell.column)) && (nextCell.isATree?)
          result = research(nbTree, nbTent, answer, treeList, nextCell, cell, game)
          resultNbTree += result[0]
          resultNbTent += result[1]
          answer = result[2] if answer.nil?
        end
      end
      if (cell.column + 1 < game.nCol)
        nextCell = game.cellAt(cell.row, cell.column + 1)
        #puts("Bas / Futur : " + nextCell.to_s + " | stat : " + nextCell.state.to_s)
        if ((nextCell.row != prevCell.row) || (nextCell.column != prevCell.column)) && (nextCell.isATree?)
          result = research(nbTree, nbTent, answer, treeList, nextCell, cell, game)
          resultNbTree += result[0]
          resultNbTent += result[1]
          answer = result[2] if answer.nil?
        end
      end
      if (cell.column - 1 >= 0)
        nextCell = game.cellAt(cell.row, cell.column - 1)
        #puts("Haut / Futur : " + nextCell.to_s + " | stat : " + nextCell.state.to_s)
        if ((nextCell.row != prevCell.row) || (nextCell.column != prevCell.column)) && (nextCell.isATree?)
          result = research(nbTree, nbTent, answer, treeList, nextCell, cell, game)
          resultNbTree += result[0]
          resultNbTent += result[1]
          answer = result[2] if answer.nil?
        end
      end

      nbTree += resultNbTree
      nbTent += resultNbTent

      return [nbTree, nbTent + 1, answer, treeList]

    #END if cell.isATent?
    else  #cell.isATree?

      #puts("TREE || Past : " + prevCell.to_s + " Present : " + cell.to_s)

      row = (cell.row - prevCell.row) + cell.row
      column = (cell.column - prevCell.column) + cell.column

      if row >= 0 && row < game.nRow && column >= 0 && column < game.nRow
        nextCell = game.cellAt(row, column)
        #puts("X / Futur : " + nextCell.to_s + " | stat : " + nextCell.state.to_s)
        if nextCell.isATent?
          result = research(nbTree, nbTent, answer, treeList, nextCell, cell, game)
          nbTree += result[0]
          nbTent += result[1]
          answer = result[2] if answer.nil?
        elsif nextCell.isAWhite?
          puts("WHITE :")
          answer = nextCell if answer.nil?
        end
      end
      treeList.push(cell)

      return [nbTree + 1, nbTent, answer, treeList]

    end
  end

end

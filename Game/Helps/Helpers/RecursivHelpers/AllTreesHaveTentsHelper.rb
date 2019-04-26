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

##
# ===== Presentation
# The AllTreesHaveTentsHelper class is a helper class inherited from FictivHelper.
# Its role is to find the type of cell who is next to a tree.
#
# ===== Methods
# * +help+ - This method is inherited from FictivHelper, but definded there.
class AllTreesHaveTentsHelper < FictivHelper
  public_class_method :new

  @game
  @treeList
  @answer
  @nbTent
  @nbTree

  ##
  # ===== Presentation
  # This method tries to create network of tent an tree in order to find the
  # emplacement of an tent or a grass.
  #
  # ===== Attributes
  # * +game+ - The game you want help for.
  #
  # ===== Returns
  # If it finds a tree, try to create a network with tree and tents return :
  # HelpsOnACellIsTentBecauseOfTree if the answered cell is one
  # possible tent.
  # HelpsOn2CellTentUniqueSolution if a tree only have one possible position
  # for a tent.
  # HelpsOn2CellsGrassLinkedTree if the network is complete but still got white
  # cell at the extremity.
  # HelpNotFound if nothing if found.
  def help(game)

    #initialize variable

    treeAlreadySeen = false #boolean that tell if a tree has already been seen
    answerGrass = nil #memories a cell that should be grass
    cellGrassRef = nil  #memories the referenced tree for the above var
    whiteCellArray = Array.new # Array that memories white cell next to the beginning tree
    tree = game.tree()
    @game = game.game()

    @answer = Array.new #Array that contain all te possible answer for a given tree network
    @treeList = Array.new #Array that contain tree witch have been explored within the algorithm
    @nbTree = 0 #nombre of tree seen in the tree network
    @nbTent = 0 #nombre of tent seen in the tree network

    #beginning
    tree.each() do |cell|

      @nbTree = 0 #reset var
      @nbTent = 0
      @answer = Array.new
      whiteCellArray = Array.new
      treeAlreadySeen = false


      #Can't use  "@treeList.include?(cell)" because cell.==(otherCell) already override and useless with how we need to compare cell here
      @treeList.each do |cell2|
        if (cell.row == cell2.row && cell.column == cell2.column)
          treeAlreadySeen = true
          break
        end
      end

      if !treeAlreadySeen

        if (cell.row + 1 < @game.nRow)
          nextCell = @game.cellAt(cell.row + 1, cell.column)
          if nextCell.isATent?
            research(nextCell, cell)
            @answer.push(@game.cellAt(cell.row - 1, cell.column)) if (cell.row - 1 >= 0) && @game.cellAt(cell.row - 1, cell.column).isAWhite?
        elsif nextCell.isAWhite?
            whiteCellArray.push(nextCell)
          end
        end
        if (cell.row - 1 >= 0)
          nextCell = @game.cellAt(cell.row - 1, cell.column)
          if nextCell.isATent?
            research(nextCell, cell)
            @answer.push(@game.cellAt(cell.row + 1, cell.column)) if (cell.row + 1 < @game.nRow) && @game.cellAt(cell.row + 1, cell.column).isAWhite?
          elsif nextCell.isAWhite?
            whiteCellArray.push(nextCell)
          end
        end
        if (cell.column + 1 < @game.nCol)
          nextCell = @game.cellAt(cell.row, cell.column + 1)
          if nextCell.isATent?
            research(nextCell, cell)
            @answer.push(@game.cellAt(cell.row, cell.column - 1)) if (cell.column - 1 >= 0) && @game.cellAt(cell.row, cell.column - 1).isAWhite?
          elsif nextCell.isAWhite?
            whiteCellArray.push(nextCell)
          end
        end
        if (cell.column - 1 >= 0)
          nextCell = @game.cellAt(cell.row, cell.column - 1)
          if nextCell.isATent?
            research(nextCell, cell)
            @answer.push(@game.cellAt(cell.row, cell.column + 1)) if (cell.column + 1 < @game.nCol) && @game.cellAt(cell.row, cell.column + 1).isAWhite?
          elsif nextCell.isAWhite?
            whiteCellArray.push(nextCell)
          end
        end

        @nbTree += 1
        if (@answer.size != 0 && (@nbTree - @nbTent) == @answer.size)
          return HelpsOnACellIsTentBecauseOfTree.new(@answer.pop, cell)
        elsif @nbTree == @nbTent && ((whiteCellArray.size != 0) || (@answer.size != 0)) #White cell
          answerGrass = whiteCellArray.size != 0 ? whiteCellArray.pop : @answer.pop
          cellGrassRef = cell
        elsif whiteCellArray.size == 1  #The tree only has one posibility
          @answer = whiteCellArray.pop
          return HelpsOn2CellTentUniqueSolution.new(@answer, cell)
        end

      end
    end #End each
    return HelpsOn2CellsGrassLinkedTree.new(answerGrass, cellGrassRef) if !answerGrass.nil?
    return HelpNotFound.new
  end

  def research(cell, prevCell)

    nextCell = nil

    if cell.isATent?

      if (cell.row + 1 < @game.nRow)
        nextCell = @game.cellAt(cell.row + 1, cell.column)
        if ((nextCell.row != prevCell.row) || (nextCell.column != prevCell.column)) && (nextCell.isATree?)# if nextCell is a tree and is not prevCell
          research(nextCell, cell)
        end
      end
      if (cell.row - 1 >= 0)
        nextCell = @game.cellAt(cell.row - 1, cell.column)
        if ((nextCell.row != prevCell.row) || (nextCell.column != prevCell.column)) && (nextCell.isATree?)
          research(nextCell, cell)
        end
      end
      if (cell.column + 1 < @game.nCol)
        nextCell = @game.cellAt(cell.row, cell.column + 1)
        if ((nextCell.row != prevCell.row) || (nextCell.column != prevCell.column)) && (nextCell.isATree?)
          research(nextCell, cell)
        end
      end
      if (cell.column - 1 >= 0)
        nextCell = @game.cellAt(cell.row, cell.column - 1)
        if ((nextCell.row != prevCell.row) || (nextCell.column != prevCell.column)) && (nextCell.isATree?)
          research(nextCell, cell)
        end
      end

      @nbTent += 1


    #END if cell.isATent?
    else  #cell.isATree?

      row = (cell.row - prevCell.row) + cell.row
      column = (cell.column - prevCell.column) + cell.column

      if row >= 0 && row < @game.nRow && column >= 0 && column < @game.nRow
        nextCell = @game.cellAt(row, column)
        if nextCell.isATent?
          research(nextCell, cell)
        elsif nextCell.isAWhite?
          @answer.push(nextCell)
        end
      end
      @treeList.push(cell)
      @nbTree += 1

    end
  end

end

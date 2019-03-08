require File.dirname(__FILE__) + "/../FictivHelper"
require File.dirname(__FILE__) + "/../../CompresseGrid"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpsOnCells/HelpsOn1Cell/HelpsCellCanOnlyBeTent/HelpCellCanOnlyBeTent"

class AllTreesHaveTentsHelper < FictivHelper
  public_class_method :new
  def help(game)
    p "rentre dedans"
    treesList = CompresseGrid.compresse(game)[0]
    #treesList = gameOptimize.trees
    triedTrees= Array.new
    nbTrees = 0
    nbTents = 0
    leavesTab = Array.new
    triedTents = Array.new
    treesList.each{ |aTree|
      p"debut bloc"
      nbTrees = 0
      nbTents = 0
      leavesTab = Array.new
      triedTents = Array.new
      if(triedTrees.index(aTree).nil?)
        p " nouveau bloc"
        if((res = research(game, aTree, nbTrees, nbTents, leavesTab, triedTrees, triedTents)).helpFound?)
          return res
        end
      end
    }
    return HelpNotFound.new
  end


  def research(game, cell, nbTrees, nbTents, leavesTab, triedTrees, triedTents)
    p "recherche"
    if(cell.isATree?)
      triedTrees.push(cell)
      nbTrees += 1
      compt = 0 #number of whites cells touching the tree, if there is only one, the tree is a leaves of recursiv tree
 #all tents which aren't in the triedTents list are called
      memory = game.cellAt(cell.row+1 , cell.column)
      if((cell.row+1 < game.nRow) && ((memory.isATent?)|| (memory.isATree?) ))
        if( triedTents.index(memory).nil?() && triedTrees.index(memory).nil?())
          research(game, memory, nbTrees, nbTents, leavesTab, triedTrees, triedTents)
        end
      else if(memory.isAWhite?)
          lastWhite = memory
          compt += 1
        end
      end
      memory = game.cellAt(cell.row , cell.column+1)
      if(cell.column+1 < game.nCol && ((memory.isATent?)|| (memory.isATree?)) )
        if( triedTents(memory).nil?() && triedTrees(memory).nil?)
          research(game, memory, nbTrees, nbTents, leavesTab, triedTrees, triedTents)
        end
      elsif(memory.isAWhite?)
        lastWhite = memory
        compt += 1
      end

      memory = game.cellAt(cell.row , cell.column-1)
      if(cell.column-1 >=0 && ((memory.isATent?)|| (memory.isATree?)) )
        if( triedTents(memory).nil?() && triedTrees(memory).nil?)
          research(game, memory, nbTrees, nbTents, leavesTab, triedTrees, triedTents)
        end
      elsif(memory.isAWhite?)
        lastWhite = memory
        compt += 1
      end

      if(cell.row-1 >=0 && (memory = game.cellAt(cell.row-1 , cell.column)).isATent? )
        if( triedTents(memory).nil?() && triedTrees(memory).nil?)
          research(game, memory, nbTrees, nbTents, leavesTab, triedTrees, triedTents)
        end
      elsif(memory.isAWhite?)
        lastWhite = memory
        compt += 1
      end

      if(compt == 1)

        leavesTab.push(lastWhite)
      end

    #END IF IS A TREE
    elsif(cell.isATent?)
      nbTents += 1
      if(cell.row+1 < game.nRow && (memory = game.cellAt(cell.row +1 , cell.column)).isATree?)
        if( triedTrees(memory).nil?)
          research(game, memory, nbTrees, nbTents, leavesTab, triedTrees, triedTents)
        end
      end

      if(cell.column+1 < game.nCol && (memory = game.cellAt(cell.row , cell.column+1)).isATree? )
        if( triedTrees(memory).nil?)
          research(game, memory, nbTrees, nbTents, leavesTab, triedTrees, triedTents)
        end
      end

      if(cell.column-1 >=0 && (memory = game.cellAt(cell.row , cell.column-1)).isATree? )
        if( triedTrees(memory).nil?)
          research(game, memory, nbTrees, nbTents, leavesTab, triedTrees, triedTents)
        end
      end

      if(cell.row-1 >=0 && (memory = game.cellAt(cell.row-1 , cell.column)).isATree? )
        if( triedTrees(memory).nil?)
          research(game, memory, nbTrees, nbTents, leavesTab, triedTrees, triedTents)
        end
      end
    end
    return treatment(nbTrees, nbTents, leavesTab)
  end

  def treatment(nbTrees, nbTents, leavesTab)
    p "treatment"
    if(leavesTab.count + nbTents == nbTrees)
      return HelpCellCanOnlyBeTent.new(leavesTab.first)
    else

      p "err fin der else treatment"
      p leavesTab.count.to_s + ";" + nbTents.to_s + ";" + nbTrees.to_s
      return HelpNotFound.new
    end
  end
end

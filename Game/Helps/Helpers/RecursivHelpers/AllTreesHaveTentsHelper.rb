require File.dirname(__FILE__) + "/../FictivHelper"
require File.dirname(__FILE__) + "/../../CompresseGrid"
require File.dirname(__FILE__) + "/../../HelpClasses/HelpsOnCells/HelpsOn1Cell/HelpsCellCanOnlyBeTent/HelpCellCanOnlyBeTent"

class AllTreesHaveTentsHelper < FictivHelper
  public_class_method :new
  def help(game)
    p "\n============================================================================\n"
    treesList = CompresseGrid.compresse(game)[0]
    #treesList = gameOptimize.trees
    triedTrees= Array.new
    triedTents = Array.new

    treesList.each{ |aTree|
      p" ===== debut bloc" + aTree.to_s
      nbTrees = 0
      nbTents = 0
      leavesTab = Array.new

      p "\n:::::::::::: dedans :::::::::"

      triedTrees.each{ |truc|
       p truc.to_s
      }

      p ":::::::::::: dehors :::::::::\n"
      if( ! z = (k=triedTrees.include?(aTree)))
        p "===== nouveau bloc qui part de " + aTree.to_s
        if((res = research(game, aTree, nbTrees, nbTents, leavesTab, triedTrees, triedTents)).helpFound?)
          p" ===== F fin bloc" + aTree.to_s + k.to_s
          return res
        end
      end
      p" ===== NF fin bloc" + aTree.to_s + k.to_s
      p z.to_s
    }
    return HelpNotFound.new
  end


  def research(game, cell, nbTrees, nbTents, leavesTab, triedTrees, triedTents)


    if(cell.isATree?)
      p "recherche : " + cell.to_s + "est un arbre"

      nbTrees += 1
      compt = 0 #number of whites cells touching the tree, if there is only one, the tree is a leaves of recursiv tree
 #all tents which aren't in the triedTents list are called

 triedTrees.push(cell)
      memory = game.cellAt(cell.row+1 , cell.column)
      if(cell.row+1 < game.nRow)
        if( (memory.isATent?)|| (memory.isATree?) )
          if( triedTents.index(memory).nil?() && triedTrees.index(memory).nil?())
            if((sonResult = research(game, memory, nbTrees, nbTents, leavesTab, triedTrees, triedTents)).helpFound?)
              return sonResult
            end
          end
        elsif(memory.isAWhite?)
            lastWhite = memory
            compt += 1
        end
      end

      memory = game.cellAt(cell.row , cell.column+1)
      if(cell.column+1 < game.nCol)
        if(((memory.isATent?)|| (memory.isATree?)) )
          if( triedTents.index(memory).nil?() && triedTrees.index(memory).nil?)
            if((sonResult = research(game, memory, nbTrees, nbTents, leavesTab, triedTrees, triedTents)).helpFound?)
              return sonResult
            end
          end
        elsif(memory.isAWhite?)
          lastWhite = memory
          compt += 1
        end
      end

      memory = game.cellAt(cell.row , cell.column-1)
      if(cell.column-1 >=0 )
        if( (memory.isATent?)|| (memory.isATree?) )
          if( triedTents.index(memory).nil?() && triedTrees.index(memory).nil?)
            if((sonResult = research(game, memory, nbTrees, nbTents, leavesTab, triedTrees, triedTents)).helpFound?)
              return sonResult
            end
          end
        elsif(memory.isAWhite?)
          lastWhite = memory
          compt += 1
        end
      end

      memory = game.cellAt(cell.row-1 , cell.column)

      if(cell.row-1 >=0)
        if( (memory.isATent?)|| (memory.isATree?) )
          if( triedTents.index(memory).nil?() && triedTrees.index(memory).nil?)
            if((sonResult = research(game, memory, nbTrees, nbTents, leavesTab, triedTrees, triedTents)).helpFound?)
              return sonResult
            end
          end
        elsif(memory.isAWhite?)
          lastWhite = memory
          compt += 1
        end
      end

      if(compt == 1)
        leavesTab.push(lastWhite)
      end

    #END IF IS A TREE
    elsif(cell.isATent?)
      p "recherche : " + cell.to_s + "est une tente"
      nbTents += 1

        if((sonResult = helpOnATentCell(cell, cell.row() +1, cell.column(), game, memory, nbTrees, nbTents, leavesTab, triedTrees, triedTents)).helpFound?)
          return sonResult
        end

        if((sonResult = helpOnATentCell(cell, cell.row(), cell.column()+1, game, memory, nbTrees, nbTents, leavesTab, triedTrees, triedTents)).helpFound?)
          return sonResult
        end

        if((sonResult = helpOnATentCell(cell, cell.row(), cell.column()-1, game, memory, nbTrees, nbTents, leavesTab, triedTrees, triedTents)).helpFound?)
          return sonResult
        end

        if((sonResult = helpOnATentCell(cell, cell.row()+1, cell.column(), game, memory, nbTrees, nbTents, leavesTab, triedTrees, triedTents)).helpFound?)
          return sonResult
        end
    end
    return treatment(nbTrees, nbTents, leavesTab)
  end

  def treatment(nbTrees, nbTents, leavesTab)
    p "======= start of treatment ======="
    if(leavesTab.count > 0)
      if(leavesTab.count + nbTents <= nbTrees)
        p "======= end of treatment F ======="
        return HelpCellCanOnlyBeTent.new(leavesTab.first)
      else
        p "======= end of treatment NF ======="
        return HelpNotFound.new
      end
    end
    return HelpNotFound.new
  end

  def helpOnATentCell(cell, row, column, game, memory, nbTrees, nbTents, leavesTab, triedTrees, triedTents)

      if( !(memory = game.cellAt(row , column)).nil?)
        if( memory.isATree?)
          if( triedTrees.index(memory).nil?)
            if((sonResult = research(game, memory, nbTrees, nbTents, leavesTab, triedTrees, triedTents)).helpFound?)
              return sonResult
            end
          end
        end
      end
      triedTents.push(cell)
      return HelpNotFound.new
  end
end

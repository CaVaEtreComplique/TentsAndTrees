# count the cells whith the State state in the row or column rank in the Game game, verticaly (VertHor =0 ) or horizontaly (VertHor =1 )
class Count
  def Count.count(game, state, vertHor, rank)
    res = 0
    if(vertHor==0)
    #Vertical
      return (0...game.nCol).count{ |i|
        game.cellAt(i, rank).state == state
      }
    elsif (vertHor ==1)
    #Horizontal
      return (0...game.nRow).count{ |i|
        game.cellAt(rank, i).state == state
      }
    end
  end

  def Count.findFirst(game, state, vertHor, rank)
    #return the first cell of the game with the state state
    if(vertHor == 0)
    #Vertical
      (0...game.nCol).each{ |i|
        if(game.cellAt(i, rank).state == state)
          return game.cellAt(i, rank)
        end
      }
    elsif (vertHor == 1)
    #Horizontal
      (0...game.nRow).each{ |i|
        if(game.cellAt(rank, i).state == state)
          return game.cellAt(i, rank)
        end
      }
    end
    return -1
  end
end

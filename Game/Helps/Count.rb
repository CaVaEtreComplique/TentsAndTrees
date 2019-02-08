# count the cells whith the State state in the row or column rank in the Game game, verticaly (VertHor =0 ) or horizontaly (VertHor =1 )
class Count
  def Count.count(game, state, vertHor, rank)
    res = 0
    if(vertHor==0)
    {#Vertical
      0.upto(game.nRow){ |i|
        if(game.cellAt(i, 0).state == state){
          res = res+1
        }
      }
    }
    elsif (vertHor ==1)
    {#Horizontal
      0.upto(game.nRow){ |i|
        if(game.cellAt(0, i).state == state){
          res = res+1
        }
      }
    }
    return res
  end

  def Count.findFirst(game, state, vertHor, rank)
    if(vertHor==0)
    {#Vertical
      (0..game.nRow).each{ |i|
        if(game.cellAt(i, 0).state == state){
          return game.cellAt(i, 0)
        }
      }
    }
    elsif (vertHor ==1)
    {#Horizontal
      (0..game.nRow).each{ |i|
        if(game.cellAt(0, i).state == state){
          return game.cellAt(i, 0)
        }
      }
    }
    return -1
  end
end

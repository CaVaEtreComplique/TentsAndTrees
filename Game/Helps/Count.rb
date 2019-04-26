# @Author: Maxime Touze <Maxime>
# @Date:   01-Mar-2019
# @Email:  maxime_touze@univ-lemans.fr
# @Filename: Count.rb
# @Last modified by:   Maxime
# @Last modified time: 15-Mar-2019

##
# ==== Presentation
# The Count class give some extended methode to Game class
#
# ==== Methods
# This class know the count and findFirst methode describe below
class Count
  # ==== Presentation
  # This class methode count the number of cell who are in a certain state
  # inside a row or column.
  #
  # ===== Attributes
  # * +game+ - The Game we are going to research in.
  # * +state+ - The state of the cell we are looking for.
  # * +vertHor+ - The orientation, put 0 if we are looking for a row otherwise
  #     it will look for a column.
  # * +rank+ - The row or column number we want to do our research in.
  #
  # ===== Returns
  # This method returns the number of cell who are in the specified state
  # inside a specified row or column
  #
  # ===== Exemple
  # W -> white cell; T -> not white cell
  # | W | W | T | T | W | W | W | T | W | -> row number 3 of game
  # nb = Count.count(game, white, 1, 3)
  # nb will print : 6
  #
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

  # ==== Presentation
  # This class methode find the first cell who is in a certain state
  # inside a row or column.
  #
  # ===== Attributes
  # * +game+ - The Game we are going to research in.
  # * +state+ - The state of the cell we are looking for.
  # * +vertHor+ - The orientation, put 0 if we are looking for a row otherwise
  #     it will look for a column.
  # * +rank+ - The row or column number we want to do our research in.
  #
  # ===== Returns
  # This method returns the first cell who are in the specified state
  # inside a specified row or column
  #
  # ===== Exemple
  # W -> white cell; T -> not white cell
  # | T | T | T | T | W | W | W | T | W | -> row number 3 of game
  # nb = Count.count(game, white, 1, 3)
  # nb will print something like : <Cell:0x42 @row=3, @column=4>
  #
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

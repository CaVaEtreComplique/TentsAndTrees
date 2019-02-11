#RowsAndColumnsFindTent help you to find Tent in a row or columns

require File.dirname(__FILE__) + "/FindTent"

class RowsAndColumnsFindTent

  def RowsAndColumnsFindTent.help(game)
    nbTent = 0
    sizeTentZone = 0
    cellFind = false
    cellSet = false
    cell = nil

    #for each row we applie the alorithm
    (0..game.nCol).each{ |i|

      nbTent = 0        #reset
      sizeTentZone = 0
      cellFind = false
      cellSet = false
      cell = nil

      (0..game.nRow).each{ |j|

        if(game.cellAt(i, j).state == (state: :white)){

          if (!cellFind && !cellSet){   #if don't have a cell registed / correct already
            cell = game.cellAt(i, j)
            cellFind = true             #we lock the first cell of the zone
          }
          sizeTentZone += 1;

        }else if(game.cellAt(i, j).state == (state: :grass)){

          switch(sizeTentZone % 2){
            case 1:
              nbTent += 1
              cellSet = true  #The size of the zone imply that the registered cell is eligible for a tent.
              break;

            case 0:
              if (!cellSet){
                cellFind = false
                cell = nil
              }
              break;
          }

          nbTent += sizeTentZone / 2;
          sizeTentZone = 0;

        }else if (game.cellAt(i, j).state == (state: :tree)){

          if(game.cellAt(i + 1, j + 1).state == (state: :tree) || game.cellAt(i + 1, j - 1).state == (state: :tree) ||
          game.cellAt(i - 1, j + 1).state == (state: :tree) || game.cellAt(i - 1, j - 1).state == (state: :tree) ||
          game.cellAt(i, j + 1).state == (state: :tree) || game.cellAt(i, j + 2).state == (state: :tree))
          { #We do not link the left zone and the right zone

            switch(sizeTentZone % 2){
              case 1:
                nbTent += 1
                cellSet = true  #The size of the zone imply that the registered cell is eligible for a tent.
                break;

              case 0:
                if (!cellSet){
                  cellFind = false
                  cell = nil
                }
                break;
            }

            nbTent += sizeTentZone / 2;
            sizeTentZone = 0;

          }

        }else if (game.cellAt(i, j).state == (state: :tent)){
          nbTent += 1
        }

        if(nbTent > clue){    #Comment on recupere les indices de la grillse svp ?
          break;  #If we have more possibility of tent then the row indication we change ligne
        }

      }

      switch(sizeTentZone % 2){
        case 1:
          nbTent += 1
          cellSet = true  #The size of the zone imply that the registered cell is eligible for a tent.
          break;

        case 0:
          if (!cellSet){
            cellFind = false
            cell = nil
          }
          break;
      }

      nbTent += sizeTentZone / 2;

      return cell if nbTent == clue && !cell.nil?
    }

    #for each column we applie the alorithm
    (0..game.nRow).each{ |i|

      nbTent = 0        #reset
      sizeTentZone = 0
      cellFind = false
      cellSet = false
      cell = nil

      (0..game.nCol).each{ |j|

        if(game.cellAt(j, i).state == (state: :white)){

          if (!cellFind && !cellSet){   #if don't have a cell registed / correct already
            cell = game.cellAt(j, i)
            cellFind = true             #we lock the first cell of the zone
          }
          sizeTentZone += 1;

        }else if(game.cellAt(j, i).state == (state: :grass)){

          switch(sizeTentZone % 2){
            case 1:
              nbTent += 1
              cellSet = true  #The size of the zone imply that the registered cell is eligible for a tent.
              break;

            case 0:
              if (!cellSet){
                cellFind = false
                cell = nil
              }
              break;
          }

          nbTent += sizeTentZone / 2;
          sizeTentZone = 0;

        }else if (game.cellAt(j, i).state == (state: :tree)){

          if(game.cellAt(j + 1, i + 1).state == (state: :tree) || game.cellAt(j + 1, i - 1).state == (state: :tree) ||
          game.cellAt(j - 1, i + 1).state == (state: :tree) || game.cellAt(j - 1, i - 1).state == (state: :tree) ||
          game.cellAt(j, i + 1).state == (state: :tree) || game.cellAt(j, i + 2).state == (state: :tree))
          { #We do not link the top zone and the bottom zone

            switch(sizeTentZone % 2){
              case 1:
                nbTent += 1
                cellSet = true  #The size of the zone imply that the registered cell is eligible for a tent.
                break;

              case 0:
                if (!cellSet){
                  cellFind = false
                  cell = nil
                }
                break;
            }

            nbTent += sizeTentZone / 2;
            sizeTentZone = 0;

          }

        }else if (game.cellAt(j, i).state == (state: :tent)){
          nbTent += 1
        }

        if(nbTent > clue){    #Comment on recupere les indices de la grille svp ?
          break;  #If we have more possibility of tent then the row indication we change ligne
        }

      }

      switch(sizeTentZone % 2){
        case 1:
          nbTent += 1
          cellSet = true  #The size of the zone imply that the registered cell is eligible for a tent.
          break;

        case 0:
          if (!cellSet){
            cellFind = false
            cell = nil
          }
          break;
      }
      nbTent += sizeTentZone / 2;

      return cell if nbTent == clue && !cell.nil?
    }

    return HelpNotFound.new()
  }
end

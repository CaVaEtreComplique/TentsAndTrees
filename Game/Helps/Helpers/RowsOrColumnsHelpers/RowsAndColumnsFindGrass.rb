# @Author: Corentin Petit <zeigon>
# @Date:   20-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: RowsAndColumnsFindGrass.rb
# @Last modified by:   zeigon
# @Last modified time: 05-Mar-2019



#RowsAndColumnsFindGrass help you to find grass in a row or columns

require File.dirname(__FILE__) + "/../../Core/Game"
require File.dirname(__FILE__) + "/../FictivHelper"

class RowsAndColumnsFindGrass < FictivHelper

  public_class_method :new 

  def help(game)

    nbTent = 0
    sizeTentZone = 0
    positionPrevOdd = -3
    even = true
    oddGrassFind = false
    oddGrassSet = false
    oddGrassCell = nil
    evenGrassFind = false
    evenGrassSet = false
    evenGrassCell = nil

    #for each row we applie the alorithm
    (0..game.nCol).each{ |i|

      nbTent = 0        #reset
      sizeTentZone = 0

      (0..game.nRow).each{ |j|

        if(game.cellAt(i, j).state == (state: :white)){
          p game.cellAt(i, j)
          if (positionPrevOdd == j - 2) && (!oddGrassFind) && (!oddGrassSet) { #find grass between two odd zone
            if (game.cellAt(i - 1, j - 1).state == (state: :white)){
              oddGrassFind = true
              oddGrassCell = game.cellAt(i - 1, j - 1)
            }elsif (game.cellAt(i + 1, j - 1).state == (state: :white)){
              oddGrassFind = true
              oddGrassCell = game.cellAt(i + 1, j - 1)
            }
          }

          even = even ? false : true

          if (!oddGrassFind) && (!oddGrassSet) && (even) { #Find grass for odd zone
            if (game.cellAt(i - 1, j).state == (state: :white)){
              oddGrassFind = true
              oddGrassCell = game.cellAt(i - 1, j)
            }elsif (game.cellAt(i + 1, j).state == (state: :white)){
              oddGrassFind = true
              oddGrassCell = game.cellAt(i + 1, j)
            }
          }

          if (!evenGrassFind) && (!evenGrassSet){ #Find grass for even zone
            if (game.cellAt(i - 1, j).state == (state: :white)){
              evenGrassFind = true
              evenGrassCell = game.cellAt(i - 1, j)
            }elsif (game.cellAt(i + 1, j).state == (state: :white)){
              evenGrassFind = true
              evenGrassCell = game.cellAt(i + 1, j)
            }
          }

          positionPrevOdd = i
          sizeTentZone += 1

        }elsif (game.cellAt(i, j).state == (state: :grass)){

          case (sizeTentZone % 2)
          when 1
            nbTent += 1
            oddGrassSet = true if oddGrassFind
          when 0
            if (!oddGrassSet){
              oddGrassFind = false
              oddGrassCell = nil
            }
            positionPrevOdd = -3
          end

          evenGrassSet = true if evenGrassFind
          nbTent += sizeTentZone / 2;
          sizeTentZone = 0;
          even = true

        }elsif (game.cellAt(i, j).state == (state: :tree)){

          if(game.cellAt(i + 1, j + 1).state == (state: :tree) || game.cellAt(i + 1, j - 1).state == (state: :tree) ||
          game.cellAt(i - 1, j + 1).state == (state: :tree) || game.cellAt(i - 1, j - 1).state == (state: :tree) ||
          game.cellAt(i, j + 1).state == (state: :tree) || game.cellAt(i, j + 2).state == (state: :tree) || game.cellAt(i, j - 2).state == (state: :tree))
          { #We do not link the left zone and the right zone

            #so the tree that we found act as a white case
            case (sizeTentZone % 2)
            when 1
              nbTent += 1
              oddGrassSet = true if oddGrassFind
            when 0
              if (!oddGrassSet){
                oddGrassFind = false
                oddGrassCell = nil
              }
              positionPrevOdd = -3
            end

            evenGrassSet = true if evenGrassFind
            nbTent += sizeTentZone / 2;
            sizeTentZone = 0;
            even = true

          }

        }else if (game.cellAt(i, j).state == (state: :tent)){
          nbTent += 1
        }

        if(nbTent > clue + 1){    #Comment on recupere les indices de la grillse svp ?
          break;  #If we have more possibility of tent then the row indication we change ligne
        }

      }

      case (sizeTentZone % 2)
      when 1
        nbTent += 1
        oddGrassSet = true if oddGrassFind
      when 0
        if (!oddGrassSet){
          oddGrassFind = false
          oddGrassCell = nil
        }
        positionPrevOdd = -3
      end

      evenGrassSet = true if evenGrassFind
      nbTent += sizeTentZone / 2;

      return HelpAllPossibilitiesGiveItRow.new(oddGrassCell, i, state: :grass) if nbTent == clue && !oddGrassCell.nil?
      return HelpAllPossibilitiesGiveItRow.new(evenGrassCell, i, state: :grass) if nbTent == clue && !evenGrassCell.nil?
      return HelpAllPossibilitiesGiveItRow.new(evenGrassCell, i, state: :grass) if nbTent == clue + 1 && !evenGrassCell.nil?

    }






    return HelpNotFound.new()
  end
end

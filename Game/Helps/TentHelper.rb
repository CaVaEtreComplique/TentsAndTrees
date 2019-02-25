
require File.dirname(__FILE__) + "/Count"
require File.dirname(__FILE__) + "/../Game"

class TentHelper
  def TentHelper.help(game)
    nbTent = 0
    nbWhiteInBlock = 0
    find = false #if my second iteration (ex : (0..game.nCol).each{|j| )say we find a tent, it return       #Posible tu use ary for the same effect?
    ary = Array.new #Array fill with ether nothing or 1 tents     #Change it to an object ?

      #Test ligne
      (0..game.nRow).each{ |i|
        nbTent = Count.count(game, state: :tent, 1, i) #Recover the actual numbre of tent in my row     #More efficient if in an other elsif we calcul the number of tent
        (0..game.nCol).each{ |j|
          if(game.cellAt(i, j).state == state: :white){
            nbWhiteInBlock += 1
            ary.push(game.cellAt(i, j)) if (ary.empty?) #if array empry, put the tent inside
          }elsif (((game.cellAt(i, j).state == state: :grass) || (game.cellAt(0, i).state == state: :tent)) && nbWhiteInBlock != 0){ # if my cell is ether a tent or grass and block not 0    #Make a difference between tent and grass ?
            case (nbWhiteInBlock % 2)

            when 1
              find = true
              nbTent += 1
            else #0
              ary.pop unless find
            end

            nbTent += nbWhiteInBlock / 2
            nbWhiteInBlock = 0
          }elsif (game.cellAt(i, j).state == state: :tree)){

          }
        }
      }

      #Test colonne
      (0..game.nCol).each{ |j|
        (0..game.nRow).each{ |i|

        }
      }
  end
end

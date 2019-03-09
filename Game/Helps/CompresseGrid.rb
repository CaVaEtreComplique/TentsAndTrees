# Compresse the grid into 3 array whitch containe tent, tree and grass

class CompresseGrid
  def CompresseGrid.compresse(game)

    tree = Array.new
    tent = Array.new
    grass = Array.new
    white = Array.new

    (0...game.nRow).each do |i|
      (0...game.nCol).each do |j|
        cell = game.cellAt(i, j)
        if cell.isATent?
          tent.push(cell)
        elsif cell.isATree?
          tree.push(cell)
        elsif cell.isAGrass?
          grass.push(cell)
        elsif cell.isAWhite?
          white.push(cell)
        end
      end
    end

    return [tree, tent, grass, white]
  end
end

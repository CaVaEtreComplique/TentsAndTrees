
class GridGenerator
  @grid
  @rows
  @cols
  @nRows
  @nCols
  @difficulty

  attr_reader :rows, :cols, :nRows, :nCols, :answers

  def initialize(mode="random")
    # Une ligne par grille et une rille par ligne (il y a 1100 lignes)
    file = File.new(File.dirname(__FILE__) + "/../../Assets/Files/FichierDeGrilles.txt", "r")
    gridBase=file.readlines
    file.close

    case mode
    when "easy"
      line=Random.new.rand(0...400)
    when "medium"
      line=Random.new.rand(401...700)
    when "hard"
      line=Random.new.rand(701...1100)
    else
      line=Random.new.rand(0...1100)
    end

    @difficulty=mode

    gridPick=gridBase[line]

    grid=gridPick.split(';')
    @nRows=grid.shift.to_i
    @nCols=grid.shift.to_i
    @rows=Array.new
    @cols=Array.new
    @answers=Array.new
    grid.pop.split(//,).each{|i|
      @cols.push(i.to_i)
    }
    @cols.pop
    grid.each{|l,x|
        @rows.push(l.split(':').last.to_i)
        @answers.push(l.split(//))
    }
  end
end

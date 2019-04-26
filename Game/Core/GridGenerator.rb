# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: GridGenerator.rb
# @Last modified by:   zeigon
# @Last modified time: 26-Apr-2019



class GridGenerator
  @grid
  @rows
  @cols
  @nRows
  @nCols
  @difficulty
  @associatedTimer

  attr_reader :rows, :cols, :nRows, :nCols, :answers, :associatedTimer

  def initialize(difficulty =:random)
    # Une ligne par grille et une rille par ligne (il y a 1100 lignes)
    file = File.new(File.dirname(__FILE__) + "/../../Assets/Files/FichierDeGrilles.txt", "r")
    gridBase=file.readlines
    file.close
    ProcessStatus.send("Choix de la grille")
    case difficulty
    when :easy
      line=Random.new.rand(0..100)
    when :medium
      line=Random.new.rand(101..700)
    when :hard
      line=Random.new.rand(701..1100)
    when :random
      line=Random.new.rand(0...1100)
    when :tutorial
      line=0
    end

    # case mode
    # when :timeAttack
      if (0..100).include?(line)
        @associatedTimer=300
      elsif (101..700).include?(line)
        @associatedTimer=600
      elsif (701..1100).include?(line)
        @associatedTimer=1800
      end
    # else
    #   @associatedTimer=0
    # end

    ProcessStatus.send("Récupération des données de la grille")
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

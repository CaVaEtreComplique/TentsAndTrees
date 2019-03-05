# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: ClueUi.rb
# @Last modified by:   zeigon
# @Last modified time: 04-Mar-2019



require File.dirname(__FILE__) + "/Button"

class ClueUi < Button

  def initialize(orientation, label, index, game)
    super(orientation, label)
    @orientation = orientation
  	@gtkLabels.use_markup = true
    @gtkLabels.set_markup("<span weight='ultrabold' foreground='black' size='x-large'>"+@gtkLabels.text+"</span>")
    @index = index
    @game = game
    @game.add_observer(self)
  end

  def count(state)
    if @orientation==:horizontal
      return (0...@game.nCol).count{ |y|
        @game.cellAt(@index,y).state==state
      }
    elsif @orientation==:vertical
      return (0...@game.nRow).count{ |x|
        @game.cellAt(x,@index).state==state
      }
    end
  end

  def update
    i = @gtkLabels.text.to_i
    c=count(:tent)
    if i == c
      @gtkLabels.set_markup("<span foreground='blue' weight='ultrabold' size='x-large'>"+@gtkLabels.text+"</span>")
    elsif i < c
      @gtkLabels.set_markup("<span foreground='red' weight='ultrabold' size='x-large'>"+@gtkLabels.text+"</span>")
    else
      @gtkLabels.set_markup("<span foreground='black' weight='ultrabold' size='x-large'>"+@gtkLabels.text+"</span>")
    end
  end

  def activateHelp(bool)
    if bool
      @game.add_observer(self)
      update
    else
      @gtkLabels.set_markup("<span foreground='black' weight='ultrabold' size='x-large'>"+@gtkLabels.text+"</span>")
      @game.delete_observer(self)
    end
  end

end

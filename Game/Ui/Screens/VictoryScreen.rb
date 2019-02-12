# @Author: Corentin Petit <CorentinPetit>
# @Date:   10-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: VictoryScreen.rb
# @Last modified by:   CorentinPetit
# @Last modified time: 10-Feb-2019


require 'gtk3'
require File.dirname(__FILE__) + "/Screen"

class VictoryScreen < Screen

  def initialize(parent)
    super(parent)
    @gtkObject=Gtk::Image.new(pixbuf: @buffer)
  end

end

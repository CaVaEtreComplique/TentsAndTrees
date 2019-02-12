# @Author: Corentin Petit <CorentinPetit>
# @Date:   08-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: LoadingScreen.rb
# @Last modified by:   CorentinPetit
# @Last modified time: 10-Feb-2019



require 'gtk3'
require "observer"
require File.dirname(__FILE__) + "/Screen"
require File.dirname(__FILE__) + "/../../Core/ProcessStatus"

class LoadingScreen < Screen

  attr_reader :progressCount

  def initialize(parent)
    super(parent)
    ProcessStatus.add(self)
    @progressBar = Gtk::ProgressBar.new
    @progressBar.pulse_step=160
    text
    @gtkObject=Gtk::Layout.new.add(Gtk::Table.new(3,3).attach(@progressBar,0,3,0,1).attach(Gtk::Image.new(pixbuf: @buffer),0,3,1,3))
    self
  end

  def run
    @progressBar.pulse
  end

  def text(s="Chargement en Cours")
    @progressBar.text=s
    @progressBar.set_show_text(true)
  end

  alias :recive :text

end

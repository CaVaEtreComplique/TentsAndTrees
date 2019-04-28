# @Author: Corentin Petit <CorentinPetit>
# @Date:   08-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: LoadingScreen.rb
# @Last modified by:   zeigon
# @Last modified time: 01-Mar-2019



require 'gtk3'
require "observer"
require File.dirname(__FILE__) + "/Screen"
require File.dirname(__FILE__) + "/../../Core/ProcessStatus"

##
# ===== 404
# This class was not commented in the first place, so it can not be documented.
class LoadingScreen < Screen
   # :nodoc:

  attr_reader :progressCount

  def initialize(manager)
    super(manager.win)
    ProcessStatus.add(self)
    @progressBar = Gtk::ProgressBar.new
    @progressBar.pulse_step=20
    text
    @gtkObject=Gtk::Layout.new.add(Gtk::Table.new(3,3).attach(@progressBar,0,3,0,1).attach(Gtk::Image.new(pixbuf: @buffer),0,3,1,3))
    self
  end

  def run
    @progressBar.pulse
  end

  def text(s=@textManager.getLoadingMessages("loading"))
    @progressBar.text=s
    @progressBar.set_show_text(true)
  end

  alias :recive :text

end

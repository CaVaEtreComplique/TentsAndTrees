# @Author: VAIDIE Camille <CamilleVAIDIE>
# @Date:   1-Mar-2019
# @Email:  camille.vaidie.etu@univ-lemans.fr
# @Filename: ChoixDiff.rb
# @Last modified by:   zeigon
# @Last modified time: 05-Apr-2019

require 'gtk3'
require File.dirname(__FILE__) + "/../AssetsClass/Asset"

def require_all(_dir)
	Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each { |file|
		require file
	}
end

class ScoreScreen < Screen
  def initialize(manager)
    super(manager.win)

    #Chargement de la campagne
  #	@adventure = Levels.new
    screen=Gdk::Screen.default
    @pad=screen.height*0.03
    @police=screen.height*0.04

    @gtkObject = Gtk::Table.new(3,3)
    @scrol=ScrollableArea.new(:horizontal)
    @boxV=Gtk::Box.new(:vertical)
    @boxAventure=Gtk::Box.new(:vertical)
    @boxClm=Gtk::Box.new(:vertical)
    @boxTimeAt=Gtk::Box.new(:vertical)


    a=Gtk::Alignment.new(0.5,0,0.5,1)
    a.add(@boxV)
    @gtkObject.attach(a,0,1,1,2)

    aventure=Text.new(@textManager.getButtonLabel("gamemode" , "adventure"),@police)
    clm=Text.new(@textManager.getButtonLabel("gamemode" , "timeattack"),@police)
    timeA=Text.new(@textManager.getButtonLabel("gamemode" , "quick"),@police)
    retour=Text.new(@textManager.getButtonLabel("gamemode" , "back"),@police)
    facile=Text.new(@textManager.getButtonLabel("difficulty" , "easy"),@police)
    moyen=Text.new(@textManager.getButtonLabel("difficulty" , "normal"),@police)
    diff=Text.new(@textManager.getButtonLabel("difficulty" , "hard"),@police)
    @s=Star.new(1,1)

    @boxV.pack_start(@scrol.gtkObject,expand: true, fill: true, padding: @pad)
    @scrol.add(@boxAventure	,@pad)
		@scrol.add(@boxClm,@pad)
		@scrol.add(@boxTimeAt,@pad)
    @boxV.pack_start(retour.gtkObject ,expand: false, fill: false, padding: @pad)
    @boxAventure.pack_start(aventure.gtkObject,expand: true, fill: true, padding: @pad)
    @boxClm.pack_start(clm.gtkObject,expand: true, fill: true, padding: @pad)
    @boxTimeAt.pack_start(timeA.gtkObject,expand: true, fill: true, padding: @pad)
    @boxAventure.pack_start(@s.stars,expand: false, fill: true, padding: @pad)
    @boxTimeAt.pack_start(facile.gtkObject ,expand: false, fill: true, padding: @pad)
    @boxTimeAt.pack_start(moyen.gtkObject ,expand: false, fill: true, padding: @pad)
    @boxTimeAt.pack_start(diff.gtkObject ,expand: false, fill: true, padding: @pad)
    retour.onClick{
        manager.mainScreen.applyOn(@parent)
    }



    @gtkObject.attach(Gtk::Image.new(pixbuf: @buffer),0,3,0,3)


  end
end

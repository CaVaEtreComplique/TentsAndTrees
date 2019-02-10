# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: ProcessStatus.rb
# @Last modified by:   CorentinPetit
# @Last modified time: 10-Feb-2019



class ProcessStatus
  @@status
  @@observers

  def initialize
    @@observers=Array.new #unless @@observers.class==Array
    @@status=String.new
  end

  def ProcessStatus.add(o)
    @@observers << o
  end

  def ProcessStatus.send(message)
    if @@status!=message
      @@status=message
      @@observers.each{ |o|
        o.recive(@@status)
        sleep(0.5)
      }
    end
    self
  end

  def recive
    @@status
  end

end

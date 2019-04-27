# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: ProcessStatus.rb
# @Last modified by:   zeigon
# @Last modified time: 12-Feb-2019


#
# ==== Presentation
# The ProcessStatus class is the representation of the design pattern observator
# it give possibility go send message to multiple other class.
#
# ==== Variables
# * +status+ - This class variables is a String that represent the message
# recived
#
# * +observers+ - This class variable represente the GridGenerator class.
#
# ==== Methods
# This class knows an initialization method , add and send described below.
class ProcessStatus
  @@status
  @@observers

  ##
  # ===== Presentation
  # This class' constructor initializes the class variable.
  def initialize
    if defined?(@@observers).nil? then @@observers=Array.new end
    @@status=String.new
  end

  ##
  # ===== Presentation
  # This class method add a new object to notify.
  def ProcessStatus.add(o)
    @@observers << o
  end

  ##
  # ===== Presentation
  # This class method send a message to all object inside observers
  #
  # ===== Attributes
  # * +message+ : The message to sent.
  #
  def ProcessStatus.send(message)
    if @@status!=message
      @@status=message
      @@observers.each{ |o|
        o.recive(@@status)
        # sleep(0.5)
      }
    end
    self
  end

  ##
  # ===== Presentation
  # This method return the actual status 
  def recive
    @@status
  end

end

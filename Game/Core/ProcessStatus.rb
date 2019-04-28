# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: ProcessStatus.rb
# @Last modified by:   zeigon
# @Last modified time: 12-Feb-2019


##
# ===== Presentation
# The ProcessStatus class is the representation of the design pattern observator.
# It gives the possibility to send messages to multiple other classes.
#
# ===== Variables
# * +status+ - This class variable is a String that represents the message received.
#
# * +observers+ - This class variable represents the GridGenerator class.
#
# ===== Methods
# This class knows an initialization method and the methods add and send described below.
class ProcessStatus
  @@status
  @@observers

  ##
  # ===== Presentation
  # This class' constructor initializes the class variables.
  # -----
  def initialize
    if defined?(@@observers).nil? then @@observers=Array.new end
    @@status=String.new
  end

  ##
  # ===== Presentation
  # This class method adds a new object to notify.
  #
  # ===== Variables
  # * +o+ - The object to notify.
  # -----
  def ProcessStatus.add(o)
    @@observers << o
  end

  ##
  # ===== Presentation
  # This class method sends a message to all the objects inside observers.
  #
  # ===== Attributes
  # * +message+ : The message to send.
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
  # This method returns the actual status
  # -----
  def recive
    @@status
  end

end

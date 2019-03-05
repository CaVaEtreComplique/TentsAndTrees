require File.dirname(__FILE__) + "/../Help"

class HelpNotFound < Help
  #Class instanciated when any help has been found
  public_class_method :new #instanciable
  def helpFound?() #redifinition of the method, no help found, return false
    return false
  end
  def getText() #returns the text of the help, saying that there is no help
    return "Aucune aide trouvée"
  end
end

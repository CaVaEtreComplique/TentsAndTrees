require File.dirname(__FILE__) + "/../Help"

class HelpNotFound < Help
  public_class_method :new
  def helpFound?()
    return false
  end
  def getText()
    return "Aucune aide trouvée"
  end
end

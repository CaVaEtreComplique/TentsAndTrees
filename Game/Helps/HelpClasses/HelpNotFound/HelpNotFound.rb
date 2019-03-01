require File.dirname(__FILE__) + "/../Help"

class HelpNotFound < Help
  def helpFound?()
    return false
  end
  def getText()
    return "Aucune aide trouvée"
  end
end

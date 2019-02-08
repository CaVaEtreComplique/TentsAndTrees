require File.dirname(__FILE__) + "/../Help"

class HelpNotFound < Help
  def HelpFound?()
    return false
  end
end

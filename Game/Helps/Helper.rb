#Main of the help, when you need a help, let's call Helper to help you

class Helper
  def Helper.help( game )
    game.beginGuess
    
    GrassHelper.help(game)

    game.removeGuess
  end
end

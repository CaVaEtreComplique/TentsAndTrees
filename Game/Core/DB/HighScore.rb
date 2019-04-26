# @Author: Corentin Huaulmé <CorentinHuaulme>
# @Date:   25-Jan-2019
# @Email:  corentin.huaulme.etu@univ-lemans.fr
# @Filename: HighScore.rb
# @Last modified by:   <HuaulmeCorentin>
# @Last modified time: 20-Avr-2019

##
# ===== Presentation
# The HighScore class is here to represent a high score in the database.
#
# ===== Variables
# A HighScore is defined by its difficulty, its Player, its score and its
# gamemode.
#
# ===== Methods
# This class only needs to be initialized.
class HighScore

  @id_difficulty_highScores # The difficulty of the HighScore
  @player_highScores # The Player of the HighScore
  @score_highScores # The score of the HighScore
  @id_gamemode_highScores # The gamemode of the HighScore



    ##
    # ===== Presentation
    # This is the class' constructor, it only gives the variables their value
    # taken from the parameters.
    #
    # ===== Attributes
    # * +idDiff+ - The id of the Difficulty of the HighScore
    # * +player+ - The Player of the HighScore
    # * +score+ - The score of the HighScore
    # * +idMode+ - The id of the Gamemode of the HighScore
    #
    # ===== How to Use
    # To create a new HighScore :
    #    highScore = HighScore.new(1,1,5000,3)
  def initialize(idDiff, player, score, idMode)
    @id_difficulty_highScores, @player_highScores = idDiff, player
    @score_highScores, @id_gamemode_highScores = score, idMode
  end

  # :nodoc:
  attr_reader :id_difficulty_highScores, :player_highScores, :score_highScores, :id_gamemode_highScores

end

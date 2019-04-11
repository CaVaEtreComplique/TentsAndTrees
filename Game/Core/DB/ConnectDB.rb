require 'rubygems'
require 'sqlite3'
require File.dirname(__FILE__) + "/Player.rb"
require File.dirname(__FILE__) + "/SaveDB.rb"
require File.dirname(__FILE__) + "/HighScore.rb"
require File.dirname(__FILE__) + "/Gamemode.rb"
require 'digest/sha1'
require 'yaml'

##
# ===== Presentation
# The ConnectDB class is the main database class and the only one that can reach
# it. Its methods manage everything in the database.
#
# ===== Variables
# * +db+ : The only variable, the game's database itself.
#
# ===== Methods
# This class' methods are all described below.
#
# ===== Sidenote
# The execute command found in code like for example
#    @db.execute "SELECT * FROM Player WHERE player_id = #{id}"
# is here to send an SQL request to the database. Here for example, the request is
#    SELECT * FROM Player WHERE player_id = #{id}
#
# The prepare command found in code like for example
#    stm = @db.prepare "UPDATE Save SET content_save=? WHERE id_save=?";
# is here in order to declare a SQL request before doing it, which will then be
# applied with the execute command.
#
# The bind_param command found in codelike for example
#    stm.bind_param 1, content;
# is here to apply different parameters to the SQL request that has been prepared.
class ConnectDB

  @db

  ##
  # ===== Presentation
  # This class' constructor initializes the db variable with the database in
  # order to connect the game to the database.
  #
  # ===== How to use
  # To create a db variable in order to connect to the database :
  #    db = ConnectDB.new()
  def initialize
   #Opens a SQLite 3 database file
    @db = SQLite3::Database.new 'Core/DB/db.sqlite'
  end

   ##
   # ===== Presentation
	# This method retrieves the Player that matches the given id. The game must
   # be connected to the database.
   #
	# ===== Attributes
	# * +id+ - The ID of the Player we're looking for.
	#
	# ===== Returns
	# The Player we're looking for or nil if the ID doesn't match any Player in
   # the database.
	#
   # ===== How to use
   # To get the first player in the database :
   #    db = ConnectDB.new()
	#    db.getPlayer(1)
   #
   # ===== Examples
   # To find some high score :
   #  @db.execute "SELECT * FROM Player WHERE player_id = #{id}" do |row|
   #    player = Player.new(row[0],row[1],row[2])
   #  end
   # -----------
  def getPlayer(id)

    player = nil

    @db.execute "SELECT * FROM Player WHERE player_id = #{id}" do |row|
      player = Player.new(row[0],row[1],row[2])
    end

    return player

  end

  ##
  # ===== Presentation
  # This method is used when the player wants to update his/her password. When
  # the player can't remember it, a window opens and invites the player to give
  # a new login, a new password and to confirm the password. This method manages
  # this.
  #
  # ===== Attributes
  # * +login+ : The player's login.
  # * +mdp+ : The player's new password
  #
  # ===== Returns
  # This method returns the player.
  #
  # ===== Examples
  # The first SQL request updates the player's password in the database :
  #   @db.execute "UPDATE Player SET password_player='#{Digest::SHA1.hexdigest(mdp)}' WHERE name_player='#{login}'" do |row|
  #      puts row
  #   end
  #
  # The second SQL request takes the given player from the database in order to
  # return it and log him/her in :
  #   @db.execute "SELECT * FROM Player WHERE name_player = '#{login}' AND password_player='#{Digest::SHA1.hexdigest(mdp)}'" do |row|
  #      player = Player.new(row[0],row[1],row[2])
  #   end
  def playerUpdate(login, mdp)
    player = nil
      @db.execute "UPDATE Player SET password_player='#{Digest::SHA1.hexdigest(mdp)}' WHERE name_player='#{login}'" do |row|
        puts row
      end

      @db.execute "SELECT * FROM Player WHERE name_player = '#{login}' AND password_player='#{Digest::SHA1.hexdigest(mdp)}'" do |row|
        player = Player.new(row[0],row[1],row[2])
      end
      return player
  end

  ##
  # ===== Presentation
  # The updateSave method updates the current player's save in order to keep
  # his/her progression in the database.
  #
  # ===== Attributes
  # * +content+ : The current Session.
  # * +id+ : The save's id.
  #
  # ===== Examples
  # The SQL request is prepared before being executed because the content would
  # be an unrecognized token if executed directly :
  #    stm = @db.prepare "UPDATE Save SET content_save=? WHERE id_save=?";
  #    stm.bind_param 1, content;
  #    stm.bind_param 2, id;
  #    stm.execute;
  def updateSave(content, id)
    puts "UPDATE SAVE is_save = #{id}"
    stm = @db.prepare "UPDATE Save SET content_save=? WHERE id_save=?";
    stm.bind_param 1, content;
    stm.bind_param 2, id;
    stm.execute;
  end

  ##
  # This method tries to find the player in the database with the name and the
  # password provided. The game must be connected to the database.
  #
  # ===== Attributes
  # * +name+ - The name of the player we're looking for
  # * +password+ - The password of the player we're looking for
  #
  # ===== Return
  # The player we're looking for or nil if no one can be found in the database
  #
  # ===== How to Use
  #    db = ConnectDB.new()
  # 	 db.playerConnect("aze","azeaze")
  #
  # ===== Examples
  # The following SQL request will be sent :
  #    @db.execute "SELECT * FROM Player WHERE name_player = '#{name}' AND password_player = '#{Digest::SHA1.hexdigest(password)}'"
  # This will return the results in a pl variable. If the request fails, pl equals nil.
  # Else, the pl variable will be a new Player with the results of the request as
  # parameters.
  #    pl = Player.new(row[0],row[1],row[2])
  # -------
	def playerConnect(name, password)

		pl = nil

		@db.execute "SELECT * FROM Player WHERE name_player = '#{name}' AND password_player = '#{Digest::SHA1.hexdigest(password)}'" do |row|
			pl = Player.new(row[0],row[1],row[2])
		end

		return pl

	end

   ##
   # ===== Presentation
	# This method adds a player in the database with the name and the password
   # provided. The game must be connected to the database.
	#
	# ===== Attributes
	# * +name+ - The name of the player we want to add
	# * +password+ - The password of the player we want to add
	#
   # ===== Returns
   # This method returns the informations about the Player that has been added
   # in the database.
   #
	# ===== How to Use
	#   db = ConnectDB.new()
	# 	 db.createPlayer("aze","azeaze")
   #
   # ===== Examples
   # The following request will add the player in the database :
   #    @db.execute "INSERT INTO Player(name_player, password_player) VALUES('#{name}','#{Digest::SHA1.hexdigest(password)}')"
   # Then a "player" variable will be created and instanciated to nil. This player
   # variable will become the player that has been added in the databae. To make it,
   # this variable becomes a new Player and will take for parameters the results
   # of the following request :
   #   @db.execute "SELECT * FROM Player WHERE name_player='#{name}'"
   # This will then create the player like this :
   #   player = Player.new(row[0],row[1],row[2])
   # -------------
	def createPlayer(name, password)

		@db.execute "INSERT INTO Player(name_player, password_player) VALUES('#{name}','#{Digest::SHA1.hexdigest(password)}')" do |row|

		end

    player = nil

    @db.execute "SELECT * FROM Player WHERE name_player='#{name}'" do |row|
      player = Player.new(row[0],row[1],row[2])
    end

    return player

	end

  ##
  # ===== Presentation
  # This method checks if the name of the Player already exists in the database
  # The game must be connected to the database.
  #
  # ===== Attributes
  # * +name+ - The name of the Player we want to check
  #
  # ===== Returns
  # This method returns the player if it exists or nil if the request failed or
  # returned nothing.
  #
  # ===== How to Use
  #    db = ConnectDB.new()
  # 	 db.isPlayerExist("aze")
  #
  # ===== Examples
  # This method will execute the following SQL request :
  #    @db.execute "SELECT * FROM Player WHERE name_player='#{name}'"
  # It will then return a player variable instanciated like this :
  #    player = Player.new(row[0],row[1],row[2])
  # But if the request failed or returned nothing, the player variable will
  # be equal to nil.
  # -------------
  def isPlayerExist(name)

    player = nil

    @db.execute "SELECT * FROM Player WHERE name_player='#{name}'" do |row|
      player = Player.new(row[0],row[1],row[2])
    end

    return player

  end

   ##
   # ===== Presentation
	# This method creates a save in the database with the content and the Player
   # provided. The game must be connected to the database.
	#
	# ===== Attributes
	# * +player+ - The Player who wants to save.
	# * +content+ - The save's content.
	#
   # ===== Returns
   # This method returns the save that just has been created, or nil if the request
   # failed.
   #
	# ===== How to Use
	#   db = ConnectDB.new()
	# 	 pl = new Player(1,"zae","aze")
	# 	 db.save(pl, "Things to save")
   #
   # ===== Examples
   #
   # -------------
	def save(player, content)
    # :nodoc:
    #puts "player = #{player.id_player}"
    #puts "content = #{content}"
		d = DateTime.now
    s = nil
    #puts "INSERT INTO Save(player_id_save, date_save, content_save) VALUES(#{player.id_player}, '#{d.strftime("%d/%m/%Y %H:%M")}','#{content}')"

    puts "CREATE SAVE"


		@db.execute("INSERT INTO Save(player_id_save, date_save, content_save) VALUES(?, ?, ?)", player.id_player, d.strftime("%d/%m/%Y %H:%M"),content) do |row|
			puts row
		end

    @db.execute("SELECT * FROM Save WHERE player_id_save = #{player.id_player} AND date_save='#{d.strftime("%d/%m/%Y %H:%M")}'") do |row|
      s = SaveDB.new(row[0],row[1],row[2],row[3])
    end
    puts s.id_save
    return s

	end
   # :startdoc:

   # This method deletes a Save in the database with the ID of the Save. The
   # game must be connected to the database.
	#
	# ===== Attributes
	# * +id+ - The ID of the save we want to delete.
   #
	# ===== Examples
	#
	#   db = ConnectDB.new()
	# 	 db.deleteSave((ID of the save))
   #
   # --------------
	def deleteSave(id)

		@db.execute "DELETE FROM Save WHERE id_save = #{id}" do |row|
			puts row
		end

	end

  def deletePlayerHg(id)
    @db.execute "DELETE FROM HighScores WHERE id_player_highScores = #{id}" do |row|
      puts row
    end

  end

  def deletePlayer(id)
		@db.execute "DELETE FROM Player WHERE player_id = #{id}" do |row|
			puts row
		end

	end


  def deletePlayerSave(id)

		@db.execute "DELETE FROM Save WHERE player_id_save = #{id}" do |row|
			puts row
		end

	end


	# This method retrieves the saves created by the Player.
   # The game must be connected to the database.
	#
	# ===== Attributes
	# * +player+ - The Player who saved.
	#
   #
   # ===== Return
   # The saves created by the Player in an Array.
   #
	# ===== Examples
	#
	#   db = ConnectDB.new()
	# 	 pl = new Player(1,"zae","aze")
	# 	 db.getPlayersSave(pl)
   #
   # ------------
	def getPlayersSave(player)

		saves = Array.new

		@db.execute "SELECT * FROM Save WHERE player_id_save = #{player.id_player}" do |row|
			saves.push(SaveDB.new(row[0],row[1],row[2],row[3]))
		end

		return saves

	end

   # This method retrieves the save from the provided ID. The game must be
   # connected to the database.
	#
	# ===== Attributes
	# * +id+ - The ID of the Save
   #
   # ===== Return
   # The save that matches the ID provided
   #
	# ===== Examples
	#
	#   db = ConnectDB.new()
	# 	 db.getSaveByID(id)
   #
   # ------------
	def getSaveByID(id)

		save = nil

		@db.execute "SELECT * FROM Save WHERE id_save = #{id}" do |row|
			save = SaveDB.new(row[0],row[1],row[2],row[3])
		end

		return save

	end

	# This method retrieves the high scores by game mode and difficulty. The game
   # must be connected to the database.
	#
	# ===== Attributes
	# * +gamemode+ - The gamemode
	# * +diff+ - The difficulty
	#
   #
   # ===== Return
   # The highscores that match the game mode and the difficulty in an Array
   #
	# ===== Examples
	#
	#   db = ConnectDB.new()
	# 	 gm = Gamemode.new(1,"Gamemode name")
   #   diff = Difficulty.new(1,"Easy")
	# 	 db.getHighScoresByGamemodeDiff(gm,diff)
   #
   # -------------
	def getHighScoresByGamemodeDiff(gamemode, diff)

		hg = Array.new

		@db.execute "SELECT * FROM HighScores WHERE id_gamemode_highScores = #{gamemode.id_gamemode} AND id_difficulty_highScores = #{diff.id_difficulty}" do |row|
			hg.push(HighScore.new(row[0],row[1],row[2],row[3]))
		end

		return hg

	end

  # This method retrieves the high scores by game mode and difficulty made by a player. The game
   # must be connected to the database.
  #
  # ===== Attributes
  # * +gamemode+ - The gamemode
  # * +diff+ - The difficulty
  # * +player+ - The player
  #
   #
   # ===== Return
   # The highscore that match the game mode and the difficulty made by the player
   #
  # ===== Examples
  #
<<<<<<< HEAD
  #   db = ConnectDB.new()
  # 	 gm = Gamemode.new(1,"Gamemode name")
   #   diff = Difficulty.new(1,"Easy")
  # 	 db.getPlayerHighScoreByGamemodeDiff(gm,diff, player)
   #
   # -------------
  def getPlayerHighScoreByGamemodeDiff(gamemode, difficulty, player)

    hg = nil
    diff = 0
    gm = 0

    @db.execute "SELECT * FROM Difficulty WHERE name_difficulty = '#{difficulty}'" do |row|
      diff = row[0]
    end

    @db.execute "SELECT * FROM gamemode WHERE name_gamemode = '#{gamemode}'" do |row|
      gm = row[0]
    end


    @db.execute "SELECT * FROM HighScores WHERE id_player_highScores = #{player.id_player} AND id_gamemode_highScores = #{gm} AND id_difficulty_highScores = #{diff}" do |row|
      hg = HighScore.new(row[0],row[1],row[2],row[3])
    end

    return hg

  end

  def addHighScore(gameMode, difficulty, player, score)
    hg = nil
    diff = 0
    gm = 0

    @db.execute "SELECT * FROM Difficulty WHERE name_difficulty = '#{difficulty}'" do |row|
      diff = row[0]
    end

    @db.execute "SELECT * FROM gamemode WHERE name_gamemode = '#{gameMode}'" do |row|
      gm = row[0]
    end

    @db.execute("INSERT INTO HighScores VALUES(?,?,?,?)",diff, player.id_player,score, gm) do |row|
      puts row
    end
  end

  def updateHighScore(gameMode, difficulty, player, score)
    hg = nil
    diff = 0
    gm = 0

    @db.execute "SELECT * FROM Difficulty WHERE name_difficulty = '#{difficulty}'" do |row|
      diff = row[0]
    end

    @db.execute "SELECT * FROM gamemode WHERE name_gamemode = '#{gameMode}'" do |row|
      gm = row[0]
    end

    @db.execute("UPDATE HighScores SET score_highScores=#{score} WHERE id_difficulty_highScores=#{diff} AND id_player_highScores=#{player.id_player} AND id_gamemode_highScores=#{gm}") do |row|
      puts row
    end
  #    db = ConnectDB.new()
  # 	 db.getGamemodes()
  #
  # ---------
  def getGamemodes()
    gm = Array.new
		@db.execute "SELECT * FROM Gamemode" do |row|
			hg.push(new Gamemode())
		end
    return gm
  end
end

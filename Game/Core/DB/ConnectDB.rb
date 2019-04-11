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

	# This method tries to find the player in the database with the name and the
   # password provided. The game must be connected to the database.
	#
	# ===== Attributes
	# * +name+ - The name of the Player we're looking for
	# * +password+ - The password of the Player we're looking for
	#
	# ===== Return
	# The Player we're looking for or nil if no one can be found in the database
	#
	# ===== Examples
	#
	#   db = ConnectDB.new()
	# 	 db.playerConnect("aze","azeaze")
  #
  # -------
	def playerConnect(name, password)

		pl = nil

		@db.execute "SELECT * FROM Player WHERE name_player = '#{name}' AND password_player = '#{Digest::SHA1.hexdigest(password)}'" do |row|
			pl = Player.new(row[0],row[1],row[2])
		end

		return pl

	end

	# This method adds a player in the database with the name and the password
   # provided. The game must be connected to the database.
	#
	# ===== Attributes
	# * +name+ - The name of the Player we want to add
	# * +password+ - The password of the Player we want to add
	#
	# ===== Examples
	#
	#   db = ConnectDB.new()
	# 	 db.createPlayer("aze","azeaze")
   #
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

  # This method check if the name of the Player already exists in the database
  # The game must be connected to the database.
  #
  # ===== Attributes
  # * +name+ - The name of the Player we want to check
  #
  # ===== Examples
  #
  #   db = ConnectDB.new()
  # 	 db.isPlayerExist("aze")
  #
  # -------------
  def isPlayerExist(name)

    player = nil

    @db.execute "SELECT * FROM Player WHERE name_player='#{name}'" do |row|
      player = Player.new(row[0],row[1],row[2])
    end

    return player

  end

	# This method creates a Save in the database with the content and the Player
   # provided. The game must be connected to the database.
	#
	# ===== Attributes
	# * +player+ - The Player who wants to save
	# * +content+ - The content of the save
	#
	# ===== Examples
	#
	#   db = ConnectDB.new()
	# 	 pl = new Player(1,"zae","aze")
	# 	 db.save(pl, "Things to save")
   #
   # -------------
	def save(player, content)

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

		@db.execute "SELECT * FROM HighScore WHERE id_gamemode_highScores = #{gamemode.id_gamemode} AND id_difficulty_highScores = #{diff.id_difficulty}" do |row|
			hg.push(new HighScore(row[0],row[1],row[2],row[3]))
		end

		return hg

	end

  # This method retrieves the game modes available. The game must be connected to
  # the database.
  #
  #
  # ===== Return
  # All the game modes in an Array
  #
  # ===== Examples
  #
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

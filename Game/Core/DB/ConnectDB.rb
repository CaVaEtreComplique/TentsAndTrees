require 'rubygems'
require 'sqlite3'
require File.dirname(__FILE__) + "/Player.rb"
require File.dirname(__FILE__) + "/SaveDB.rb"
require File.dirname(__FILE__) + "/HighScore.rb"
require File.dirname(__FILE__) + "/Gamemode.rb"
require 'digest/sha1'
require 'yaml'

class ConnectDB

  @db #The database of the game

  ##
  # Constructor of ConnectDB. Connects the game to the database.
  #
  # =====Examples
  #
  #    db = ConnectDB.new()
  def initialize
   #Opens a SQLite 3 database file
    @db = SQLite3::Database.new 'Core/DB/db.sqlite'
  end

	# This method retrieves the Player that matches the given id. The game must
   # be connected to the database.
   #
	# ===== Attributes
	# * +id+ - The ID of the Player we're looking for.
	#
	# ===== Return
	# The Player we're looking for or nil if the ID doesn't match any Player in
   # the database.
	#
   # ===== Examples
   #
   #    db = ConnectDB.new()
	#    db.getPlayer(1)
   # -----------
  def getPlayer(id)

    player = nil

    # Find some records
    @db.execute "SELECT * FROM Player WHERE player_id = #{id}" do |row|
      player = Player.new(row[0],row[1],row[2])
    end

    return player

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

		d = DateTime.now

  #  puts "INSERT INTO Save(player_id_save, date_save, content_save) VALUES(#{player.id_player}, '#{d.strftime("%d/%m/%Y %H:%M")}','#{content}')"

		@db.execute("INSERT INTO Save(player_id_save, date_save, content_save) VALUES(?, ?, ?)", player.id_player, d.strftime("%d/%m/%Y %H:%M"),content) do |row|
			puts row
		end

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
      puts row[0]
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

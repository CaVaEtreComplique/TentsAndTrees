require 'rubygems'
require 'sqlite3'
require File.dirname(__FILE__) + "/Player.rb"
require File.dirname(__FILE__) + "/Save.rb"
require File.dirname(__FILE__) + "/HighScore.rb"
require File.dirname(__FILE__) + "/Gamemode.rb"
require 'digest/sha1'

#TO DO
#Finir les méthodes de bases de données


class ConnectDB

  @db # The database of the game

	# Constructor of a ConnectDB. Connect the game with the database
  #
  # ==== Examples
  #
  #    db = ConnectDB.new()
  def initialize
    # Open a SQLite 3 database file
    @db = SQLite3::Database.new 'db.sqlite'
  end

	# Retrieve the player that matches the id given. The game must be connected to the database
  #
	# ==== Attributes
	# * +id+ - The ID of the Player we're looking for
	#
	# ==== Return
	# 	The Player we're looking for or nil if the ID doesn't match any Player in the database
	#
  # ==== Examples
  #
  #    db = ConnectDB.new()
	# 	 db.getPlayer(1)
  def getPlayer(id)

    players = Array.new

    # Find some records
    @db.execute "SELECT * FROM Player WHERE player_id = #{id}" do |row|
      players.push(Player.new(row[0],row[1],row[2]))
    end

    return players

  end

	# Try to find the player in the database with the name and the password provided. The game must be connected to the database
	#
	# ==== Attributes
	# * +name+ - The name of the Player we're looking for
	# * +password+ - The password of the Player we're looking for
	#
	# ==== Return
	# 	The Player we're looking for or nil if no one if found in the database
	#
	# ==== Examples
	#
	#    db = ConnectDB.new()
	# 	 db.playerConnect("aze","azeaze")
	def playerConnect(name, password)

		pl = nil

		@db.execute "SELECT * FROM Player WHERE name_player = '#{name}' AND password_player = '#{Digest::SHA1.hexdigest(password)}'" do |row|
			pl = Player.new(row[0],row[1],row[2])
		end

		return pl

	end

	# Add a player in the database with the name and the password provided. The game must be connected to the database
	#
	# ==== Attributes
	# * +name+ - The name of the Player we want to add
	# * +password+ - The password of the Player wewant to add
	#
	# ==== Examples
	#
	#    db = ConnectDB.new()
	# 	 db.createPlayer("aze","azeaze")
	def createPlayer(name, password)

		@db.execute "INSERT INTO Player(name_player, password_player) VALUES('#{name}','#{Digest::SHA1.hexdigest(password)}')" do |row|
			puts row
		end

	end

	# Create a Save in the database with the content and the Player provided. The game must be connected to the database
	#
	# ==== Attributes
	# * +player+ - The Player who wants to save
	# * +content+ - The content of the Save
	#
	# ==== Examples
	#
	#    db = ConnectDB.new()
	# 	 pl = new Player(1,"zae","aze")
	# 	 db.save(pl, "Things to save")
	def save(player, content)

		d = DateTime.now

		@db.execute "INSERT INTO Save(player_id_save, date_save content_save) VALUES(#{player.player_id}, '#{d.strftime("%d/%m/%Y %H:%M")}','#{content}')" do |row|
			puts row
		end

	end

	# Retrieve the saves created by the player. The game must be connected to the database
	#
	# ==== Attributes
	# * +player+ - The Player who saved
	#
	# ==== Examples
	#
	#    db = ConnectDB.new()
	# 	 pl = new Player(1,"zae","aze")
	# 	 db.getPlayersSave(pl)
	def getPlayersSave(player)

		saves = Array.new

		@db.execute "SELECT * FROM Save WHERE player_id_save = #{player.player_id}" do |row|
			saves.push(new Save(row[0],row[1],row[2],row[3]))
		end

		return saves

	end

	# Retrieve the high scores by game mode and difficulty. The game must be connected to the database
	#
	# ==== Attributes
	# * +gamemode+ - The gamemode
	# * +diff+ - The difficulty
	#
	# ==== Examples
	#
	#    db = ConnectDB.new()
	# 	 gm = Gamemode.new(1,"Gamemode name")
  #    diff = Difficulty.new(1,"Easy")
	# 	 db.getHighScoresByGamemodeDiff(gm,diff)
	def getHighScoresByGamemodeDiff(gamemode, diff)

		hg = Array.new

		@db.execute "SELECT * FROM HighScore WHERE id_gamemode_highScores = #{gamemode.id_gamemode} AND id_difficulty_highScores = #{diff.id_difficulty}" do |row|
			hg.push(new HighScore(row[0],row[1],row[2],row[3]))
		end

		return hg

	end

  def getGamemodes()

    gm = Array.new

		@db.execute "SELECT * FROM Gamemode" do |row|
			hg.push(new Gamemode())
		end


    return gm
  end

end

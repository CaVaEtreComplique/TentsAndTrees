# @Author: Corentin Petit <CorentinPetit>
# @Date:   08-Feb-2019
# @Email:  coco72.cp@gmail.com
# @Filename: Chronometre.rb
# @Last modified by:   CorentinPetit
# @Last modified time: 09-Feb-2019



# This Class allow to run a timer or a chrono (the rest of the file will write chrono for both)
# on a separeted thread in order to mesure time spend
# since the start of a game
#

require 'gtk3'
require "../Constants.rb"

class Chronometre
	#@labelChrono 												time displaying label
	#@sec																	seconds spent since the chrono start
	#@pause 		 													Boolean allowing to know if the chrono is paused or not
	#@chrono 															the thread which the chrono runs on+
	#@dixieme 														Dixieme de seconde (Pas obligatoire)
	#@mode																Chrono or Timer

	# nombre de seconde écoulée depuis la dernière remise à zéro
	attr_reader :sec

	# Initialise une nouvelle instance de la classe chronometre
	# @param labelChrono le texte affiché sur le chronomètre
	# @param mode Le mode (chronomètre ou minuteur)
	# @param tempsEcoule le temps écoulé depuis le lancement du chronomètre (0, vu qu'on le crée maintenant)
	# Initialise la variable d'instance pause à true => le chronomètre ne commence pas à tourner
	def initialize(labelChrono, mode,tempsEcoule = 0)
		@sec = tempsEcoule
		@dixieme = 0
		@labelChrono = labelChrono
		@pause = true
		@mode = mode
		majlabel
	end

	##
	# Lance le chronomètre
	# Si le chronomètre est en pause, crée un nouveau thread et lance la méthode run
	# @see run
	def start
		if paused?
			@pause = false
			@chrono = Thread.new { self.run }
		end
	end

	##
	# Stoppe le chronomètre
	# Si le chronomètre n'est pas en pause, et join le thread du chronomètre avec le thread principal :
	# Le thread suspend l'execution
	def stop
		if not paused? then
			@pause = true
			@chrono.join
		end
	end

	##
	# Remet le chronomètre à zéro.
	def raz
			@sec = 0
			@dixieme = 0
			majlabel
	end

	##
	# Predicat vrai si chronomètre actuellement en pause.
	def paused?
		return @pause
	end

	##
	# Compte les secondes et met le label référencé à jour
	def run
		# garder en mémoire les dixièmes de seconde permet de diminuer la perte de temps induite par la pause.
		while not @pause do
			if @mode == COMPTE
				if @dixieme == 10 then
					@dixieme = 0
					@sec += 1
					majlabel
				end
				@dixieme += 1
				sleep(0.1)
			else
				if @dixieme == 0 then
					@dixieme = 10
					@sec -= 1
					majlabel
				end
				@dixieme -= 1
				sleep(0.1)
			end
		end
	end


	##
	# Met à jour le texte du label.
	def majlabel
		@labelChrono.set_text(self.to_s)
		puts self
	end
	private :majlabel


	# Affichage du temps en human-readable
	def to_s
		s, m = @sec % 60, @sec / 60
		h = m / 60
		m = m % 60
		return ("%02d:%02d:%02d" % [h, m, s])
	end
end

if $0 == __FILE__
	l = Gtk::Label.new()
	#chrono = Chronometre.new(l,COMPTE)
	chrono = Chronometre.new(l,DECOMPTE,20)
	chrono.start()

	while(chrono.sec != 10)
	  if(chrono.sec == 5)
	     chrono.stop
	     break;
	  end

	  #puts (l.text()) + "hello";
	end

	chrono.start()
	while(chrono.sec != 10)
	  #puts (l.text());
	end
end

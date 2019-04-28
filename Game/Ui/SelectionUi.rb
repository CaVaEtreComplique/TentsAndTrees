# @Author: Corentin Petit <CorentinPetit>
# @Date:   08-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: SelectionUi.rb
# @Last modified by:   CorentinPetit
# @Last modified time: 09-Feb-2019


##
# ===== 404
# This class was not commented in the first place, so it can not be documented.
class SelectionUi
	# :nodoc:
	@selected
	@modified

	def initialize
		@selected = Array.new
		@modified = Array.new
	end

	def update(newSelection)

		unselected = @selected.reject { |cell|
			newSelection.include?(cell)
		}
		unselect(unselected)

		newlySelected = newSelection.reject { |cell|
			@selected.include?(cell)
		}
		select(newlySelected)

		@selected = newSelection

	end

	def unselect(arr)
		arr.each { |cell|
			@modified << cell
			cell.unselect
		}
	end

	def select(arr)
		arr.each { |cell|
			@modified << cell
			cell.select
		}
	end


	def show
		@modified.each(&:show)
		@modified = []
	end
end

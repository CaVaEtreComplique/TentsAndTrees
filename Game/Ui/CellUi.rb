# @Author: Corentin Petit <CorentinPetit>
# @Date:   08-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: CellUi.rb
# @Last modified by:   zeigon
# @Last modified time: 29-Mar-2019



require File.dirname(__FILE__) + "/Click"

##
# ===== 404
# This class was not commented in the first place, so it can not be documented.
class CellUi
	# :nodoc:
	attr_reader :gtkObject, :row, :col, :variation

	def initialize(parent, row, col, assets)
		@row = row
		@col = col
		@parent = parent
		@assets = assets
		@variation=-1
		@gtkObject = Gtk::EventBox.new
		normal()



		@gtkObject.signal_connect("button_press_event") { |_, event|
			if event.button==Click::LEFT
				if Gdk::EventType::BUTTON2_PRESS==event.event_type
					@parent.beginDrag(self, event.button)
				end
				@parent.beginDrag(self, event.button)
				Gdk.pointer_ungrab(Gdk::CURRENT_TIME)
			end
		}
		@gtkObject.signal_connect("enter_notify_event") { |_, event|
			@gtkObject.window.set_cursor(Click::CURSORIN) unless @gtkObject.window == nil
			if @parent.draged?
				@parent.selection(self)
			else
				@parent.hover(self)
			end
		}
	  @gtkObject.signal_connect("leave_notify_event") { |widget, event|
	    @gtkObject.window.set_cursor(Click::CURSOROUT) unless @gtkObject.window == nil
	  }
	end

	def leftClicked
		coreCell.primaryChange
		normal
		show
	end

	def unLeftClicked
		coreCell.primaryUnchange
		normal
		show
	end

	def dragLeftClicked
		coreCell.dragLeftChange
		normal
		show
	end

	def coreCell
		@parent.coreCellAt(@row, @col)
	end

	def select
		selectedAsset = @assets.cellAssetSelected(coreCell.state,@variation,coreCell.frozen)
		@variation = selectedAsset.at(1)
		applyAsset(selectedAsset.at(0))
	end

	def normal
		normalAsset = @assets.cellAsset(coreCell.state,@variation,coreCell.frozen)
		@variation = normalAsset.at(1)
		applyAsset(normalAsset.at(0))
	end

	def glowing
		glowingAsset = @assets.cellAssetGlowing(coreCell.state,@variation,coreCell.frozen)
		@variation = glowingAsset.at(1)
		applyAsset(glowingAsset.at(0))
	end

	alias :unselect :normal

	def sameState?(cell)
		cell.coreCell.state == coreCell.state
	end

	def dragable?
		coreCell.dragable?
	end

	def applyAsset(asset)
		asset.applyOn(@gtkObject)
	end

	def show
		@gtkObject.show
	end

	def coords
		[@row,@col]
	end

	def outOfBound
		# has to do nothing
	end
end

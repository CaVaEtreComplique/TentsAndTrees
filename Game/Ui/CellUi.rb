class CellUi

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
			@parent.beginDrag(self, event.button)
			Gdk.pointer_ungrab(Gdk::CURRENT_TIME)
		}
		@gtkObject.signal_connect("enter_notify_event") { |_, event|
			if @parent.draged?
				@parent.selection(self)
			end
		}
	end

	def to_s
		"(r#{@row}, c#{@col})"
	end

	def say(msg)
		puts "Cell #{self}: #{msg}"
	end

	def leftClicked
		coreCell.primaryChange()
		normal()
		show()
	end

	def dragLeftClicked
		coreCell.dragLeftChange()
		normal()
		show()
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
end

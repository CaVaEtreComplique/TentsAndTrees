require "gtk3"
require File.dirname(__FILE__) + "/CellUi"
require File.dirname(__FILE__) + "/SelectionUi"
require File.dirname(__FILE__) + "/ClueUi"
require File.dirname(__FILE__) + "/Constants"
require File.dirname(__FILE__) + "/Click"

class GridUi

	@gtkObject        # the associated gtk object
	@cells            # a matrix of all the cells
	@first            # the first cell in an action
	@last             # the last cell in an action
	@currentSelection # a SelectionUi object
	@game             # The game
	@rowClues         # all the clues for the rows
	@colClues         # all the clues for the cols
	@assets
	@click
	@screen

	attr_reader :gtkObject
	attr_reader :first, :last
	attr_reader :game, :cells

	##
	# creation of a new grid UI
	# @param game the current game
	#
	def initialize(game, assets)
		nRow = game.nRow
		nCol = game.nCol
		@game = game
		@assets = assets
		# cration of the UI version of the clues
		@rowClues = game.rowClues.each_with_index.map { |clue, i| ClueUi.new(:horizontal, clue, i) }
		@colClues = game.colClues.each_with_index.map { |clue, i| ClueUi.new(:vertical,   clue, i) }
		# creation of the UI version of the cells
		@cells = (0...nRow).map { |r|
			(0...nCol).map { |c|
				CellUi.new(self, r, c, @assets)
			}
		}
		# creation of the grid itself
		initGtkGrid()
		@gtkObject.signal_connect("button_release_event") { |_, event|
			if (@click == event.button)
				case event.button
				when Click::LEFT
					leftClickedDraged()
				end
			end
			endDrag()
		}
		# comment the lines below to test without the bug
		@gtkObject.signal_connect("leave_notify_event") { |widget, event|
			endDrag() if event.detail.nick != "inferior"
		}
		@currentSelection = SelectionUi.new
	end

	def initGtkGrid
		realGrid = Gtk::Grid.new
		realGrid.set_column_spacing(Constants::SPACING)
		realGrid.set_row_spacing(Constants::SPACING)
		@cells.each_with_index {|row,i|
			row.each_with_index {|cell,j|
				realGrid.attach(cell.gtkObject, i+1, j+1, 1, 1)
			}
		}
		@rowClues.each_with_index {|clue, i|
			realGrid.attach(clue.gtkObject, 0, i+1, 1, 1)
		}
		@colClues.each_with_index {|clue, i|
			realGrid.attach(clue.gtkObject, i+1, 0, 1, 1)
		}
		@gtkObject = Gtk::EventBox.new
		@gtkObject.add(realGrid)
	end

	def coreCellAt(row, col)
		@game.cellAt(row, col)
	end

	##
	# called when a left click occur on the grid
	#
	def leftClicked
		@first.leftClicked
	end

	##
	# called when a draged left click occur on the grid
	#
	def leftClickedDraged
		return unless clickdefined?
		return leftClicked unless draged?
		sameState = cellsFromFirstToEnd.select { |cell|
			cell.sameState?(@first)
		}
		case sameState.length
			when 1
				@first.leftClicked
			else
				sameState.each { |cell|
					@first = cell
					@first.dragLeftClicked
				}
		end
	end

	def beginDrag(cell, click)
		return endDrag if draged?
		@first = cell
		@click = click
		selection(cell)
	end

	def endDrag # :nodoc:
		@first = @last = nil
		@currentSelection.update([])
		@currentSelection.show()
	end

	def cellsFromFirstToEnd
		last = self.realLast
		firstRow, lastRow = [@first.row, last.row].minmax
		firstCol, lastCol = [@first.col, last.col].minmax
		cells = []
		(firstRow..lastRow).each { |row|
			(firstCol..lastCol).each { |col|
				cells << @cells[row][col]
			}
		}
		return cells
	end

	##
	# Draws a visual selection for the user
	#
	def selection(cell)
		@last = cell
		@currentSelection.update(cellsFromFirstToEnd())
		@currentSelection.show()
	end

	##
	# Compute the real last cell of the selection
	# @return CellUi
	#
	def realLast
		dc = (@first.col - @last.col).abs
		dr = (@first.row - @last.row).abs
		if dc < dr # then the selection vertical
			return @cells[@last.row][@first.col]
		else       # the selection is horizontal
			return @cells[@first.row][@last.col]
		end
	end

	def draged?
		@first != nil
	end

	def clickdefined?
		@last != nil && @first != nil
	end

end

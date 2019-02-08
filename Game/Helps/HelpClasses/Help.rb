#class Help, which contain a String text to explain the help, a column, a row

class Help
  private_class_methode :new

  def initialize(row, column, cell, text)
    @row = row
    @column = column
    @cell = cell
    @text = text
  end

  attr_reader :row, :column, :cell, :text

  def to_s
    return text
  end
end

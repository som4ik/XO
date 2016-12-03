module BoardScanner
  def scan(position, mark)
    row,col = position.split(':')
    row = row.to_i
    col = col.to_i
    find_match(row, col, mark)
  end

  private

  def find_match(row, col, mark)
    return 'win' if row_match(row, mark) || col_match(col, mark) || diagonals(mark)
    return 'no one' if all_board_marked
    return 'next'
  end

  def row_match(row, mark)
    stats = self.statistics
    return true if stats[row][1] + stats[row][2] + stats[row][3] == mark*3
    false
  end

  def col_match(col, mark)
    stats = self.statistics
    return true if stats[1][col] + stats[2][col] + stats[3][col] == mark*3
    false
  end

  def diagonals(mark)
    stats = self.statistics
    return true if stats[1][1] + stats[2][2] + stats[3][3] == mark*3
    return true if stats[1][3] + stats[2][2] + stats[3][1] == mark*3
    return false
  end

  def all_board_marked
    cells = ''
    (1..3).each do |n|
      (1..3).each do |f|
        cells << statistics[n][f]
      end
    end
    cells.length == 9
  end
end

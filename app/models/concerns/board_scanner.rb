module BoardScanner
  def update_and_scan_board(position, mark)
    row,col = position.split(':')
    row = row.to_i
    col = col.to_i
    statistics[row.to_i][col.to_i] = mark
    self.save
    find_match(row, col, mark)
  end

  def winner_cells(position, mark)
    r,c = position.split(':')
    row = r.to_i
    col = c.to_i
    s = self.statistics
    return [r+'1', r+'2', r+'3'] if row_match(row, mark)
    return ['1'+c,'2'+c, '3'+c ] if col_match(col, mark)
    return ['11', '22', '33'] if s[1][1] + s[2][2] + s[3][3] == mark*3
    return ['13', '22', '31'] if s[1][3] + s[2][2] + s[3][1] == mark*3
    return r+c
  end

  private

  def find_match(row, col, mark)
    return  win(mark) if row_match(row, mark) || col_match(col, mark) || diagonals(mark)
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

  def win(mark)
    self.update(winner: round_players.find_by(mark: mark).player_id, status: 2)
    return 'win'
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

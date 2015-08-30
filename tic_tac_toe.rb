class Box
  attr_reader :left, :middle, :right

  def initialize(left, middle, right)
    @left     = left
    @middle   = middle
    @right    = right
  end

  def take(letter)
    @middle = letter
  end

  def content
    "#{left}#{middle}#{right}"
  end
end

class TicTacToe

  def start_game
    @one   = Box.new("_", 1, "|")
    @two   = Box.new("_", 2, "_")
    @three = Box.new("|", 3, "_")
    @four  = Box.new("_", 4, "|")
    @five  = Box.new("_", 5, "_")
    @six   = Box.new("|", 6, "_")
    @seven = Box.new(" ", 7, "|")
    @eight = Box.new(" ", 8, " ")
    @nine  = Box.new("|", 9, " ")
    @unoccupied    = Array(1..9)
    @winning_boxes = [[1,2,3], [4,5,6], [7,8,9],
                      [1,4,7], [2,5,8], [3,6,9],
                      [1,5,9], [3,5,7]]
    display
    run_game
  end

  private

  def run_game
    puts "Let's play Tic Tac Toe!"

    loop do
      puts "Player One is X and Player Two is O."
      choose_spot("One", "X")
      if victory("X")
        puts "Player One wins!"
        break
      elsif tie?
        puts "The game is a tie!"
        break
      else
        choose_spot("Two", "O")

        if victory("O")
          puts "Player Two wins!"
          break
        end
      end
    end

    puts "Bye Bye!"
  end

  def display
    puts @one.content   + @two.content   + @three.content
    puts @four.content  + @five.content  + @six.content
    puts @seven.content + @eight.content + @nine.content
  end

  def choose_spot(player, piece)
    puts "Player #{player}'s turn."
    turn = true

    while turn
      puts "Place your piece by entering an unocuppied number."
      input = gets.chomp
      if @unoccupied.include?(input.to_i)
        turn = false
        @unoccupied.delete(input.to_i)
        adjust_winning_boxes(input.to_i, piece)
        place_piece(input.to_i, piece)
      else
        puts "Try again."
      end
      display
    end
  end

  def adjust_winning_boxes(space, piece)
    @winning_boxes.each do |set|
      set[set.index(space)] = piece if set.include?(space)
    end
  end

  def place_piece(space, piece)
    case space
      when 1 then @one.take(piece)
      when 2 then @two.take(piece)
      when 3 then @three.take(piece)
      when 4 then @four.take(piece)
      when 5 then @five.take(piece)
      when 6 then @six.take(piece)
      when 7 then @seven.take(piece)
      when 8 then @eight.take(piece)
      when 9 then @nine.take(piece)
      else
        puts "How did you get here?"
    end
  end

  def tie?
    @unoccupied.empty?
  end

  def victory(piece)
    @winning_boxes.each do |set|
      return true if set.uniq == [piece]
    end
    false
  end
end

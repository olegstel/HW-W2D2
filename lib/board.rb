require "byebug"
class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) { Array.new }
    place_stones
  end

  def place_stones
    help_arr = (0..12).to_a
    help_arr.each do |i|
      next if i == 6
       4.times { @cups[i] << :stone}
    end
    # helper method to #initialize every non-store cup with four stones each
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" unless [0..13].include?(start_pos)
    raise "Invalid starting cup" if @cups[start_pos].empty?

  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos]
    @cups[start_pos] = []
    idx = start_pos
    while  stones.count > 0
      idx += 1
      idx = 0 if idx > 13
      if idx == 6
        @cups[6] << stones.pop if current_player_name == @name1
      elsif idx == 13
        @cups[13] << stones.pop if current_player_name == @name2
      else
        @cups[idx] << stones.pop
      end
    end

     render
     next_turn(idx)
  end
 
  def next_turn(idx)
    if idx == 6 || idx == 13
      :prompt
    elsif @cups[idx].count == 1
      :switch
    else
    idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    player1_empty = @cups[0..5].all?{ |el| el.empty? }
    player2_empty = @cups[7..12].all?{ |el| el.empty? }
    player1_empty || player2_empty
  end

  def winner
    case  @cups[6].count <=> @cups[13].count
    when -1
      @name2
    when 0
      :draw
    when 1
      @name1
    end
  end
end

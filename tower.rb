class TowerOfHanoi
  attr_reader :towers, :num_towers

  def initialize(height)
    @num_towers = height
    @towers = Array.new(3) { Array.new }
    (1..height).each { |i| @towers[0].unshift(i) }
  end

  def play
    puts "Welcome to the Tower of Hanoi!!"
    puts "Instructions: Enter where you'd like to move from and to in the format: "
    puts "'1, 2, or 3'. Enter 'q' to quit."
    render
    until won?
      puts "Which rod would you like to move a disc from?"
      input = gets.chomp
      break if input == 'q'
      from_stack = input.to_i
      puts "Which rod would you like to move the disk to?"
      input_2 = gets.chomp
      break if input_2 == 'q'
      to_stack = input_2.to_i
      if valid_move?(from_stack, to_stack)
        move(from_stack, to_stack)
        puts "Disk has been moved"
        render
      end
    end
    puts "Congrats! You won!" if won?
    puts "Thanks for playing!!"
  end

  def won?
    @towers[0].empty? && @towers[1..2].any?(&:empty?)
  end

  def valid_move?(from_tower, to_tower)
    if ![from_tower, to_tower].all? { |i| i.between?(1, 3) }
      puts "Please use a valid tower number: 1, 2, or 3. "
      false
    elsif from_tower == to_tower
      puts "You must move to a different pile"
      false
    elsif @towers[from_tower - 1].empty?
      puts "Tower #{from_tower} is empty! Try again"
      false
    elsif !@towers[to_tower - 1].empty? && @towers[from_tower - 1].last > @towers[to_tower - 1].last
      puts "A larger disk can't be placed on top of a smaller disk."
      false
    else
      true
    end
  end

  def move(from_tower, to_tower)
    @towers[to_tower - 1] << @towers[from_tower - 1].pop
  end

  def render
    puts "Current board:"
    i = @num_towers
    while i > 0
      row = ""
      @towers.each do |tower|
        if !tower [i - 1].nil?
          tower[i - 1].times { row << "o" }
          (@num_towers - tower [i - 1] + 1).times {row << " " }
        else
          (@num_towers + 1).times { row << " " }
        end
      end
      puts row
      i -= 1
    end
    labels = ""
    (1..3).each do |t|
      labels << t.to_s
      (@num_towers - 1).times {labels << " " }
    end
    puts labels
  end

end

t = TowerOfHanoi.new(3)
t.play

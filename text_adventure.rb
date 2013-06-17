require 'pp'

class Room

  attr_reader  :id, :description, :east, :west, :north, :south

  def initialize(id, description, east, west, north, south)
    @id = id
    @description = description
    @east = east
    @west = west
    @north = north
    @south = south
  end

  def exits()
    print "exits are:\n"
    [:north, :east, :south, :west].each do |direction|
      case direction
      when :north
        print "\t#{direction}\n" if (@north > 0)
      when :south
        print "\t#{direction}\n" if (@south > 0)
      when :east
        print "\t#{direction}\n" if (@east > 0)
      when :west
        print "\t#{direction}\n" if (@west > 0)
      end
    end
  end

  def go(direction, world)
    newroom = self.send(direction)
    if (newroom == 0) then
      print "you can't go in that direction, you're still in the same location\n\n"
      return self
    else
      return world[newroom] 
    end
  end
end

######MAIN PROGRAM
world = Array.new
arr = IO.readlines("room.data")
arr.each do |line| 
  id, description, east, west, north, south = line.chomp.split(/\|/)
  room = Room.new(id.to_i,description,east.to_i,west.to_i,north.to_i,south.to_i)
  world[room.id] = room
end
room = world[1]
loop do
  print "#{room.description}\n***********\n"
  room.exits
  print "enter a command (go 'direction'): "
  command = gets.chomp
  print "\n\n"
  case command 
  when 'go north' 
    room = room.go('north',world)
  when 'go south' 
    room = room.go('south',world)
  when 'go east' 
    room = room.go('east',world)
  when 'go west' 
    room = room.go('west',world)
  else puts "you can't do that" 
  end
end

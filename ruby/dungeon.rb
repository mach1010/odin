class Dungeon
  attr_accessor :player, :rooms
  
  def self.begin
    puts "Welcome to the dungeon!! \n\n"
    puts "Before we begin, please enter your name!"
    name = gets.chomp
    puts "Welcome, #{name}. Enjoy your journey. OK it's only 4 rooms, but still..."
    
    dungeon = Dungeon.new name
  end
  
  def initialize player_name
    @player = Player.new player_name
    @rooms = []
    add_room :largecave, "large cave", "a dank smelly large cave", {east: :smallcave, north: :cozyhome}
    add_room :smallcave, "small cave", " adank smelly small cave", {west: :largecave, north: :undergroundlake}
    add_room :undergroundlake, "underground lake", "an even more dank, but maybe slightly less smelly cave. There is an underground lake here. A faint glow seems to be coming from the bottom of the lake", {west: :cozyhome, south: :smallcave}
    add_room :cozyhome, "cozy home", "really nice warm softly lit single room home", {east: :undergroundlake, south: :largecave}

    start :largecave
  end
  
  def add_room reference, name, description, connections
    @rooms << Room.new(reference, name, description, connections)
  end
  
  def start location
    @player.location = location
    show_current_description
  end
  
  def next_move
    available_directions = find_available_directions
    available_directions.each {|direction| puts "you can go " + direction.to_s}
    puts "Which direction would you like to go?"
    next_move = gets.chomp.downcase.to_sym

    case next_move
    when *available_directions
      go next_move
    when :quit, :q
      puts "Thanks for playing! Goodbye!"
      exit
    when :look, :l
      show_current_description
    else 
      puts "You can't go that way."
      self.show_current_description
    end
  end
  
  def show_current_description
    puts find_room_in_dungeon(@player.location).full_description
    next_move
  end
  
  def find_room_in_dungeon reference
    @rooms.find {|room| room.reference == reference}
  end
  
  def find_room_in_direction direction
    find_room_in_dungeon(@player.location).connections[direction]
  end
  
  def find_available_directions
    find_room_in_dungeon(@player.location).connections.keys
  end
  
  def go direction
    puts "You go " + direction.to_s
    @player.location = find_room_in_direction direction
    show_current_description
  end
  
  Player = Struct.new(:name, :location)
  
  class Room
    attr_accessor :reference, :name, :description, :connections
    def initialize(reference, name, description, connections)
      @reference = reference
      @name = name
      @description = description
      @connections = connections
    end
    
    def full_description
      @name + "\n\nYou are in " + @description
    end
  end 
end

Dungeon::begin



# TODO: throw invalid input, handle exceptions, initialize game properly


class MeetupHelper::Meetup

  attr_accessor :event_name, :group_id, :group_name, :event_id, :date, :venue, :yes_rsvps

  @@all = []

  def initialize
    @@all << self
  end

  def self.all
    @@all
  end

  def self.reset_all
    @@all.clear
  end

  def self.find_events_by_group_name
    puts "Type the name of the meetup group you'd like to find past events for:"
    input = gets.strip
    @events_array = MeetupHelper::Meetup.all.find_all {|meetup| meetup.group_name.include?(input)}
    self.print_events_by_group_name
  end

  def self.print_events_by_group_name
    @events_array.each_with_index do |meetup, index|
      puts ""
      puts "Group name: #{meetup.group_name}" if index == 0
      puts "#{index+1}:"
      puts "Event name: #{meetup.event_name}"
      puts "Date: #{meetup.date}"
      puts "Location: #{meetup.venue[:name]}"
      puts "Address: #{meetup.venue[:address_1]}"
      puts ""
    end
  end

  def self.list_groups
    group_array = MeetupHelper::Meetup.all.collect {|meetup| meetup.group_name}.uniq
    group_array.each_with_index {|value, index| puts "#{index+1}. #{value}"}
  end

  def self.delete_meetups
    self.find_events_by_group_name
    puts "Enter the number of the event you did not actually attend and would like to delete:"
    input = gets.strip
    input = input.to_i - 1
    @@all.delete_if {|meetup| meetup.event_id == @events_array[input].event_id}
    @events_array.delete_at(input)
    self.print_events_by_group_name
  end


  def self.get_event_id
    self.find_events_by_group_name
    puts "Enter the number of the event you'd like to get pictures from:"
    input = gets.strip
    input = input.to_i - 1
    @id = @events_array[input].event_id
    binding.pry
    #Meetup.all[0].group_info[:id]
  end

end

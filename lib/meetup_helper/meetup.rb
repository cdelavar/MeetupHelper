class MeetupHelper::Meetup

  attr_accessor :event_name, :group_id, :group_name, :event_id, :date, :venue, :yes_rsvps, :photo_album_id

  @@all = []

  def initialize
    @@all << self
  end

  def self.all
    @@all
  end

  def self.count
    puts "You have attended #{self.all.count} meetup events since #{self.all[0].date.to_s.split(/ /)[0]}."
  end

  def self.find_events_by_group_name
    puts ""
    puts "Type the name of the meetup group you'd like to find past events for:"
    input = gets.strip
    @events_array = MeetupHelper::Meetup.all.find_all {|meetup| meetup.group_name.include?(input)}
    if @events_array.empty?
      puts "Cannot find that group name. Please try again."
      self.find_events_by_group_name
    else
      self.print_events(@events_array)
    end
  end

  def self.list_groups
    group_array = MeetupHelper::Meetup.all.collect {|meetup| meetup.group_name}.uniq
    group_array.each_with_index {|value, index| puts "#{index+1}. #{value}"}
  end

  def self.print_events(array)
    array.each_with_index do |meetup, index|
      puts ""
      puts "#{index+1}."
      puts "Group name: #{meetup.group_name}"
      puts "Event name: #{meetup.event_name}"
      puts "Date: #{meetup.date}"
      if meetup.venue != nil
        puts "Location: #{meetup.venue[:name]}" 
        puts "Address: #{meetup.venue[:address_1]}"
      else
        puts "Location: none listed"
        puts "Address: none listed"
      end
      puts ""
    end
  end
  
  def self.get_input
    @input = gets.strip.to_i - 1
  end

  def self.delete_meetups
    self.find_events_by_group_name
    puts "Enter the number of the event you did not actually attend and would like to delete:"
    self.get_input
    @@all.delete_if {|meetup| meetup.event_id == @events_array[@input].event_id}
    @events_array.delete_at(@input)
    self.print_events(@events_array)
  end


  def self.get_pictures_from_event
    self.find_events_by_group_name
    puts "Enter the number of the event you'd like to get pictures from:"
    self.get_input
    if @events_array[@input].photo_album_id != nil
      photo_id = @events_array[@input].photo_album_id
      MeetupHelper::ApiCalls.new.call_api_photos(params = {photo_album_id: photo_id})
    else
      puts "That event does not have a photo album." 
      self.get_pictures_from_event
    end
  end

end

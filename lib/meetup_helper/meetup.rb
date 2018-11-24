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
    input = self.get_input_group_name
    events_array = self.find_by_name(input)
    
    if events_array.empty?
      puts "Cannot find that group name. Please try again."
      self.find_events_by_group_name
    else
      MeetupHelper::CLI.print_events(events_array)
    end
    events_array
  end

  
  def self.find_by_name(name)
    self.all.find_all {|meetup| meetup.group_name.include?(name)}
  end

  
  def self.list_groups
    group_array = self.all.collect {|meetup| meetup.group_name}.uniq
    group_array.each_with_index {|value, index| puts "#{index+1}. #{value}"}
  end

  
  def self.get_input_group_name
    puts ""
    puts "Type the name of the meetup group you'd like to find past events for:"
    gets.strip
  end
  
  
  def self.get_input_int
    gets.strip.to_i - 1
  end

  
  def self.delete_meetups
    events_array = self.find_events_by_group_name
    puts "Enter the number of the event you did not actually attend and would like to delete:"
    input = self.get_input_int
    @@all.delete_if {|meetup| meetup.event_id == events_array[input].event_id}
    events_array.delete_at(input)
    MeetupHelper::CLI.print_events(events_array)
  end


  def self.get_pictures_from_event
    events_array = self.find_events_by_group_name
    puts "Enter the number of the event you'd like to get pictures from:"
    input = self.get_input_int
    if events_array[input].photo_album_id != nil
      photo_id = events_array[input].photo_album_id
      MeetupHelper::ApiCalls.new.call_api_photos(params = {photo_album_id: photo_id})
    else
      puts "That event does not have a photo album." 
      self.get_pictures_from_event
    end
  end

end

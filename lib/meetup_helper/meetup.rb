class MeetupHelper::Meetup

  attr_accessor :event_name, :group_id, :group_name, :event_id, :date, :venue, :yes_rsvps, :photo_album_id

  @@all = []

  def initialize
    @@all << self
  end

  def self.all
    @@all
  end

  

  
  def self.find_by_group_name(name)
    self.all.find_all {|meetup| meetup.group_name.downcase.include?(name)}
  end

  def self.all_unique
    self.all.collect {|meetup| meetup.group_name}.uniq
  end

  
  

end

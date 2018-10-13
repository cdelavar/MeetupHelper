class MeetupHelper::Scraper

  require 'meetup_client'
  require 'mechanize'
  require 'pry'

  def self.scrape_events
    MeetupHelper::ApiCalls.results[:results].each do |event|
      meetup = MeetupHelper::Meetup.new
      meetup.event_name = event[:name]
      meetup.group_id = event[:group][:id]
      meetup.group_name = event[:group][:name]
      meetup.event_id = event[:id]
      event_date = event[:time]
      meetup.date = Time.at(event_date/1000)
      meetup.venue = event[:venue]
      meetup.yes_rsvps = event[:yes_rsvp_count]
      meetup.photo_album_id = event[:photo_album_id]
    end
  end


def self.scrape_photos
    photos = MeetupHelper::ApiCalls.results[:results].collect { |photo| photo[:highres_link]}
    agent = Mechanize.new
    agent.pluggable_parser.default = Mechanize::Download
    puts "Directory path for saving the files:"
    path = gets.strip
    photos.each do |photo|
      agent.get(photo).save(File.join(path, "#{File.basename(photo)}"))
    end
  end
end
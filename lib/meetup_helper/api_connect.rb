class MeetupHelper::ApiConnect

  require 'meetup_client'
  require 'mechanize'
  require 'pry'

  
  def initialize
    url = 'https://secure.meetup.com/meetup_api/key/'
    @@api_key = MeetupHelper::SignIn.agent.get(url).css("#api-key-reveal").first.attribute("value").text
    @@member_id = MeetupHelper::SignIn.agent.get(url).css("#nav-account-links a").attribute("href").value.split("/")[-1]
  end

  def connect_to_meetup_api
    MeetupClient.configure do |config|
      config.api_key = @@api_key
    end
  end

  def self.member_id
    @@member_id
  end
    

  def call_api_events(params = nil) 
    self.connect_to_meetup_api
    meetup_api = MeetupApi.new
    events = meetup_api.events(params)
    @results = JSON.parse(events.to_json, {:symbolize_names => true} )
    scrape_events
  end 

  def self.call_api_photos(params = nil)
    meetup_api = MeetupApi.new
    photos = meetup_api.photos(params)
    @results = JSON.parse(photos.to_json, {:symbolize_names => true} )
    self.scrape_photos
  end
    #binding.pry

  
      
    #meetup_api = MeetupApi.new
    #photos = meetup_api.photos({event_id: "214010382"})
    #photo_results = JSON.parse(photos.to_json, {:symbolize_names => true} )
    #results[:results][0][:photo_album][:photo_album_id]

    #def get_photos(event_id)
      #events = meetup_api.events({event_id: event_id})
    #end


    
  def scrape_events
    @results[:results].each do |event|
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
    photos = @results[:results].collect { |photo| photo[:highres_link]}
    agent = Mechanize.new
    agent.pluggable_parser.default = Mechanize::Download
    puts "Directory path for saving the files:"
    path = gets.strip
    photos.each do |photo|
      agent.get(photo).save(File.join(path, "#{File.basename(photo)}"))
    end
    #/Users/Mothership1/documents/Pics
  end
end
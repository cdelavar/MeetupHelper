class MeetupHelper::ApiCalls

  require 'meetup_client'
  require 'mechanize'
  require 'pry'

  def self.call_api_events(params = nil) 
    meetup_api = MeetupApi.new
    events = meetup_api.events(params)
    @@results = JSON.parse(events.to_json, {:symbolize_names => true} )
    MeetupHelper::Scraper.scrape_events
  end 

  def self.call_api_photos(params = nil)
    meetup_api = MeetupApi.new
    photos = meetup_api.photos(params)
    @@results = JSON.parse(photos.to_json, {:symbolize_names => true} )
    MeetupHelper::Scraper.scrape_photos
  end

  def self.results
    @@results
  end

end
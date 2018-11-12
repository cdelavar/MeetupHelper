class MeetupHelper::ApiCalls

  def initialize
    @meetup_api = MeetupApi.new
  end

  def call_api_events(params = nil) 
    events = @meetup_api.events(params)
    @@results = JSON.parse(events.to_json, {:symbolize_names => true} )
    MeetupHelper::Parser.parse_events
  end 

  def call_api_photos(params = nil)
    photos = @meetup_api.photos(params)
    @@results = JSON.parse(photos.to_json, {:symbolize_names => true} )
    MeetupHelper::Parser.parse_photos
  end

  def self.results
    @@results
  end

end
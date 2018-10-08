class MeetupHelper::ApiConnect

  require 'meetup_client'
  require 'mechanize'
  require 'pry'

  

  def get_api_key_and_member_id
    MeetupHelper::SignIn.new.sign_in
    url = 'https://secure.meetup.com/meetup_api/key/'
    @api_key = MeetupHelper::SignIn.agent.get(url).css("#api-key-reveal").first.attribute("value").text
    @member_id = MeetupHelper::SignIn.agent.get(url).css("#nav-account-links a").attribute("href").value.split("/")[-1]
  end


  def connect_to_meetup_api
    get_api_key_and_member_id 
    MeetupClient.configure do |config|
      config.api_key = @api_key
    end
    

    
    meetup_api = MeetupApi.new
    events = meetup_api.events({rsvp: 'yes', member_id: @member_id, status: 'past'})
    
    results = JSON.parse(events.to_json, {:symbolize_names => true} )
    
    #binding.pry

  
      
    #meetup_api = MeetupApi.new
    #photos = meetup_api.photos({event_id: "214010382"})
    #photo_results = JSON.parse(photos.to_json, {:symbolize_names => true} )
    #results[:results][0][:photo_album][:photo_album_id]

    #def get_photos(event_id)
      #events = meetup_api.events({event_id: event_id})
    #end


    

    results[:results].each do |event|
      meetup = MeetupHelper::Meetup.new
      meetup.event_name = event[:name]
      meetup.group_id = event[:group][:id]
      meetup.group_name = event[:group][:name]
      meetup.event_id = event[:id]
      event_date = event[:time]
      meetup.date = Time.at(event_date/1000)
      meetup.venue = event[:venue]
      meetup.yes_rsvps = event[:yes_rsvp_count]
    end
  end
  


end
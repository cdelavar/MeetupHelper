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

end
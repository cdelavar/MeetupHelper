class MeetupHelper::ApiConnect

  def self.connect_to_meetup_api
    url = 'https://secure.meetup.com/meetup_api/key/'
    @@api_key = MeetupHelper::SignIn.agent.get(url).css("#api-key-reveal").first.attribute("value").text
    @@member_id = MeetupHelper::SignIn.agent.get(url).css("#nav-account-links a").attribute("href").value.split("/")[-1]
    MeetupClient.configure do |config|
      config.api_key = @@api_key
    end
  end

  def self.member_id
    @@member_id
  end

end
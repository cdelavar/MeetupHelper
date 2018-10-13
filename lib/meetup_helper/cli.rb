class MeetupHelper::CLI

  def call
    puts "Welcome to Meetup Helper!"
    MeetupHelper::SignIn.new.sign_in
    MeetupHelper::ApiConnect.new.connect_to_meetup_api
    MeetupHelper::ApiCalls.call_api_events(params = {rsvp: 'yes', member_id: MeetupHelper::ApiConnect.member_id, status: 'past', fields: "photo_album_id"})
    get_input
  end

  def options
    @options = MeetupHelper::Options.list_options
  end

  def get_input
    input = nil
    until input == "6"
      puts ""
      options
      puts "Please enter a number 1-6:"
      input = gets.strip.to_s

      case input
      when "1"
        MeetupHelper::Meetup.list_groups
      when "2"
        MeetupHelper::Meetup.find_events_by_group_name
      when "3"
        MeetupHelper::Meetup.delete_meetups
      when "4"
        MeetupHelper::Meetup.get_pictures_from_event
      when "5"
        MeetupHelper::Meetup.print_events
      end
    end
  end

end
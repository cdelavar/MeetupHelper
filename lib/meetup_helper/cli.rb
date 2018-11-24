class MeetupHelper::CLI

  def call
    puts "Welcome to Meetup Helper!"
    MeetupHelper::SignIn.sign_in
    MeetupHelper::ApiConnect.connect_to_meetup_api
    MeetupHelper::ApiCalls.new.call_api_events(params = {rsvp: 'yes', member_id: MeetupHelper::ApiConnect.member_id, status: 'past', fields: "photo_album_id"})
    get_input
  end

  def options
    MeetupHelper::Options.list_options
  end

  def get_input
    input = nil
    until input == "7"
      puts ""
      options
      puts "Please enter a number 1-7:"
      input = gets.strip

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
        MeetupHelper::Meetup.print_events(MeetupHelper::Meetup.all)
      when "6"
        MeetupHelper::Meetup.count
      end
    end
  end

end
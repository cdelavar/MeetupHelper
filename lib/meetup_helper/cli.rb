class MeetupHelper::CLI

  def call
    puts "Welcome to Meetup Helper!"
    MeetupHelper::ApiConnect.new.connect_to_meetup_api
    get_input
  end

  def options
    
    @options = MeetupHelper::Options.list_options
  end

  def get_input
    input = nil
    until input == "5"
      options
      puts "Please enter a number 1-5:"
      input = gets.strip.to_s
      puts ""

      case input
      when "1"
        MeetupHelper::Meetup.list_groups
      when "2"
        MeetupHelper::Meetup.find_events_by_group_name
      when "3"
        MeetupHelper::Meetup.delete_meetups
      when "4"
        MeetupHelper::Meetup.get_event_id
      end
    end


  end
end
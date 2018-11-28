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
        list_groups
      when "2"
        find_events_by_group_name
      when "3"
        delete_meetups
      when "4"
        get_pictures_from_event
      when "5"
        print_events(MeetupHelper::Meetup.all)
      when "6"
        count
      end
    end
  end

  def count
    puts "You have attended #{MeetupHelper::Meetup.all.count} meetup events since #{MeetupHelper::Meetup.all[0].date.to_s.split(/ /)[0]}."
  end

  def print_events(array)
    array.each_with_index do |meetup, index|
      puts ""
      puts "#{index+1}."
      puts "Group name: #{meetup.group_name}"
      puts "Event name: #{meetup.event_name}"
      puts "Date: #{meetup.date}"
      if meetup.venue != nil
        puts "Location: #{meetup.venue[:name]}" 
        puts "Address: #{meetup.venue[:address_1]}"
      else
        puts "Location: none listed"
        puts "Address: none listed"
      end
      puts ""
    end
  end

  def list_groups
    group_array = MeetupHelper::Meetup.all_unique
    group_array.each_with_index {|value, index| puts "#{index+1}. #{value}"}
  end

  
  def get_input_group_name
    puts ""
    puts "Type the name of the meetup group you'd like to find past events for:"
    gets.strip.downcase
  end
  
  
  def get_input_int
    gets.strip.to_i - 1
  end

  def list_events_by_group_name
    input = get_input_group_name
    events_array = MeetupHelper::Meetup.find_by_group_name(input)
    
    if events_array.empty?
      puts "Cannot find that group name. Please try again."
      list_events_by_group_name
    else
      print_events(events_array)
    end
  end

  
  def delete_meetups
    events_array = list_events_by_group_name
    puts "Enter the number of the event you did not actually attend and would like to delete:"
    input = get_input_int
    MeetupHelper::Meetup.all.delete_if {|meetup| meetup.event_id == events_array[input].event_id}
    events_array.delete_at(input)
    print_events(events_array)
  end


  def get_pictures_from_event
    events_array = list_events_by_group_name
    puts "Enter the number of the event you'd like to get pictures from:"
    input = get_input_int
    if events_array[input].photo_album_id != nil
      photo_id = events_array[input].photo_album_id
      MeetupHelper::ApiCalls.new.call_api_photos(params = {photo_album_id: photo_id})
    else
      puts "That event does not have a photo album." 
      get_pictures_from_event
    end
  end

end
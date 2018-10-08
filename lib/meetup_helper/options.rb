class MeetupHelper::Options

  def self.list_options
    puts <<-DOC
      1. List past meetup groups
      2. List past meetups attended
      3. Delete meetups not attended
      4. Get pictures from meetups
      5. Exit
    DOC
  end
end
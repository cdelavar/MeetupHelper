class MeetupHelper::Options

  def self.list_options
    puts <<-DOC
      1. List meetup groups from attended events
      2. List past meetups attended by group
      3. Delete meetups not attended
      4. Get pictures from meetups
      5. List all meetups attended
      6. Exit
    DOC
  end
end
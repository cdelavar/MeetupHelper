class MeetupHelper::SignIn

  def self.sign_in
    @@agent = Mechanize.new
    page = @@agent.get('https://secure.meetup.com/login/')
    sign_in = page.forms[1]
    puts "Sign in to Meetup.com"
    puts "Email: "
    sign_in.email = gets.chomp
    puts "Password: "
    sign_in.password = STDIN.noecho(&:gets).chomp
    page = @@agent.submit(sign_in)
  end

  def self.agent
    @@agent
  end

end
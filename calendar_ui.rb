require 'bundler/setup'
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])

def main_menu
  system('clear')
  choice = nil
  until choice == 'e'
    puts ' '*20 + 'Welcome to your calendar'
    puts ' '*20 + 'What do you want to do?'
    puts ' '*20 + 'Type l to list all your events'
    puts ' '*20 + 'Type ld to list all your events in order'
    puts ' '*20 + 'Type a to add an event'
    puts ' '*20 + 'Type ls to look at events on a specific day, week, or month'
    puts ' '*20 + 'Type e to exit'

    choice = gets.chomp
    case choice
    when 'l'
      list_events_interface
    when 'ld'
      list_events_by_date
    when 'a'
      add_events_interface
    when 'e'
      puts 'Goodbye!'
    when 'poodle'
      dog_sound = 'bark'
        500.times do
          puts dog_sound
          dog_sound = dog_sound + ' bark'
          sleep(1)
        end
    when 'ls'
      lookup_events_specific
    else
      puts 'Please enter a valid argument'
    end
  end
end

def lookup_events_specific
  choice = nil
  until choice =='e'
  puts "Press d to see events on a specific day"
  puts "Press w to see events for a week"
  puts "Press m to see events for a month"
  puts "Press e to exit"
  choice = gets.chomp
    case choice
    when 'd'
      puts "Please enter a day to see what events start that day yyyy-mm-dd"
      day_choice = gets.chomp
      look_up_by_day(day_choice)
    when 'w'
      puts 'Please enter the first day of the week you want to see events for (yyyy-mm-dd)'
      week_choice = gets.chomp
      look_up_by_week(week_choice)
    when 'm'
      puts 'Please enter the month you want to see events for (mm)'
      month_choice = gets.chomp
      puts 'Pleae enter the year you want to see events for (yyyy)'
      year_choice = gets.chomp
      whole_month = "01/#{month_choice}/#{year_choice}"
      whole_month = whole_month.to_date
      look_up_by_month(whole_month)
    when 'e'
      puts "Go back to Main Menu"
    else
      puts "Invalid"
    end
  end
end

def look_up_by_day(day_choice)
  system('clear')
  # puts "Please enter a day to see what events start that day yyyy-mm-dd"
  # day_choice = gets.chomp
  events = Event.where(start_date: day_choice)

  puts ' '*20 + "Here are the events on '#{day_choice}'\n\n\n"

  events.each do |event|
    puts ' '*20 + event.description
  end
  change_day(day_choice)
end
def change_day(day_choice)
  puts "\n\n"
  puts ' '*20 + 'to see the events on the the next day type "n"'
  puts ' '*20 + 'to see the events on the the next week type "w"'
  puts ' '*20 + 'to see the events on the the next month type "m"'
  puts ' '*20 + 'to see the events on the the next year type "y"'
  puts ' '*20 + 'to see the events on the previous day type "p"'
  puts ' '*20 + 'to see the events on the previous week type "pw"'
  puts ' '*20 + 'to see the events on the previous month type "pm"'
  puts ' '*20 + 'to see the events on the previous year type "py"'
  puts ' '*20 + 'to return to the main menu type main'
  case gets.chomp
  when 'n'
    look_up_by_day(day_choice.to_date + 1.day)
  when 'p'
    look_up_by_day(day_choice.to_date - 1.day)
  when 'w'
    look_up_by_day(day_choice.to_date + 1.week)
  when 'm'
    look_up_by_day(day_choice.to_date + 1.month)
  when 'y'
    look_up_by_day(day_choice.to_date + 1.year)
  when 'pw'
    look_up_by_day(day_choice.to_date - 1.week)
  when 'pm'
    look_up_by_day(day_choice.to_date - 1.month)
  when 'py'
    look_up_by_day(day_choice.to_date - 1.year)
  when 'main'
    main_menu
  else
    puts 'that is not a valid option'
    change_day(day_choice)
  end
end

def look_up_by_week(week_choice)
  system('clear')
  events = Event.where("start_date between ? and ?", week_choice, (week_choice.to_date+5.days))
  puts ' '*20 + "Here are the events between #{week_choice} and #{week_choice.to_date+5.days}"

  events.each do |event|
    puts ' '*20 + event.description
  end
  change_week(week_choice)
end

def change_week(week_choice)
  puts ' '*20 + 'to see the events on the the next day type "n"'
  puts ' '*20 + 'to see the events on the the next week type "w"'
  puts ' '*20 + 'to see the events on the the next month type "m"'
  puts ' '*20 + 'to see the events on the the next year type "y"'
  puts ' '*20 + 'to see the events on the previous day type "p"'
  puts ' '*20 + 'to see the events on the previous week type "pw"'
  puts ' '*20 + 'to see the events on the previous month type "pm"'
  puts ' '*20 + 'to see the events on the previous year type "py"'
  puts ' '*20 + 'to return to the main menu type main'
  case gets.chomp
  when 'n'
    look_up_by_week(week_choice.to_date + 1.day)
  when 'p'
    look_up_by_week(week_choice.to_date - 1.day)
  when 'w'
    look_up_by_week(week_choice.to_date + 1.week)
  when 'm'
    look_up_by_week(week_choice.to_date + 1.month)
  when 'y'
    look_up_by_week(week_choice.to_date + 1.year)
  when 'pw'
    look_up_by_week(week_choice.to_date - 1.week)
  when 'pm'
    look_up_by_week(week_choice.to_date - 1.month)
  when 'py'
    look_up_by_week(week_choice.to_date - 1.year)
  when 'main'
    main_menu
  else
    puts 'that is not a valid option'
    change_week(week_choice)
  end
end

def look_up_by_month(whole_month)
  system('clear')
  events = Event.where("start_date between ? and ?", whole_month, (whole_month.to_date+1.month))
  puts ' '*20 + "Here are the events between #{whole_month} and #{whole_month.to_date+1.month}"

  events.each do |event|
    puts ' '*20 + "#{event.description} is on #{event.start_date}"
  end
  change_month(whole_month)
end

def change_month(whole_month)
  puts ' '*20 + 'to see the events on the the next day type "n"'
  puts ' '*20 + 'to see the events on the the next week type "w"'
  puts ' '*20 + 'to see the events on the the next month type "m"'
  puts ' '*20 + 'to see the events on the the next year type "y"'
  puts ' '*20 + 'to see the events on the previous day type "p"'
  puts ' '*20 + 'to see the events on the previous week type "pw"'
  puts ' '*20 + 'to see the events on the previous month type "pm"'
  puts ' '*20 + 'to see the events on the previous year type "py"'
  puts ' '*20 + 'to return to the main menu type main'
  case gets.chomp
  when 'n'
    look_up_by_month(whole_month.to_date + 1.day)
  when 'p'
    look_up_by_month(whole_month.to_date - 1.day)
  when 'w'
    look_up_by_month(whole_month.to_date + 1.week)
  when 'm'
    look_up_by_month(whole_month.to_date + 1.month)
  when 'y'
    look_up_by_month(whole_month.to_date + 1.year)
  when 'pw'
    look_up_by_month(whole_month.to_date - 1.week)
  when 'pm'
    look_up_by_month(whole_month.to_date - 1.month)
  when 'py'
    look_up_by_month(whole_month.to_date - 1.year)
  when 'main'
    main_menu
  else
    puts 'that is not a valid option'
    change_month(whole_month)
  end
end



def add_events_interface
  puts 'What is the description for the new event?'
  new_description = gets.chomp
  puts "Where is the event?"
  new_location = gets.chomp
  puts "What date does the event start dd-mm-yyyy?"
  new_start_date = gets.chomp
  puts "What date does the event end dd-mm-yyyy?"
  new_end_date = gets.chomp
  puts "What time does the event start?"
  new_start_time = gets.chomp
  puts "What time does the event end?"
  new_end_time = gets.chomp
  new_event = Event.create({description: new_description, location: new_location, start_date: new_start_date, end_date: new_end_date, start_time: new_start_time, end_time: new_end_time})
  if new_event.save
  puts "'#{new_event.description}' has been added to your Calendar."
else
  puts "That wasn't a valid input.  Please try again"
  new_event.errors.full_messages.each { |message| puts message }
end
end

def list_events_by_date
  system('clear')
  events = []
  Event.all.each do |event|
    if event.start_date > Time.current
      events << event
    end
  end
  events.sort_by! {|event| event.start_date}

    #if any event dates are the same, check time and sort by time
  events.each do |event|
    puts "#{event.description} starts on #{event.start_date} and starts at #{event.start_time.strftime("%H:%M")}"
  end

  input = gets.chomp
end

def list_events_interface
  Event.all.each do |event|
    puts event.description
  end
  puts "Type delete to delete an event"
  puts "Type edit to edit an event"
  puts "Type go back to return to the main menu"
  case gets.chomp
  when 'delete'
    puts 'what event do you want to delete?'
    input = Event.find_by(description: gets.chomp)
    input.destroy
    puts "#{input.description} has been destroyed"
  when 'edit'
    puts "What event do you want to edit?"
    event = Event.find_by(description: gets.chomp)
    edit_event(event)
  when 'go back'
    main_menu
  else
    puts 'that is not a valid option'
  end
end

def edit_event(event)
  system('clear')
  puts "description: '#{event.description}'"
  puts "location: '#{event.location}'"
  puts "start_date: '#{event.start_date}'"
  puts "end_date: '#{event.end_date}'"
  puts "start_time: '#{event.start_time.strftime("Set to %H:%M")}'"
  puts "end_time: '#{event.end_time.strftime("Set to %H:%M")}' \n\n"
  puts "What do you want to edit?"
  column_to_edit = gets.chomp
  puts "What do you want to change '#{column_to_edit}' to?"
  updated_information = gets.chomp

  event.update(column_to_edit => updated_information)
  system('clear')
  puts "Here is the updated item!!\n\n"
  puts "description: '#{event.description}'"
  puts "location: '#{event.location}'"
  puts "start_date: '#{event.start_date}'"
  puts "end_date: '#{event.end_date}'"
  puts "start_time: '#{event.start_time.strftime("Set to %H:%M")}'"
  puts "end_time: '#{event.end_time.strftime("Set to %H:%M")}' \n\n"

  puts "type enter to return to the main menu"
  input = gets.chomp
  system('clear')
end


main_menu

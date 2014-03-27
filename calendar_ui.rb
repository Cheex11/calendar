require 'bundler/setup'
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])


def main_menu

  system('clear')
  choice = nil
  until choice == 'e'
    puts 'Welcome to your calendar'
    puts 'What do you want to do?'
    puts 'Type l to list all your events'
    puts 'Type a to add an event'
    puts 'Type e to exit'

    choice = gets.chomp
    case choice
    when 'l'
      list_events_interface
    when 'a'
      add_events_interface
    when 'e'
      puts 'Goodbye!'
    else
      puts 'Please enter a valid argument'
    end
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

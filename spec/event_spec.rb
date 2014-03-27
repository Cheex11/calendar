require 'spec_helper'

  event_hash = {description: 'Party', location: 'Park', start_date: '12/01/2014', end_date: '12/02/2014', :start_time => '2:00', end_time: '3:00'}

describe Event do
  it { should validate_presence_of :description }
  it { should validate_presence_of :location }
  it { should validate_presence_of :start_date }
  it { should validate_presence_of :end_date }
  it { should validate_presence_of :start_time }
  it { should validate_presence_of :end_time }

  it 'should initialize as a new event' do
    event = Event.create(event_hash)
    event.should be_an_instance_of Event
  end
end

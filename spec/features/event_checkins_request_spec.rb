require 'rails_helper'

describe "checkins page" do
  before(:each) do
    @event = create(:event)
    @event.event_sessions.first.update_attributes(name: 'Unique Session Name')

    @user = create(:user)
    organizer = create(:user)
    @event.organizers << organizer

    sign_in_as(organizer)
  end

  let!(:attendee_rsvp) { create(:volunteer_rsvp, event: @event, user: @user) }

  it "should render new rsvps without a page refresh" do
    visit event_event_session_checkins_path(@event, @event.event_sessions.first)
    expect(page).not_to have_content(@user.first_name)

    attendee_rsvp
    expect(page).to have_content(@user.first_name)
  end

  it "should remove rsvps without a page refresh" do
    attendee_rsvp
    visit event_event_session_checkins_path(@event, @event.event_sessions.first)
    expect(page).to have_content(@user.first_name)

    Rsvp.find(attendee_rsvp.id).destroy
    expect(page).not_to have_content(@user.first_name)
  end
end

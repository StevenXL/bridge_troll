class RsvpSessionSerializer < ActiveModel::Serializer
  attributes :id, :rsvp_id, :event_session_id, :created_at, :updated_at,
             :checked_in, :reminded_at, :role_id

  def role_id
    object.rsvp.role_id
  end
end

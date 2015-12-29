class RsvpSessionSerializer < ActiveModel::Serializer
  attributes :id, :rsvp_id, :event_session_id, :created_at, :updated_at,
             :checked_in, :reminded_at, :role_id, :user_link, :title,
             :gravatar_src, :width, :height, :user_full_name, :class_level,
             :waitlist_position

  delegate :user_gravatar, to: :scope

  private

  def attributes
    data = super

    if title == "Student"
      data[:levels_event_path] = levels_event_path(object.rsvp.event)
    end

    data
  end

  def class_level
    object.rsvp.class_level
  end

  def waitlist_position
    object.rsvp.waitlist_position
  end

  def title
    object.rsvp.role.title
  end

  def role_id
    object.rsvp.role_id
  end

  def user_link
    user_profile_path(user)
  end

  def nokogiri_doc
    @doc ||= Nokogiri::HTML(user_gravatar(user))
  end

  def gravatar_src
    nokogiri_doc.css('img').attr('src').value
  end

  def width
    nokogiri_doc.css('img').attr('width').value
  end

  def height
    nokogiri_doc.css('img').attr('height').value
  end

  def user
    object.rsvp.user
  end
end

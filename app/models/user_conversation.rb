class UserConversation < ApplicationRecord
  belongs_to :user
  belongs_to :group_conversation

  enum mute_duration: { eight_hours: 0, twenty_four_hours: 1, always: 2 }
  
  def mute!(duration)
    self.mute_duration = duration
    self.mute_expiry = calculate_mute_expiry(duration)
    save!
  end

  def unmute!
    self.mute_duration = nil
    self.mute_expiry = nil
    save
  end

  def muted?
    mute_expiry.present? && mute_expiry > Time.now
  end

  private

  def calculate_mute_expiry(duration)
    case duration.to_sym
    when :eight_hours
      Time.now + 8.hours
    when :twenty_four_hours
      Time.now + 24.hours
    when :always
      nil
    else
      raise ArgumentError, "Invalid duration: #{duration}"
    end
  end

  def minimum_two_members
    if user_ids.size < 2
      errors.add(:user_ids, "must have at least two members")
    end
  end
  
end
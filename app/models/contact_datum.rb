class ContactDatum < ApplicationRecord
  validates :email, uniqueness: true
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :email,presence:true,format:{with: VALID_EMAIL_REGEX}
  validates :age, numericality: true

  def self.by_id_or_email!(id, email)
    if id
      find_by!(id: id)
    else
      find_by!(email: email)
    end
  end
end

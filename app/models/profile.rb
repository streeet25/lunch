class Profile < ActiveRecord::Base
  belongs_to :user, inverse_of: :profile

  validates :last_name, presence: true
end

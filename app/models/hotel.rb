class Hotel < ActiveRecord::Base
  attr_accessible :adress, :include_breakfast, :price, :room_description, :title
  belongs_to :user

  validates :user_id, presence: true
end

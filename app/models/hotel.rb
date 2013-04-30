# == Schema Information
#
# Table name: hotels
#
#  id                :integer          not null, primary key
#  title             :string(255)
#  room_description  :text
#  include_breakfast :boolean
#  price             :float
#  adress            :string(255)
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Hotel < ActiveRecord::Base
  attr_accessible :adress, :include_breakfast, :price, :room_description, :title, :star_rate_hotel
  letsrate_rateable "stars"
  belongs_to :user

  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 140}
  validates :room_description, presence: true, length: {maximum: 1000}
  validates :adress, presence: true, length: {maximum: 1000}
  VALID_PRICE_REGEX = /(?!^0*$)(?!^0*\.0*$)^\d{1,5}(\.\d{1,3})?$/
  validates :price, presence: true, presence:true, format: {with: VALID_PRICE_REGEX}
  validates :include_breakfast, inclusion:{in: [true, false]}
  validates :star_rate_hotel, presence: true, inclusion: {in: 1..5}

  default_scope order: 'hotels.created_at DESC'
end

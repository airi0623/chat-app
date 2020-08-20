class Room < ApplicationRecord
  # Roomクラスメソッド
  has_many :room_users
  has_many :users, through: :room_users

  varidation :name, presence: true
end
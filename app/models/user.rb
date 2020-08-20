class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,  :validatable
  validates :name, presence: true
  #空のnameデータをデータベースに保存するのを防ぐ。

  has_many :room_users
  has_many :rooms, through: :room_users
end
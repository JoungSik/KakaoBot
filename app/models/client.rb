class Client < ApplicationRecord
  has_secure_password

  has_many :user_clients
  has_many :users, through: :user_clients

  validates_presence_of :name, :email, :phone, :uuid, :access_token, :refresh_token, :client_id
  validates_uniqueness_of :email, :phone, :uuid, :access_token, :refresh_token, :client_id
end

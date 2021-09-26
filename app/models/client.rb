class Client < ApplicationRecord
  has_many :rooms
  
  has_many :user_clients, dependent: :delete_all
  has_many :users, through: :user_clients

  accepts_nested_attributes_for :user_clients, reject_if: proc { |attributes| attributes['client'].present? }

  validates_presence_of :name, :email, :password, :phone, :uuid, :access_token, :refresh_token, :client_id
  validates_uniqueness_of :email, :phone, :uuid, :access_token, :refresh_token, :client_id
end

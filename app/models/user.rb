# frozen_string_literal: true

class User < ActiveRecord::Base

  include DeviseTokenAuth::Concerns::User

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable omniauth_providers: %i[facebook]
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :confirmable, :lockable, :timeoutable,
  :trackable, :omniauthable, omniauth_providers: %i[google_oauth2 facebook] # add omniauthable field and add the providers under omniauth_providers

  has_one_attached :avatar
  
  validates :name, presence: true
  validates :profile, presence: true
  validates :avatar, attached: false, content_type: %i[png jpg jpeg], size: { less_than: 5.megabytes }

  enum profile: { admin: 0, client: 1 }

  def self.signin_or_create_from_provider(provider_data)
    where(provider: provider_data[:provider], uid: provider_data[:uid]).first_or_create do |user|
      user.name = provider_data[:info][:name]
      user.image = provider_data[:info][:image]
      user.email = provider_data[:info][:email]
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation! # when you signup a new user, you can decide to skip confirmation
    end
  end
end

# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  encrypts :open_ai_token
  has_many :stories, dependent: :destroy

  validates :username, presence: true, uniqueness: true, length: { in: 3..20 }
  validates :password, length: { minimum: 6 }, if: :password_digest_changed?
end

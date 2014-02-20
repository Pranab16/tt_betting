class User < ActiveRecord::Base
  attr_protected
  validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true
  has_many :answers
end

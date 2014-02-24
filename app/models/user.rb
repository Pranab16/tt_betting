class User < ActiveRecord::Base
  attr_protected
  validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true
  has_many :answers
  validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
end

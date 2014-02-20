class Choice < ActiveRecord::Base
  attr_protected
  belongs_to :question
  has_many :answers
end

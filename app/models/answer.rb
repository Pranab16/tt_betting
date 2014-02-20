class Answer < ActiveRecord::Base
  attr_protected
  belongs_to :user
  belongs_to :choice
  belongs_to :question
end

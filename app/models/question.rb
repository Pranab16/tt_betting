class Question < ActiveRecord::Base
  attr_protected
  has_many :choices
  has_many :answers
  accepts_nested_attributes_for :choices

  #attr_accessible :name, :time_to_expire, :score, :choices_attributes
  has_one :choice


end

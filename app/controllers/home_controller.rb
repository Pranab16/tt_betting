class HomeController < ApplicationController
  before_filter :require_login

  def index
    @score = Question.joins(:answers).where("answers.user_id=#{@current_user.id} and answers.choice_id = questions.choice_id").sum('questions.score')
  end
end

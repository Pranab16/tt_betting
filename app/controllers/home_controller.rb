class HomeController < ApplicationController
  before_filter :require_login

  def index
    if @current_user.is_superuser
      #User.where
    else
      users_score = Question.joins(
          "INNER JOIN answers ON answers.choice_id = questions.choice_id"
      ).select(
          "answers.user_id, sum(questions.score) as user_score").group("answers.user_id").order("user_score DESC")

      @score = 0
      @rank = 0
      count = 1
      users_score.each do |user|
        if user.user_id == @current_user.id
          @rank = index + 1
          @score = user.user_score
          break
        end
        count += 1
      end

      if @rank == 0
        @rank = count
      end

    end

  end
end

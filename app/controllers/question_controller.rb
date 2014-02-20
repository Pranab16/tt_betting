class QuestionController < ApplicationController
  before_filter :require_login
  before_filter :require_admin, :only => [:new, :create, :current]
  before_filter :require_normal_user , :only => [:answered, :unanswered]

  def new
    @question = Question.new
    @question.choices.build
  end

  def create
    @question = Question.create!(params[:question])
    redirect_to question_current_path
  end

  def current
    @questions = Question.where("time_to_expire > ?", DateTime.now)
    answers = Answer.find_all_by_user_id(@current_user.id)
    @answer_hash = Hash[answers.map{|answer| [answer.question_id, answer.choice_id]}]
  end

  def expired
    @questions = Question.where("time_to_expire < ?", DateTime.now)
    if @current_user.is_superuser
      @answer_hash = Hash[@questions.map{|question| [question.id, question.choice_id]}]
    else
      answers = Answer.find_all_by_user_id(@current_user.id)
      @answer_hash = Hash[answers.map{|answer| [answer.question_id, answer.choice_id]}]
    end
  end

  def answered
    @questions = Question.joins(:answers).where(answers: {user_id: @current_user.id}).where("time_to_expire > ?", DateTime.now.utc)
    answers = Answer.find_all_by_user_id(@current_user.id)
    @answer_hash = Hash[answers.map{|answer| [answer.question_id, answer.choice_id]}]
  end

  def unanswered
    @questions = Question.joins(
        "LEFT OUTER JOIN answers ON answers.question_id = questions.id and answers.user_id = #{@current_user.id}"
    ).where("time_to_expire > ? and answers.question_id is null", DateTime.now.utc)
  end

  def answer
    if @current_user.is_superuser
      question = Question.find_by_id(params[:question])
      question.choice_id = params[:choice]
      question.save!
    else
      answer = Answer.where(user_id: @current_user.id, question_id: params[:question]).first_or_initialize
      answer.choice_id = params[:choice]
      answer.save!
    end
    render nothing: true
  end
end

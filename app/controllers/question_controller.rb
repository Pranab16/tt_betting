class QuestionController < ApplicationController
  before_filter :require_login
  before_filter :require_admin, :only => [:new, :create, :active, :inactive, :edit, :update]
  before_filter :require_normal_user , :only => [:answered, :unanswered, :show]

  def new
    @question = Question.new
    @question.choices.build
  end

  def create
    @question = Question.create!(params[:question])
    redirect_to question_active_path
  end

  def active
    @questions = Question.where("time_to_expire > ?", DateTime.now).where(is_active: true)
  end

  def inactive
    @questions = Question.where(is_active: false)
  end

  def expired
    if @current_user.is_superuser
      @questions = Question.where("time_to_expire < ? and questions.is_active = 1", DateTime.now).order("choice_id")
      @answer_hash = Hash[@questions.map{|question| [question.id, question.choice_id]}]
    else
      @questions = Question.where("time_to_expire < ? and questions.is_active = 1", DateTime.now)
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
    ).where("time_to_expire > ? and answers.question_id is null and questions.is_active = 1", DateTime.now.utc)
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

  def show
    @question = Question.find(params[:id])
  end

  def edit
    @question = Question.find(params[:id])
    if @question.is_active
      flash[:error] = 'Only inactive questions can be updated'
      redirect_to question_inactive_path
    end
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(params[:question])
      redirect_to question_inactive_path
    else
      render 'edit'
    end
  end
end

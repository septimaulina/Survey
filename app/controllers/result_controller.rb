class ResultController < ApplicationController
  
  def index
    @participants = Participant.all
    @question_groups = Rapidfire::QuestionGroup.all
  end

  def show
  	# @result = Rapidfire::AnswerGroup.where(question_group_id: params[:id])
  	# @results = @question_group
  	@question_group = Rapidfire::QuestionGroup.find(params[:id])
  	@results = Rapidfire::AnswerGroup.where(question_group_id: params[:id])

  end

  # get '/question_groups/:question_group_id/participants/:id'
  def participant
  	@question_group = Rapidfire::QuestionGroup.find(params[:question_group_id])
  	# @questions = @question_group.questions
  	@answer_group = Rapidfire::AnswerGroup.find_by(user_id: params[:id], question_group_id: params[:question_group_id] )
  	@answers = @answer_group.answers
  end

end
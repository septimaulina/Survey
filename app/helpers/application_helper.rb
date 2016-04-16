module ApplicationHelper

	def check_answer(question_group, user_id)
		@no = Rapidfire::AnswerGroup.where(user_id: user_id, question_group_id: question_group).size
		if (@no == 0 )
			# Already answer
			return true
		else
			# not yet
			return false
		end
	end

	# check score based on positive and answer
	# sometimes need refactor
	def score(positive, answer)
		answer = answer.to_s.downcase.delete(' ')
		if positive == true
			case 
			when answer == 'sangatsesuai'
				return 4
			when answer == 'sesuai'
				return 3
			when answer == 'tidaksesuai'
				return 2
			else
				return 1
			end
		else
			case 
			when answer == 'sangatsesuai'
				return 1
			when answer == 'sesuai'
				return 2
			when answer == 'tidaksesuai'
				return 3
			else
				return 4
			end
		end
	end

	# calculate score per aspect
	# return number kurang dari max score per aspek
	def score_aspect(question_group_id, user_id)
		n = 0
		# @question_group = Rapidfire::QuestionGroup.find(question_group_id)
	  	# @questions = @question_group.questions
	  	@group = Rapidfire::AnswerGroup.find_by(user_id: user_id, question_group_id: question_group_id )
	  	@answers = @group.try(:answers)

	  	unless @answers.nil?
			@answers.each do |answer|
				n = n+score(answer.question.positive,answer.answer_text)
			end	
		end

		return n.to_f
	end

	# Return number of total score
	def score_category(user_id)
		@question_groups = Rapidfire::QuestionGroup.all
		@score_category = 0

		@question_groups.each do |group| 
	        @score_aspect = score_aspect(group.id, user_id).to_f 
	        @score_category += @score_aspect
	    end
        
        return @score_category.to_f
	end

	# get total question
	# return number
	def  total_questions
		@question_groups = Rapidfire::QuestionGroup.all
		n = 0
			@question_groups.each do |group| 
				n += group.questions.size
			end
		
		return n.to_f
	end

	# Return string category
	def get_category_by_score(score)
		score = score.to_f
		@sedang = 105
		@rendah = 75

		@max = (total_questions).to_f * 4
		@min = (total_questions).to_f * 1
		@mean =  (total_questions).to_f * 3
		@deviasi = 1/6.to_f*(@max.to_f-@min.to_f)

		@rendah = @mean - 1.0 * @deviasi 
		@sedang = @mean + 1.0 * @deviasi 

		case score
		when @min..@rendah-1
			return 'Rendah'
		when @rendah..@sedang-1
			return 'Sedang'
		when @sedang..@max
			return 'Tinggi'
		else
			return 'Uncategorize'
		end
	end

end

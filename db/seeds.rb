User.destroy_all
User.create!(admin: true, name: 'admin', email: 'admin@admin.com', password: 'password', nisn: 101)

# create new class or user group
UserGroup.delete_all
group_list = [
  '1 A',
  '1 B',
  '1 C'
]
group_list.each do |name|
  UserGroup.create!(name: name)
  # create new participant
	3.times do
		Participant.create!({
			name: Faker::Name.name,
			nisn: Faker::Number.number(10),
			user_group_id: UserGroup.last.id,
			password: '12345'})
		# Exam.create!({name: Faker::Hacker.adjective})
	end
end

question_group_list = [
  'Tanggung Jawab',
  'Fleksibel',
  'Ketrampilan',
  'Komunikasi',
  'Pandangan terhadap diri sendiri',
  'Keselamatan dan kesehatan kerja',
]
Rapidfire::QuestionGroup.destroy_all
Rapidfire::Question.destroy_all
question_group_list.each do |group|
	Rapidfire::QuestionGroup.create!(name: group)
	5.times do
		Rapidfire::Question.create!({
			question_group_id: Rapidfire::QuestionGroup.last.id,
			question_text: Faker::Hacker.say_something_smart,
			answer_options: "Sangat Sesuai \n Sesuai \n Tidak Sesuai \n Sangat Tidak Sesuai",
			type: 'Rapidfire::Questions::Radio',
			positive: rand(2),
			})
	end
end
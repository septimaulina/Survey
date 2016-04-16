class Participant < ActiveRecord::Base
	 default_scope { where(admin: false) }
	# before_save :default_values
	devise :database_authenticatable, :validatable

	def email_required?
  		false
	end

	belongs_to :user_group

	self.table_name = 'users'
	
	validates :name, :nisn, :user_group_id, presence: true
	validates :nisn, uniqueness: true, length: { is: 10 }

end

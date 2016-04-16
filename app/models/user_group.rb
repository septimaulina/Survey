class UserGroup < ActiveRecord::Base
	has_many :participants
end

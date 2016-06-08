class Talk < ActiveRecord::Base
	has_many :comments,:dependent=>:destroy
	has_many :talk_users,:dependent=>:destroy
	has_many :users,:through=>:talk_users
end

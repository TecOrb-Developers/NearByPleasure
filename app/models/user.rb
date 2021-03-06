class User < ActiveRecord::Base
	# mount_uploader :image, ImageUploader
	has_secure_password
	has_many :tickets,:dependent=> :destroy
	has_many :ticket_comments,:dependent=> :destroy
	has_many :socialauths,:dependent=> :destroy
	has_many :bookmarks,:dependent=> :destroy
	has_many :recent_checks,:dependent => :destroy
	has_many :reviews, :dependent=>:destroy
	has_many :talks,:dependent=>:destroy
	has_many :comments,:dependent=>:destroy
	has_many :talk_users,:dependent=>:destroy
	has_many :talks,:through=>:talk_users
	has_many :subcategories,:dependent=> :destroy
end

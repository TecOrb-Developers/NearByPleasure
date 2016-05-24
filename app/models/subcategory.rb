class Subcategory < ActiveRecord::Base
  belongs_to :category
	has_many :images,:dependent=>:destroy
	has_many :recent_checks,:dependent => :destroy
	has_many :bookmarks,:dependent=> :destroy
	has_many :reviews, :dependent=>:destroy
end

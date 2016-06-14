class Subcategory < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
	has_many :images,:dependent=>:destroy
	has_many :recent_checks,:dependent => :destroy
	has_many :bookmarks,:dependent=> :destroy
	has_many :reviews, :dependent=>:destroy
	has_many :tickets, :dependent=>:destroy

	acts_as_mappable :default_units => :miles,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude
end

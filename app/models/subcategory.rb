class Subcategory < ActiveRecord::Base
  belongs_to :category
	has_many :images,:dependent=>:destroy
end

class RecentCheck < ActiveRecord::Base
  belongs_to :user
  belongs_to :subcategory
end

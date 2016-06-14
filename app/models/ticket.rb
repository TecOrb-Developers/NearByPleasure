class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :subcategory
  has_many :ticket_comments,:dependent=> :destroy
end
